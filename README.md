# docker-kustomize

A Docker image to run standalone Kubernetes [kustomize](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/) as a Docker container.

## Usage

To generate Kubernetes objects, start a container with a volume pointing at a directory containing your Kustomize files and mount it into `/workdir/` in the container. `kustomize` is container's entrypoint, so it's enough to pass a command `build` and a directory to build.

For example, having the following structure:

```
./k8s/
├── base/
│   ├── app.config.yaml
│   ├── deployment.yaml
│   └── kustomization.yaml
└── overlays/
    ├── local/
    │   ├── app.config.yaml
    │   └── kustomization.yaml
    ├── prod-eu/
    │   ├── app.config.yaml
    │   ├── deployment-patch.yaml
    │   └── kustomization.yaml
    ├── prod-us/
    │   ├── app.config.yaml
    │   ├── deployment-patch.yaml
    │   └── kustomization.yaml
    └── staging/
        ├── app.config.yaml
        ├── deployment-patch.yaml
        └── kustomization.yaml
```

It is possible to generate Kubernetes objects for staging like this:

```
$ docker run -it --rm \
    -v /path/to/k8s:/workdir \
    adambabik/kustomize \
    build overlays/staging
```

The generated Kubernetes configuration

## LICENSE

MIT
