# Quickstart Guide

Cluster Bootstrapper is a GitHub repository designed to set up an OpenShift cluster and deploy demos from [Workshops](https://github.com/poc-examples/workshops) that uses the [rollout-controller](https://github.com/poc-examples/charts/tree/main/charts/rollout-controller) helm chart.

These charts work together to provide a quick demonstration platform for previewing Red Hat OpenShift products.  Note: This is not intended for best-practice implementation.

**Status: Pre-alpha**

## What is a WorkShop

A "Workshop" consists of:
1. Workshop Chart: Configures the demonstration environment.
2. Workflow Script: Works with the chart and guide the user through the demo.

### Available WorkShops

- [See Available WorkShops](https://github.com/poc-examples/workshops)



## Feature
- Builds OpenShift clusters across supported clouds
- Configures OpenShift GitOps
- Manages Secrets
- Deploys Helm Charts to configure the cluster

## Quick Links
- [Prerequisites](getting-started/prerequisites.md)
- [Getting Started](getting-started/getting-started.md)
- [Available Demos](installation.md)

