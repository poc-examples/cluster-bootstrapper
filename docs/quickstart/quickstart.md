## Getting Started

This guide will help you get started with the **Cluster Bootstrapper**.

## Before Starting

Check that the **[pre-requisites](prerequisites.md)** are met.

## Usage 

1. Clone the repository and change to the created directory:

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

3. Open & Configure `config.yaml`:

   In the root of the repository is the workshop.yaml configuration file.  This configuration can use environmental variables or can be hard coded.  To use environment variables in the `workshop.yaml` file try to following syntax "{% raw %}{{ ENV_NAME }}{% endraw %}".

   The first block `openshift` configures the cluster.  You shouldn't need to adjust these parameters.

   ```yaml
   openshift:

     aws:
       type: rosa
       cluster_name: demo-cluster-1 # Your cluster name
       version: 4.16.18
       region: us-east-2
       workers: 7

     admin:
       credentials:
         username: "{% raw %}{{ CLUSTER_USERNAME }}{% endraw %}" # Uses Environment Variable CLUSTER_USERNAME
         password: "{% raw %}{{ CLUSTER_PASSWORD }}{% endraw %}" # Uses Environment Variable CLUSTER_PASSWORD

     offline_token: "{% raw %}{{ ROSA_TOKEN }}{% endraw %}" # Uses Environment Variable ROSA_TOKEN
   ```

   The second block `config` allows you to point to any available demo chart. See **[Available Workshops](https://poc-examples.github.io/workshops/)**.  Make sure `workshop.chart` is `enabled` and the rest of the settings match those seen in **[Available Workshops](https://poc-examples.github.io/workshops/)**.

   ```yaml
   config:

     validate_certs: false

     gitops:
       enabled: true
       channel: gitops-1.14
       namespace: openshift-gitops

     workshop:
       chart:
         enabled: true
         name: rhoai-devex
         version: 0.2.1
         repo: https://poc-examples.github.io/workshops

     secrets:
       vault:
         enabled: true
       namespace: secrets-manager
       pushSecrets: []
   ```

4. Build and Configure the Cluster

   ```bash
   make build
   make configure
   ```

   Check the outputs for the `console url` to login directly to the cluster.  From Here you can follow the workflows in the workshop at **[Available Workshops](https://poc-examples.github.io/workshops/)**.

   When you are finished with the demo the cluster can be cleaned up with:

   ```bash
   make cleanup
   ```
