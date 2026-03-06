docker compose  -f docker-compose-master.yaml up -d

docker compose -f docker-compose-master.yaml logs -f

docker  compose -f docker-compose-master.yaml down

#docker rm -f $(docker ps -q)