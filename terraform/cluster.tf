data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}

resource "random_string" "random_name" {
  length           = 6
  special          = false
  upper            = false
}

locals {
  path = coalesce(var.path, "/")
  region_azs = slice([for zone in data.aws_availability_zones.available.names : format("%s", zone)], 0, 1)
  sts_roles = {
    role_arn         = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role${local.path}${local.cluster_name}-Installer-Role",
    support_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role${local.path}${local.cluster_name}-Support-Role",
    instance_iam_roles = {
      master_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role${local.path}${local.cluster_name}-ControlPlane-Role",
      worker_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role${local.path}${local.cluster_name}-Worker-Role"
    },
    operator_role_prefix = local.cluster_name,
    oidc_config_id       = rhcs_rosa_oidc_config.oidc_config.id
  }
  worker_node_replicas = coalesce(var.worker_node_replicas, 2)
  cluster_name = coalesce(var.cluster_name, "rosa-${random_string.random_name.result}")
}

resource "rhcs_cluster_rosa_classic" "rosa_sts_cluster" {
  name                 = local.cluster_name
  cloud_region         = local.config.openshift.region
  multi_az             = false
  aws_account_id       = data.aws_caller_identity.current.account_id
  admin_credentials    = local.config.openshift.admin_credentials
  availability_zones   = ["${local.config.openshift.region}a","${local.config.openshift.region}b", "${local.config.openshift.region}c"]
  tags                 = var.additional_tags
  version              = var.rosa_openshift_version
  compute_machine_type = var.machine_type
  replicas             = local.worker_node_replicas
  autoscaling_enabled  = false
  sts                  = local.sts_roles
  properties = {
    rosa_creator_arn = data.aws_caller_identity.current.arn
  }
  machine_cidr     = var.vpc_cidr_block

  lifecycle {
    precondition {
      condition     = can(regex("^[a-z][-a-z0-9]{0,13}[a-z0-9]$", local.cluster_name))
      error_message = "ROSA cluster name must be less than 16 characters, be lower case alphanumeric, with only hyphens."
    }
  }

  depends_on = [time_sleep.wait_10_seconds]
}

resource "rhcs_cluster_wait" "wait_for_cluster_build" {
  cluster = rhcs_cluster_rosa_classic.rosa_sts_cluster.id
  timeout = 60 # minutes
}

output "api_url" {
  value       = rhcs_cluster_rosa_classic.rosa_sts_cluster.api_url
  description = "URL of the API server."
}

output "ccs_enabled" {
  value       = rhcs_cluster_rosa_classic.rosa_sts_cluster.ccs_enabled
  description = "Enables customer cloud subscription (Immutable with ROSA)"
}

output "console_url" {
  value       = rhcs_cluster_rosa_classic.rosa_sts_cluster.console_url
  description = "URL of the console."
}

output "current_version" {
  value       = rhcs_cluster_rosa_classic.rosa_sts_cluster.current_version
  description = "The currently running version of OpenShift on the cluster."
}

output "domain" {
  value       = rhcs_cluster_rosa_classic.rosa_sts_cluster.domain
  description = "DNS domain of cluster."
}

output "external_id" {
  value       = rhcs_cluster_rosa_classic.rosa_sts_cluster.external_id
  description = "Unique external identifier of the cluster."
}

output "id" {
  value       = rhcs_cluster_rosa_classic.rosa_sts_cluster.id
  description = "Unique identifier of the cluster."
}

output "infra_id" {
  value       = rhcs_cluster_rosa_classic.rosa_sts_cluster.infra_id
  description = "The ROSA cluster infrastructure ID."
}

output "ocm_properties" {
  value       = rhcs_cluster_rosa_classic.rosa_sts_cluster.properties
  description = "Merged properties defined by OCM and the user-defined 'properties'."
}

output "state" {
  value       = rhcs_cluster_rosa_classic.rosa_sts_cluster.state
  description = "State of the cluster."
}
