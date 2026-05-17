#!/bin/bash

set -e

AWS_REGION="eu-west-1"
ECR_URL="561876735341.dkr.ecr.${AWS_REGION}.amazonaws.com"

REPOSITORY="starttech-backend"
IMAGE="$ECR_URL/$REPOSITORY:latest"

echo "Logging into ECR..."

aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_URL

echo "Pulling latest image..."

docker pull --platform linux/amd64 $IMAGE

echo "Stopping old container..."

docker stop backend || true
docker rm backend || true

echo "Starting new container..."

docker run --platform linux/amd64 -d \
  --name backend \
  --restart always \
  -p 8080:8080 \
  $IMAGE

echo "Deployment completed successfully."