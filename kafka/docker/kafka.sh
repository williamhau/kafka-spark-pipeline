docker compose up -d

docker compose logs -f

docker exec -it kafka /opt/kafka/bin/kafka-topics.sh --create --topic test-topic --bootstrap-server localhost:9092

docker  compose  down