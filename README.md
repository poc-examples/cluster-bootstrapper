# Quickstart Guide

## What is Cluster Bootstrapper

Cluster Bootstrapper is a github repo that sets up a running openshift cluster and launches demos from [WorkShops Repo](https://github.com/poc-examples/workshops) using the rollout-controller helm chart at [rollout-controller helm chart](https://github.com/poc-examples/charts/tree/main/charts/rollout-controller).

## Available WorkShops

- [See Available WorkShops](https://github.com/poc-examples/workshops)

## Getting Started

1. Ensure the Pre-Requisites are met

- Podman Installed
- Linux w/ make

2. Clone the Cluster Boostrapper

```
git clone https://github.com/poc-examples/cluster-bootstrapper.git
```

3. Set the following environment variables

**ROSA_TOKEN**: Provided by [Cloud Console](https://console.redhat.com/openshift/token/show)
**CLUSTER_USERNAME**: A username that can be used to log into the cluster
    - *ie. `cluster-admin`*
**CLUSTER_PASSWORD**: A password that can be used to log into the cluster
    - Should be 14+ chars, upper and lower, with special characters
**AWS_ACCESS_KEY_ID**: Programmatic Access Key w/ rights to provision OpenShift
**AWS_SECRET_ACCESS_KEY**: Programmatic Secret for AWS Account

4. Configure the WorkShop

config.workshop

5. Run Cluster Bootstrapper

```
make podman_test_build
make podman_test_configure
```

6. Login to the cluster using [Cloud Console](https://console.redhat.com/openshift/cluster-list) in your cluster lists and follow the instructions for the workshop in the [WorkShops Repo](https://github.com/poc-examples/workshops)

7. Clean Up

When you're done with the demo you can destroy the cluster using:

```
make podman_test_cleanup
```

## Deployment Time Expectations

- AWS ROSA - 40min cluster build + 15min workshops deployment
- AWS HCP - Available in future updates
- Azure - Available in future updates
- ARO - Available in future updates

## How Does Cluster Bootstrapper Work

The Cluster Bootstrapper project automates the creation and management of OpenShift clusters in cloud environments using Terraform and Ansible. The process begins with Terraform, which provisions the required infrastructure. Ansible is then used to deploy GitOps tools, such as ArgoCD, to manage application lifecycle.

It uses the following ansible collections to do the initial configuration:

1. [GitOps Operator](https://github.com/poc-examples/ansible-collections/tree/main/bootstrap/workshop/roles/gitops-operator)
    - Installs the OpenShift GitOps Operator
2. [GitOps Instance](https://github.com/poc-examples/ansible-collections/tree/main/bootstrap/workshop/roles/gitops-instance)
    - Deploys ArgoCD w/ custom health checks
    - Enables Progressive Syncs & ApplicationSets
    - Launches the Workshop from [Workshops](https://github.com/poc-examples/workshops/tree/main/charts)
3. [Secrets Manager](https://github.com/poc-examples/secrets-manager-role)
    - Sets up the namespace secrets-manager for secrets used by the overlaying workshop and cluster configuration.
    - Prepares the namespace for [External Secrets Kubernetes Provider](https://external-secrets.io/latest/provider/kubernetes/)
    - Prepares the namespace for [External Secrets HashiCorp Vault Provider](https://external-secrets.io/latest/provider/hashicorp-vault/)

It uses the following terraform modules to build the infra:

- [terraform-clusters](https://github.com/poc-examples/terraform-clusters)

## Considerations

For live systems, ensure you have robust IAM policies and access controls in place to secure the cloud secret stores.

## Contributing

Please read [CONTRIBUTING.md](https://github.com/poc-examples/cluster-bootstrapper/blob/main/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use SemVer for versioning. For the versions available, see the tags on this repository.

## Authors

See also the list of contributors who participated in this project.

## License

This project is licensed under the LICENSE.md file for details.

## Acknowledgments

Thanks to anyone whose code was used Inspiration.
