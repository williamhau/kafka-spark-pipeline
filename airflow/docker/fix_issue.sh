#!/bin/bash
#
# Airflow API Server Recovery and Password Lookup
#
# Purpose: Restart the Airflow API server and display initial admin password.
#
# Usage: Run from airflow/docker/ when API issues occur or to retrieve credentials.
#

# --- Restart Airflow API server ---
docker compose -f docker-airflow-compose.yaml restart airflow-api-server

# --- Show admin password from logs ---
docker compose -f docker-airflow-compose.yaml logs airflow-api-server 2>&1 | grep -i "password for user"
