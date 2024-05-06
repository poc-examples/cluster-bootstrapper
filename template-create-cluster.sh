#!/bin/bash

# required to set

# ocm token
export TF_VAR_ocm_token=

# name of cluster to provision
export TF_VAR_cluster_name=


# Uncomment to set AWS region (default is us-east-1)
# export TF_VAR_aws_region=

# Uncomment to set OCP version (default is 4.15.0)
# TF_VAR_rosa_openshift-version=4.15.0 & TF_VAR_rosa_openshift_version_short=4.15
# export TF_VAR_rosa_openshift_version=
# export TF_VAR_rosa_openshift_version_short=

# Uncomment to set worker nodes (default is 2)
# export TF_VAR_worker_node_replicas=

# Uncomment to set environment (default is production)
# export TF_VAR_ocm_environment=

cd terraform
terraform init
terraform plan

# requires manual approval before actual execution
terraform apply
