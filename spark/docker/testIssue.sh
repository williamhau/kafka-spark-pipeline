#http://localhost:8080/   master monitoring page

# test spark worker
#docker exec -it spark-worker /opt/spark/bin/spark-submit   --master spark://localhost:7077   --class org.apache.spark.examples.SparkPi   /opt/spark/examples/jars/spark-examples_2.13-4.0.0-preview1.jar 10
docker exec -it spark-worker-standalone /opt/spark/bin/spark-submit   --master spark://localhost:7077   --class org.apache.spark.examples.SparkPi   /opt/spark/examples/jars/spark-examples_2.12-3.5.3.jar 10


