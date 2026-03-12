#!/bin/bash
#
# Spark Master Docker Management Script
#
# Purpose: Start, view logs, or stop the Spark master via Docker Compose.
#
# Usage: Run from spark/docker/. Master UI: http://localhost:8080/
#        Master endpoint: spark://127.0.0.1:7077
#

# --- Start Spark master in background ---
docker compose -f docker-compose-master.yaml up -d

# --- Stream master logs (Ctrl+C to stop) ---
docker compose -f docker-compose-master.yaml logs -f

# --- Stop and remove master container ---
docker compose -f docker-compose-master.yaml down

# Optional: force-remove all running containers
# docker rm -f $(docker ps -q)