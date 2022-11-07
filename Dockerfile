FROM alpine

# Metadata
LABEL org.label-schema.vcs-url="https://github.com/wegift/k8s-kubectl" \
      org.label-schema.docker.dockerfile="/Dockerfile"

ENV KUBE_LATEST_VERSION="v1.21.14"
ENV TANKA_VERSION="v0.23.1"
ENV JSONNET_VERSION="v0.5.1"

RUN apk add --update ca-certificates \
 && apk add --update make libintl gettext bash \
 && apk add --update curl \
 && export ARCH="$(uname -m)" && if [[ ${ARCH} == "x86_64" ]]; then export ARCH="amd64"; fi && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/${ARCH}/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && rm /var/cache/apk/*

RUN curl -Lo /usr/local/bin/tk https://github.com/grafana/tanka/releases/download/${TANKA_VERSION}/tk-linux-amd64 \
 && curl -Lo /usr/local/bin/jb https://github.com/jsonnet-bundler/jsonnet-bundler/releases/download/${JSONNET_VERSION}/jb-linux-amd64 \
 && chmod a+x /usr/local/bin/tk \
 && chmod a+x /usr/local/bin/jb

WORKDIR /root
ENTRYPOINT ["kubectl"]
CMD ["help"]
