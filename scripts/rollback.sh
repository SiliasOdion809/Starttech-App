#!/bin/bash

set -e

IMAGE=$1

if [ -z "$IMAGE" ]; then
  echo "Usage: ./rollback.sh <image-tag>"
  exit 1
fi

echo "Rolling back backend container..."


docker stop backend || true

docker rm backend || true


docker run -d \
  --name backend \
  --restart always \
  -p 8080:8080 \
  $IMAGE


echo "Rollback completed"