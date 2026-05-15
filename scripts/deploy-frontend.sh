#!/bin/bash

set -e

echo "Building frontend..."

cd frontend

npm install
npm run build

echo "Deploying to S3..."

aws s3 sync dist/ s3://$S3_BUCKET --delete

echo "Invalidating CloudFront cache..."

aws cloudfront create-invalidation \
  --distribution-id $CLOUDFRONT_DISTRIBUTION_ID \
  --paths "/*"

echo "Frontend deployment completed!"