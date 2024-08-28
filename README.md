# Quickstart Guide

## What is this

This is a github repo that sets up a running openshift cluster and launches a demo from [WorkShops Repo](https://github.com/poc-examples/workshops) using the rollout-controller helm chart at [rollout-controller helm chart](https://github.com/poc-examples/charts/tree/main/charts/rollout-controller).

It uses the following ansible repos to do the initial configuration:

- [gitops role](https://github.com/poc-examples/ansible-roles)
- [secrets-manager role](https://github.com/poc-examples/secrets-manager-role)

It uses the following terraform modules to build the infra:

- [terraform-clusters](https://github.com/poc-examples/terraform-clusters)

## Getting Started

### Prerequisites

    - Podman Installed
    - Linux

### Pick the Workshop Demo

- [WorkShop Repo](https://github.com/poc-examples/workshops)

### Clone the Repo

```
git clone https://github.com/poc-examples/cluster-bootstrapper.git
```

### Export Variables

```
export AWS_ACCESS_KEY_ID=<your-key>
export AWS_SECRET_ACCESS_KEY=<your-key>
```

### Configure vars.yaml

Open the var.example.yaml file and configure it to point to the workshop chart you want.  Then change the name to var.yaml

```
cp vars.example.yaml vars.yaml
```

### Build the Demo

Run the make script to deploy the demo.

```
make podman_deploy
```

## How It Works

The Cluster Bootstrapper project automates the creation and management of OpenShift clusters in cloud environments using Terraform and Ansible. The process begins with Terraform, which provisions the required infrastructure. Ansible is then used to deploy GitOps tools, such as ArgoCD, to manage application lifecycle.

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
