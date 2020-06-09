FROM golang:alpine AS builder

ARG KUBECTL_VER
ARG KUSTOMIZE_VER

RUN apk update && apk add --no-cache curl

RUN mkdir /workdir
WORKDIR /workdir

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VER}/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl

RUN curl -O -L https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VER}/kustomize_v${KUSTOMIZE_VER}_linux_amd64.tar.gz
RUN tar -xvf kustomize_v${KUSTOMIZE_VER}_linux_amd64.tar.gz
RUN chmod +x ./kustomize

FROM alpine AS runtime

RUN mkdir /workdir
WORKDIR /workdir

COPY --from=builder /workdir/kubectl /usr/local/bin
COPY --from=builder /workdir/kustomize /usr/local/bin

ENTRYPOINT ["kustomize"]
