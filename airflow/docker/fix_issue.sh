docker compose -f docker-airflow-compose.yaml restart airflow-api-server

docker compose -f docker-airflow-compose.yaml logs airflow-api-server 2>&1 | grep -i "password for user"

