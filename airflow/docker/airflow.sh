#!/bin/bash
#
# Apache Airflow Docker Management Script
#
# Purpose: Initialize Airflow DB, start services, view logs, or stop Airflow.
#
# Usage: Run from airflow/docker/.
#

# --- Initialize Airflow database and admin user (run once) ---
docker compose -f docker-airflow-compose.yaml up airflow-init

# --- Start Airflow API server and scheduler in background ---
docker compose -f docker-airflow-compose.yaml up -d airflow-api-server airflow-scheduler

# --- Stream Airflow logs (Ctrl+C to stop) ---
docker compose -f docker-airflow-compose.yaml logs -f

# --- Stop and remove Airflow containers ---
docker compose -f docker-airflow-compose.yaml down

