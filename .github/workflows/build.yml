name: Manual Docker Build with Secret

on:
  workflow_dispatch:  # permite ejecución manual

jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      id-token: write
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Create secret file
        run: echo "${{ secrets.MY_SECRET }}" > my_secret.txt

      - name: Build Docker image with BuildKit and secret
        run: |
          DOCKER_BUILDKIT=1 docker build \
            --secret id=my_secret,src=my_secret.txt \
            -t ubuntu-python:test .

      - name: Show Docker history
        run: docker history ubuntu-python:test
