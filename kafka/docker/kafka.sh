#!/bin/bash
#
# Apache Kafka Docker Management Script
#
# Purpose: Start Kafka, view logs, create topics, or stop the broker.
#
# Usage: Run from kafka/docker/. Broker: localhost:9092
#

# --- Start Kafka in background ---
docker compose up -d

# --- Stream Kafka logs (Ctrl+C to stop) ---
docker compose logs -f

# --- Create a test topic (run when Kafka is up) ---
docker exec -it kafka /opt/kafka/bin/kafka-topics.sh \
  --create --topic test-topic --bootstrap-server localhost:9092

# --- Stop and remove Kafka container ---
docker compose down