FROM arm64v8/alpine:3.7

MAINTAINER Michal Orzechowski <orzechowski.michal@gmail.com>

ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/groundnuty/k8s-wait-for" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile"

ENV KUBE_LATEST_VERSION="v1.18.1"

# RUN apk add ca-certificates 
RUN apk add curl 
RUN apk add jq
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/arm64/kubectl -o /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl 
RUN rm /var/cache/apk/*

ADD wait_for.sh /usr/local/bin/wait_for.sh

ENTRYPOINT ["wait_for.sh"]
