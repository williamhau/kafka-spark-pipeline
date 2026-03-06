from pyspark.sql import SparkSession
import os

# Need to use Python 3.8 to run this scripts as the driver needs to match the Python version used in the Spark docker

spark = SparkSession.builder \
    .appName("Ubuntu-Spark-Test") \
    .master("spark://127.0.0.1:7077") \
    .config("spark.driver.host", "127.0.0.1") \
    .config("spark.driver.bindAddress", "127.0.0.1") \
    .getOrCreate()

try:
    print("\n--- Connecting to Spark Master ---")
    
    data = [("Stock_A", 150), ("Stock_B", 200), ("Stock_C", 250)]
    df = spark.createDataFrame(data, ["Ticker", "Price"])

    print("Executing distributed action...")
    # Triggering an action
    count = df.count() 
    df.show()
    
    print(f"Successfully processed {count} records on the Spark Worker!")

except Exception as e:
    print(f"Error occurred: {e}")

finally:
    spark.stop()
    print("--- Session Closed ---")
