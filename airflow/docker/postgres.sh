#!/bin/bash
#
# Airflow PostgreSQL Database Management Script
#
# Purpose: Start, view logs, or stop the PostgreSQL database for Airflow metadata.
#
# Usage: Run from airflow/docker/.
#

# --- Start PostgreSQL in background ---
docker compose -f docker-postgres-compose.yaml up -d

# --- Stream PostgreSQL logs (Ctrl+C to stop) ---
docker compose -f docker-postgres-compose.yaml logs -f

# --- Stop and remove PostgreSQL container ---
docker compose -f docker-postgres-compose.yaml down
