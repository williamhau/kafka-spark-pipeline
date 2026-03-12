#!/bin/bash
#
# JanusGraph Graph Database Docker Management Script
#
# Purpose: Start JanusGraph, view logs, or launch the Gremlin Console.
#
# Usage: Run from janusgraph/docker/. Web UI: http://localhost:8182
#
# Gremlin Console (after exec):
#   :remote connect tinkerpop.server conf/remote.yaml
#   :remote console
#   g.addV('person').property('name', 'ubuntu-user').next()
#

# --- Start JanusGraph in background ---
docker compose -f docker-janusGraph-compose.yml up -d

# --- Stream JanusGraph logs (Ctrl+C to stop) ---
docker compose -f docker-janusGraph-compose.yml logs -f

# --- Launch Gremlin Console (interactive) ---
docker exec -it janusgraph-default ./bin/gremlin.sh 
