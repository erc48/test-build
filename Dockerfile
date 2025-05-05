# syntax=docker/dockerfile:1.4
FROM ubuntu:22.04 AS base

RUN apt-get update && apt-get install -y curl

# Simular uso de un secreto (NO se guardará si se usa bien)
# El secreto se monta como archivo
FROM base AS build

# Usamos --mount para inyectar secreto de forma segura
RUN --mount=type=secret,id=my_secret \
    SECRET=$(cat /run/secrets/my_secret) && \
    echo "Secreto en build: $SECRET"

# Imagen final
FROM base

# Instalar Python 3.13 en la final (simplificado usando deadsnakes PPA)
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get update && \
    apt-get install -y python3.13

CMD ["python3.13", "--version"]
