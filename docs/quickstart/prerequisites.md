## Prerequisites

Under the hood this bootstrapper runs using the **[bootstrapper container](https://github.com/poc-examples/container-library/blob/main/tools/bootstrapper/Dockerfile)** pulled from **[dockerhub](https://hub.docker.com/repository/docker/cengleby86/bootstrapper/general)**.  The container contains the versioned software required to run the bootstrapping processes. 

Currently, this bootstrapper is executed using make targets located in the root repository **[makefile](https://github.com/poc-examples/cluster-bootstrapper/blob/main/makefile)** in order to simplify set up commands.

## System Requirements

- Operating System: Linux
- Available AWS Account
    - User Account
        - Account Keys w/ CLI Programmatic Access
        - Bound to the Administrator Role
- Rosa Token
    - Available from **[console](https://console.redhat.com/openshift/token/show)**
- Installed Packages:
    - **[Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)**
    - **[Podman](https://podman.io/docs/installation)**
    - **[Make](https://www.gnu.org/software/make/manual/make.html)**

Next: Once requirements are met you can pull the source files and build your cluster. See **[QuickStart Guide](quickstart.md)**
