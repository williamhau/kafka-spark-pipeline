#!/bin/bash
# JanusGraph Graph Database
# 1. Start in background
docker  compose -f docker-janusGraph-compose.yml up -d

# 2. Look at logs
docker compose -f docker-janusGraph-compose.yml logs -f

# 3. Open browser UI → http://localhost:8182
docker exec -it janusgraph-default ./bin/gremlin.sh

# Once inside the Gremlin Console, connect to the server with these standard
# Connect: :remote connect tinkerpop.server conf/remote.yaml
# Switch to Remote Mode: :remote console
# Test: g.addV('person').property('name', 'ubuntu-user').next() 
