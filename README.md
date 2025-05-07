# Cluster Bootstrapper

Cluster Bootstrapper is a multi-cluster orchestration tool designed for spinning up OpenShift-based demo environments([Workshops Respository](https://github.com/poc-examples/workshops)) that simulate real-world topologies. It automates infrastructure creation, GitOps setup([rollout-controller](https://github.com/poc-examples/charts/tree/main/charts/rollout-controller)), shared services bootstrapping (e.g. Vault, ArgoCD, DevHub), and workload deployment across dev/test/prod or hybrid cloud setups.

>⚠️ Not production-grade. 
> This is a rapid prototyping and enablement tool for internal teams and POCs. Built to show what's possible, not how to do it in production.

## What It Does

- Deploys one or more OpenShift clusters using Terraform (ROSA, HCP, ARO, or local)
- Bootstraps shared services (Vault, ArgoCD, DevHub, External Secrets)
- Configures per-cluster workloads using Helm ApplicationSets
- Syncs secrets and config across clusters via a shared Vault
- Supports over-the-shoulder enablement workflows for teams to experiment

## Available Demos

- [Catalog of Workshops](https://poc-examples.github.io/cluster-bootstrapper/workshops/index.html) (Backed by rollout-controller chart)

## Quickstart Guide
- [Architecture](https://poc-examples.github.io/cluster-bootstrapper/quickstart/architecture.html)
- [Prerequisites](https://poc-examples.github.io/cluster-bootstrapper/quickstart/prerequisites.html)
- [Quickstart Guide](https://poc-examples.github.io/cluster-bootstrapper/quickstart/quickstart.html)
- [Troubleshooting](https://poc-examples.github.io/cluster-bootstrapper/quickstart/troubleshooting.html)

## Deployment Time Expectations
| Platform | Cluster Build | Settle Time | Workload Deploy |
| -------- | ------------- | ----------- |---------------- |
| AWS ROSA | ~40 min       | ~5 min      |~15 min          | 
| AWS HCP  | Coming Soon   |             |                 |
| Azure/ARO| ~40 min       | ~5 min      |~15 min          |
| ARO      | Coming Soon   |             |                 |

- Settle Time: The time it takes for the cluster kubeadmin pods to settle after cluster creation before running the `make configure`
- Workload Deploy: The time it takes for azure to deploy the workshop charts via GitOps

## Considerations

If adapting this for real environments, you’ll need to implement:
- Secure Secrets Management
- Identity & access controls
- Vault unsealing strategy (if not using dev mode)

## Contributing

See [CONTRIBUTING.md](https://github.com/poc-examples/cluster-bootstrapper/blob/main/CONTRIBUTING.md) for guidelines.

## Versioning

We use [SemVer](https://semver.org/ ). Tags reflect each release.

## Authors & Acknowledgments

See the list of contributors who participated in this project.
Thanks to all upstream charts and tools integrated into this platform.
