"""
Spark Connectivity Test

Verifies that a local Spark driver can connect to a standalone Spark master
and execute a simple distributed computation (create DataFrame, count, show).

Requirements: Python 3.8 (must match Spark Docker image), pyspark
Prerequisites: Spark master running at spark://127.0.0.1:7077
"""

from pyspark.sql import SparkSession
import os

# Driver Python version must match the Spark Docker image (Python 3.8)

# Initialize Spark session and connect to standalone master
spark = SparkSession.builder \
    .appName("Ubuntu-Spark-Test") \
    .master("spark://127.0.0.1:7077") \
    .config("spark.driver.host", "127.0.0.1") \
    .config("spark.driver.bindAddress", "127.0.0.1") \
    .getOrCreate()

try:
    print("\n--- Connecting to Spark Master ---")

    # Create a small sample DataFrame (in-memory, used to verify connectivity)
    data = [("Stock_A", 150), ("Stock_B", 200), ("Stock_C", 250)]
    df = spark.createDataFrame(data, ["Ticker", "Price"])

    print("Executing distributed action...")
    # count() and show() trigger Spark execution on workers
    count = df.count()
    df.show()
    
    print(f"Successfully processed {count} records on the Spark Worker!")

except Exception as e:
    print(f"Error occurred: {e}")

finally:
    spark.stop()
    print("--- Session Closed ---")
