Images
======

This directory builds containers with Mantle/ZLog binaries and pushes them to
an internal registry. It uses a custom builder image, structured using the
scripts in [docker-cephdev](https://github.com/systemslab/docker-cephdev/wiki).

Usage
-----

1. Build the daemon image:

    ```
    ./build.sh
    ```

2. Push daemon image to internal registry:

    ```
    REGISTRY_IP=<IP> ./push.sh
    ```
