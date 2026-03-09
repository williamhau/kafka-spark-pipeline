#!/bin/bash
# Memgraph Graph Database
# 1. Start in background
docker  compose -f docker-memgraph-compose.yml up -d

# 2. Look at logs
docker compose -f docker-memgraph-compose.yml logs -f
