FROM alpine

# Metadata
LABEL org.label-schema.vcs-url="https://github.com/wegift/k8s-kubectl" \
      org.label-schema.docker.dockerfile="/Dockerfile"

ENV KUBE_LATEST_VERSION="v1.18.15"

RUN apk add --update ca-certificates \
 && apk add --update make libintl gettext bash \
 && apk add --update -t deps curl \
 && export ARCH="$(uname -m)" && if [[ ${ARCH} == "x86_64" ]]; then export ARCH="amd64"; fi && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/${ARCH}/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/*

WORKDIR /root
ENTRYPOINT ["kubectl"]
CMD ["help"]
