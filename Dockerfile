FROM hashicorp/terraform:latest

ENV TF_HTTP_ADDRESS=""
ENV TF_HTTP_LOCK_ADDRESS=""
ENV TF_HTTP_UNLOCK_ADDRESS=""

ADD workspace /tmp/workspace
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /tmp/workspace
ENTRYPOINT /entrypoint.sh