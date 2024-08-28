# Quickstart Guide

## What is this

This is a github repo that sets up a running openshift cluster and launches a demo from [WorkShops Repo](https://github.com/poc-examples/workshops) using the rollsout-controller helm chart at [rollout-controller helm chart](https://github.com/poc-examples/charts/tree/main/charts/rollout-controller).

It uses the following ansible repos

- [gitops role](https://github.com/poc-examples/ansible-roles)
- [secrets-manager role](https://github.com/poc-examples/secrets-manager-role)

It uses the following terraform modules for infra

- [terraform-clusters](https://github.com/poc-examples/terraform-clusters)

## Getting Started

### Prerequisites

    - Podman Installed
    - Linux

### Pick the Workshop

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
make deploy
```

## How It Works

This project leverages Ansible for the deployment of GitOps tools within an OpenShift environment, enabling secure, dynamic provisioning of secrets from services like Azure Key Vault or AWS Secrets Manager directly into the cluster. Concurrently, it adopts GitOps practices using tools such as ArgoCD to automate and manage deployments based on Git as the single source of truth. 

This integrated approach ensures secure access to up-to-date credentials and streamlines application lifecycle management, enhancing operational efficiency, security, and compliance in cloud-native ecosystems.

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
