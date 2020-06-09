#!/usr/bin/env bash
set -Eeuo pipefail

KUBECTL_VER=${KUBECTL_VER:-1.18.0}
KUSTOMIZE_VER=${KUSTOMIZE_VER:-3.6.1}

PROJECT=adambabik/kustomize
IMAGE_NAME_FULL=${PROJECT}:${KUSTOMIZE_VER}-kubectl${KUBECTL_VER}
IMAGE_NAME_KUSTOMIZE_ONLY=${PROJECT}:${KUSTOMIZE_VER}
IMAGE_NAME_LATEST=${PROJECT}:latest

LATEST=${LATEST:-0}

docker build \
    --build-arg="KUSTOMIZE_VER=${KUSTOMIZE_VER}" \
    --build-arg="KUBECTL_VER=${KUBECTL_VER}" \
    -t ${IMAGE_NAME_FULL} .

docker push ${IMAGE_NAME_FULL}

if [ "$LATEST" -eq "1" ]; then
    docker tag ${IMAGE_NAME_FULL} ${IMAGE_NAME_KUSTOMIZE_ONLY}
    docker tag ${IMAGE_NAME_FULL} ${IMAGE_NAME_LATEST}

    docker push ${IMAGE_NAME_KUSTOMIZE_ONLY} ${IMAGE_NAME_LATEST}
fi
