#!/bin/bash

set -a
source ../.env
set +a

# TimescaleDB
# 1. Start in background
docker  compose -f docker-timescaledb-compose.yml up -d

# 2. Look at logs
docker compose -f docker-timescaledb-compose.yml logs -f

# 3. Stop and remove containers
docker  compose -f docker-timescaledb-compose.yml down
