## Getting Started

This guide will help you get started with the **Cluster Bootstrapper**.

## Before Starting

Check that the **[pre-requisites](prerequisites.md)** are met.

## Usage

1. Clone the repository and move to the repository directory:

   ```bash
   git clone https://github.com/poc-examples/cluster-bootstrapper.git
   cd cluster-bootstrapper
   ```

2. Export Credentials:

   Set the following Environment Variables.

   ```bash
   export CLUSTER_USERNAME="cluster-admin"
   export CLUSTER_PASSWORD="Password1234!"
   export ROSA_TOKEN="<PROVIDED_BY_RED_HAT>"
   export AWS_ACCESS_KEY_ID="<PROVIDED_BY_AWS>"
   export AWS_SECRET_ACCESS_KEY="<PROVIDED_BY_AWS>"
   ```

   > Note: 
   >  * `CLUSTER_PASSWORD`: should be at least 14+ chars, upper and lower, with special characters. 
   >  * `ROSA_TOKEN`: can be obtained at [Red Hat Console](https://console.redhat.com/).

3. Provide a Start-Up Helm Chart

   - List of pre-made demo helm charts.  See [Workshops](https://github.com/poc-examples/workshops/blob/main/docs/README.md)
