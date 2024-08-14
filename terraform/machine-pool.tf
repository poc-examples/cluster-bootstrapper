resource "rhcs_machine_pool" "gpu_machine_pool" {
    cluster                           = rhcs_cluster_rosa_classic.rosa_sts_cluster.id
    name                              = "gpu-machine-pool"
    machine_type                      = "p3.8xlarge"
    replicas                          = 1
    autoscaling_enabled               = false

    depends_on = [
        rhcs_cluster_rosa_classic.rosa_sts_cluster
    ]
}
