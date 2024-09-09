terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.20.0"
    }
    rhcs = {
      version = ">= 1.6.0"
      source  = "terraform-redhat/rhcs"
    }
  }
}

provider "rhcs" {
  token = local.config.openshift.offline_token
  url   = "https://api.openshift.com"
}

provider "aws" {
  region = local.cluster_config.region
  ignore_tags {
    key_prefixes = ["kubernetes.io/"]
  }
}

locals {

    config = yamldecode(file("../vars.yaml"))

    available_providers = toset([
        "azure", 
        "gcp", 
        "aws"
    ])
  
    cloud_provider = one([ 
        for key in local.available_providers : 
            key if contains(keys(local.config.openshift), key) 
    ])

    cluster_config   = lookup(
        local.config.openshift, 
        local.cloud_provider, 
        null
    )

}
