FROM hashicorp/terraform:latest

# Configuration for the Terraform backend
ENV TF_HTTP_ADDRESS=""
ENV TF_HTTP_LOCK_ADDRESS=""
ENV TF_HTTP_UNLOCK_ADDRESS=""

# Configuration for the Kubernetes provider
ENV KUBE_HOST=""
ENV KUBE_CLUSTER_CA_CERT_DATA=""
ENV KUBE_CLIENT_KEY_DATA=""
ENV KUBE_CLIENT_CERT_DATA=""

# Configuration for the Opnsense provider
ENV OPNSENSE_URL=""
ENV OPNSENSE_KEY=""
ENV OPNSENSE_SECRET=""
ENV OPNSENSE_ALLOW_UNVERIFIED_TLS=""

ADD workspace /tmp/workspace
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /tmp/workspace
RUN terraform init
ENTRYPOINT /entrypoint.sh