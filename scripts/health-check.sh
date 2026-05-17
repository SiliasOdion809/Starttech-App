#!/bin/bash

set -e

echo "Checking backend health endpoint..."

STATUS=$(curl -o /dev/null -s -w "%{http_code}" http://localhost:8080/health)

if [ "$STATUS" -eq 200 ]; then
  echo "Backend is healthy"
  exit 0
else
  echo "Backend health check failed"
  exit 1
fi