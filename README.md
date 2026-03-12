# Kafka–Spark Pipeline

A research project for streaming and batch analytics using **Apache Kafka**, **Apache Spark**, and supporting data infrastructure (graph DBs, time-series DB, object storage, workflow orchestration).

---

## Project Overview

This repository provides Docker-based setups and scripts to run:

| Component      | Description                                    |
|----------------|------------------------------------------------|
| **Kafka**      | Event streaming platform (port 9092)          |
| **Spark**      | Distributed compute (master 7077, UI 8080)     |
| **TimescaleDB**| Time-series database                           |
| **Memgraph**   | In-memory graph database                       |
| **JanusGraph** | Distributed graph database (Gremlin on 8182)   |
| **MinIO**      | S3-compatible object storage                   |
| **Airflow**    | Workflow orchestration + PostgreSQL            |

---

## Prerequisites

- **Docker** and **Docker Compose**
- **Python 3.8** (for PySpark scripts; must match Spark driver)
- **Linux** or **WSL2** (shell scripts use Bash)

---

## Quick Start

### 1. Kafka

```bash
cd kafka/docker
docker compose up -d
```

- Broker: `localhost:9092`
- Create topic: see `kafka.sh` for commands

### 2. Spark (Master + Worker)

Start master:

```bash
cd spark/docker
./runMaster.sh   # or run commands from runMaster.sh
```

Start worker(s):

```bash
./runWorker.sh
```

- Master: `spark://127.0.0.1:7077`
- Web UI: http://localhost:8080

Run a Spark job:

```bash
python test-spark.py
# or
python stock-corrrelation.py
```

### 3. TimescaleDB

```bash
cd timescaledb
./timescaledb.sh
```

Ensure `../.env` exists if the script sources it.

### 4. Memgraph

```bash
cd memgraph/docker
./memgraph.sh
```

### 5. JanusGraph

```bash
cd janusgraph/docker
./janusgraph.sh
```

Gremlin console: `http://localhost:8182`

### 6. MinIO

```bash
cd minio/docker
./minio.sh
```

Health check: `curl -I http://localhost:9000/minio/health/ready`

### 7. Airflow

```bash
cd airflow/docker
./airflow.sh
```

Initial DB setup and credentials: see `fix_issue.sh` and `postgres.sh`.

---

## Project Structure

```
kafka-spark-pipeline/
├── airflow/docker/       # Airflow + PostgreSQL
├── janusgraph/docker/   # JanusGraph (Gremlin)
├── kafka/docker/        # Kafka broker
├── memgraph/docker/     # Memgraph
├── minio/docker/        # MinIO object storage
├── spark/docker/        # Spark master/worker, PySpark scripts
│   ├── test-spark.py          # Basic Spark connectivity test
│   ├── stock-corrrelation.py  # Stock correlation with Spark
│   ├── runMaster.sh
│   ├── runWorker.sh
│   └── testIssue.sh           # Spark Pi example job
└── timescaledb/         # TimescaleDB time-series DB
```

---

## Shell Scripts

All shell scripts use `#!/bin/bash` and Docker Compose. They support:

- `up -d` – start containers in background
- `logs -f` – stream logs
- `down` – stop and remove containers

Script locations:

- `kafka/docker/kafka.sh`
- `spark/docker/runMaster.sh`, `runWorker.sh`, `testIssue.sh`
- `timescaledb/timescaledb.sh`
- `memgraph/docker/memgraph.sh`
- `janusgraph/docker/janusgraph.sh`
- `minio/docker/minio.sh`, `fix-issue.sh`
- `airflow/docker/airflow.sh`, `postgres.sh`, `fix_issue.sh`

---

## Python / PySpark

| Script               | Purpose                                                      |
|----------------------|--------------------------------------------------------------|
| `test-spark.py`      | Connect to Spark master and run a simple DataFrame job       |
| `stock-corrrelation.py` | Compute 1-year stock correlation matrix via Spark ML     |

Run with Python 3.8 (matches Spark Docker image):

```bash
cd spark/docker
python test-spark.py
python stock-corrrelation.py
```

---

## License

Internal/research use.
