#!/bin/bash
#
# Memgraph Graph Database Docker Management Script
#
# Purpose: Start or view logs of the Memgraph in-memory graph database.
#
# Usage: Run from memgraph/docker/.
#

# --- Start Memgraph in background ---
docker compose -f docker-memgraph-compose.yml up -d

# --- Stream Memgraph logs (Ctrl+C to stop) ---
docker compose -f docker-memgraph-compose.yml logs -f
