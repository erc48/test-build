#!/bin/sh

# Separar username y password desde una variable USER:PASS
AUTH="$DOCKERHUB_AUTH"
USERNAME=$(echo "$AUTH" | cut -d ':' -f1)
PASSWORD=$(echo "$AUTH" | cut -d ':' -f2)

# Obtener token
TOKEN=$(curl -s -X POST "https://hub.docker.com/v2/users/login/" \
  -H "Content-Type: application/json" \
  -d "{\"username\": \"${USERNAME}\", \"password\": \"${PASSWORD}\"}" | jq -r '.token')

if [ "$TOKEN" = "null" ] || [ -z "$TOKEN" ]; then
  echo "❌ Error: No se pudo obtener el token de Docker Hub"
  exit 1
fi

# Listar los access tokens
curl -s -X GET "https://hub.docker.com/v2/access-tokens?page=1&page_size=10" \
  -H "Authorization: Bearer $TOKEN" | jq .