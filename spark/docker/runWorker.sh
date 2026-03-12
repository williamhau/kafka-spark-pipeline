#!/bin/bash
#
# Spark Worker Docker Management Script
#
# Purpose: Start, view logs, or stop Spark workers via Docker Compose.
#
# Usage: Run from spark/docker/. Uncomment the command you need.
#

# --- Start worker(s) in background ---
docker compose -f docker-compose-worker.yaml up -d

# --- Stream worker logs (Ctrl+C to stop) ---
docker compose -f docker-compose-worker.yaml logs -f

# --- Stop and remove worker containers ---
docker compose -f docker-compose-worker.yaml down
