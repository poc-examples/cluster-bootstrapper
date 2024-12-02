## Prerequisites

Under the hood this bootstrapper runs using the **[bootstrapper container](https://github.com/poc-examples/container-library/blob/main/tools/bootstrapper/Dockerfile)** pulled from **[dockerhub](https://hub.docker.com/repository/docker/cengleby86/bootstrapper/general)**.  The container contains the versioned software required to run the bootstrapping processes. 

Currently, this bootstrapper is executed using make targets located in the root **[makefile](https://github.com/poc-examples/cluster-bootstrapper/blob/main/makefile)** in order to simplify set up commands.

## System Requirements

- Operating System: Linux
- Packages:
    - **[Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)**
    - **[Podman](https://podman.io/docs/installation)**
    - **[Make](https://www.gnu.org/software/make/manual/make.html)**

Once requirements are met you can pull the source files and build your cluster. See **[Getting Started](getting-started.md)**

## References

- 
