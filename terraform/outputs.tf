output "api_url" {
    value       = module.openshift_cluster.api_url
    sensitive   = true
}

output "domain" {
    value       = module.openshift_cluster.domain
    sensitive   = true
}
