# docker-kustomize

A Docker image to run standalone Kubernetes [kustomize](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/) as a Docker container.

## Usage

```
$ docker run -it --rm \
    -v /path/to/kustomize/dir:/workdir \
    adambabik/kustomize:3.6.1-kubectl1.18.0 \
    build overlays/staging
```
