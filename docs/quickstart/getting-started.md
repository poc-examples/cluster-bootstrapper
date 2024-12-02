# Getting Started

This guide will help you get started with the **Cluster Bootstrapper**.

## Before Starting

Check that the pre-requisites are met. See [Prerequisites](prerequisites.md)

## Usage Steps

1. Clone the repository and move into the cloned directory:

   ```bash
   git clone https://github.com/poc-examples/cluster-bootstrapper.git cluster-bootstrapper
   cd cluster-bootstrapper
   ```

2. Export Credentials:

   ```bash
   export AWS_ACCESS_KEY_ID=<YOUR_AWS_ACCESS_KEY_ID>
   export AWS_SECRET_ACCESS_KEY=<YOUR_AWS_SECRET_ACCESS_KEY>
   export ROSA_TOKEN=<YOUR_ROSA_TOKEN_FROM_CLOUD_CONSOLE>
   export CLUSTER_USERNAME=<YOUR_CLUSTER_ADMIN_USERNAME>
   export CLUSTER_PASSWORD=<YOUR_CLUSTER_ADMIN_PASSWORD>
   ```

3. Provide a Start-Up Helm Chart

   - List of pre-made demo helm charts.  See [Workshops](https://github.com/poc-examples/workshops/blob/main/docs/README.md)
