docker compose -f docker-airflow-compose.yaml up airflow-init

docker compose -f docker-airflow-compose.yaml up -d airflow-api-server airflow-scheduler

docker compose -f docker-airflow-compose.yaml logs -f

docker  compose  -f docker-airflow-compose.yaml down

