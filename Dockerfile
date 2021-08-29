FROM hashicorp/terraform:latest

ENV TF_HTTP_ADDRESS=""
ENV TF_HTTP_LOCK_ADDRESS=""
ENV TF_HTTP_UNLOCK_ADDRESS=""

ENV KUBE_HOST=""
ENV KUBE_CLUSTER_CA_CERT_DATA=""
ENV KUBE_CLIENT_KEY_DATA=""
ENV KUBE_CLIENT_CERT_DATA=""

ADD workspace /tmp/workspace
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /tmp/workspace
ENTRYPOINT /entrypoint.sh