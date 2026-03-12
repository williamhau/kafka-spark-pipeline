#!/bin/bash
#
# TimescaleDB Docker Management Script
#
# Purpose: Start, view logs, or stop TimescaleDB via Docker Compose.
# Prerequisites: ../.env file for environment variables.
#
# Usage: Run from timescaledb/ directory. Edit lines below to choose action.
#

set -a
source ../.env
set +a

# --- Option 1: Start in background ---
docker compose -f docker-timescaledb-compose.yml up -d

# --- Option 2: Stream container logs (Ctrl+C to stop) ---
docker compose -f docker-timescaledb-compose.yml logs -f

# --- Option 3: Stop and remove containers ---
docker compose -f docker-timescaledb-compose.yml down
