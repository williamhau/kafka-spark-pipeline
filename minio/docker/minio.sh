#!/bin/bash
#
# MinIO Docker Management Script
#
# Purpose: Start, view logs, or stop MinIO S3-compatible object storage.
#
# Usage: Run from minio/docker/. Health check: http://localhost:9000/minio/health/ready
#

# --- Start MinIO in background ---
docker compose up -d

# --- Stream MinIO logs (Ctrl+C to stop) ---
docker compose logs -f

# --- Stop and remove MinIO container ---
docker compose down
