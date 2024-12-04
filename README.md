# Cluster Bootstrapper

Cluster Bootstrapper is a GitHub repository designed to set up an OpenShift cluster and deploy demos from the [Workshops Respository](https://github.com/poc-examples/workshops) which uses the [rollout-controller](https://github.com/poc-examples/charts/tree/main/charts/rollout-controller) helm chart.

These charts work together to provide an easy/quick demonstration platform for previewing Red Hat OpenShift products.  Note: This is not intended for best-practice implementation.

**Status: Pre-alpha**

## Available Demos

- [Catalog of Workshops](https://poc-examples.github.io/cluster-bootstrapper/workshops/index.html)

## Quickstart Guide
- [Prerequisites](https://poc-examples.github.io/cluster-bootstrapper/quickstart/prerequisites.html)
- [Quick Start Guide](https://poc-examples.github.io/cluster-bootstrapper/quickstart/quickstart.html)
- [Troubleshooting](https://poc-examples.github.io/cluster-bootstrapper/quickstart/troubleshooting.html)

## Deployment Time Expectations
- AWS ROSA - 40min cluster build + 15min workshops deployment
- AWS HCP - Available in future updates
- Azure - Available in future updates
- ARO - Available in future updates

## Considerations

For live systems, ensure you have robust IAM policies and access controls in place to secure the cloud secret stores.

## Contributing

Please read [CONTRIBUTING.md](https://github.com/poc-examples/cluster-bootstrapper/blob/main/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use SemVer for versioning. For the versions available, see the tags on this repository.

## Authors

See the list of contributors who participated in this project.

## License

This project is licensed under the LICENSE.md file for details.

## Acknowledgments

Thanks to anyone whose code was used Inspiration.