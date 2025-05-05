# syntax=docker/dockerfile:1.4

FROM ubuntu:22.04

# Evita prompts interactivos durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Instala tzdata y otras herramientas necesarias
RUN apt-get update && \
    apt-get install -y tzdata curl && \
    rm -rf /var/lib/apt/lists/*

# Usa un secreto si se proporciona (BuildKit)
RUN --mount=type=secret,id=my_secret \
    cat /run/secrets/my_secret || echo "No secret found"

# Define el comando por defecto
CMD ["bash"]
