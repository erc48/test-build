# syntax=docker/dockerfile:1.4
FROM curlimages/curl:latest

USER root

RUN --mount=type=secret,id=my_dockerhub_token \
    SECRET=$(cat /run/secrets/my_dockerhub_token) && \
    USERNAME=$(echo "$SECRET" | cut -d':' -f1) && \
    TOKEN=$(echo "$SECRET" | cut -d':' -f2) && \
    echo "Consultando tokens de acceso para $USERNAME..." && \
    curl -s -H "Authorization: Bearer $TOKEN" https://hub.docker.com/v2/access-tokens | \
    tee /access_tokens.json