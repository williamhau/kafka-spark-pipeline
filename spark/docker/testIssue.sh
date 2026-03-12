#!/bin/bash
#
# Spark Pi Example Test Script
#
# Purpose: Run the classic Spark Pi example inside the Spark worker container
#          to verify distributed computation.
#
# Prerequisites: Spark master + worker running. Master UI: http://localhost:8080/
#
# Usage: Execute from spark/docker/ with worker container name matching below.
#

# Spark Master monitoring UI
# http://localhost:8080/

# Run SparkPi example (10 partitions) inside the worker container
# Adjust container name (spark-worker-standalone) if your compose uses a different name
docker exec -it spark-worker-standalone /opt/spark/bin/spark-submit \
  --master spark://localhost:7077 \
  --class org.apache.spark.examples.SparkPi \
  /opt/spark/examples/jars/spark-examples_2.12-3.5.3.jar 10
