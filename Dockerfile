# syntax=docker/dockerfile:1.4
FROM curlimages/curl:latest

USER root

RUN --mount=type=secret,id=my_dockerhub_token \
    SECRET=$(cat /run/secrets/my_dockerhub_token) && \
    AUTH=$(echo "$SECRET" | base64) && \
    USERNAME=$(echo "$SECRET" | cut -d':' -f1) && \
    echo "Consultando repos para $USERNAME..." && \
    curl -s -H "Authorization: Basic $AUTH" https://hub.docker.com/v2/repositories/$USERNAME/ | \
    tee /repos.json
