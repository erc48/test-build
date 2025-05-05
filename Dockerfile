FROM alpine:latest

# Instalamos curl y jq para peticiones HTTP y parsing JSON
RUN apk add --no-cache curl jq

# Copia el script al contenedor (opcional si lo haces dentro del entrypoint)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
