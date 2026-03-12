#!/bin/bash
#
# MinIO Health Check Script
#
# Purpose: Verify MinIO is running and ready to accept requests.
#
# Usage: Run after starting MinIO (minio.sh). Expects HTTP 200.
#

curl -I http://localhost:9000/minio/health/ready
