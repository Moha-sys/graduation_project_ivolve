#!/bin/bash
# Initialize S3 Bucket in Floci for Terraform Backend State
set -e

FLOCI_ENDPOINT="${FLOCI_ENDPOINT:-http://localhost:4566}"
BUCKET_NAME="${BUCKET_NAME:-ivolve-terraform-state-bucket}"
REGION="${AWS_REGION:-us-east-1}"

echo "=========================================================="
echo " Initializing Floci S3 Backend Bucket                     "
echo " Endpoint: ${FLOCI_ENDPOINT}                              "
echo " Bucket:   ${BUCKET_NAME}                                 "
echo " Region:   ${REGION}                                      "
echo "=========================================================="

# Check if Floci is reachable
if ! curl -s "${FLOCI_ENDPOINT}/_floci/health" > /dev/null && ! curl -s "${FLOCI_ENDPOINT}" > /dev/null; then
  echo "Error: Floci does not appear to be running on ${FLOCI_ENDPOINT}."
  echo "Start Floci using: docker compose -f terraform/floci/docker-compose.floci.yml up -d"
  exit 1
fi

echo "Floci is running. Creating S3 bucket..."

# If AWS CLI is installed, use it with --endpoint-url
if command -v aws >/dev/null 2>&1; then
  AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test aws --endpoint-url="${FLOCI_ENDPOINT}" \
    s3api create-bucket --bucket "${BUCKET_NAME}" --region "${REGION}" || true
else
  # Fallback to direct HTTP REST call to Floci S3 endpoint
  curl -X PUT "${FLOCI_ENDPOINT}/${BUCKET_NAME}" || true
fi

echo "S3 Bucket '${BUCKET_NAME}' is ready in Floci for Terraform backend state!"
