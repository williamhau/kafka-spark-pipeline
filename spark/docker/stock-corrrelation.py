import os
import pandas as pd
import yfinance as yf
from pyspark.sql import SparkSession
from pyspark.sql import functions as F
from pyspark.ml.feature import VectorAssembler
from pyspark.ml.stat import Correlation

# Need to use Python 3.8 to run this scripts as the driver needs to match the Python version used in the Spark docker


# 1. Initialize Spark (No extra JARs needed!)
spark = SparkSession.builder \
    .appName("Spark-Stock-Correlation") \
    .master("spark://127.0.0.1:7077") \
    .config("spark.driver.host", "127.0.0.1") \
    .config("spark.driver.bindAddress", "127.0.0.1") \
    .getOrCreate()

try:
    # 2. Download Data for Multiple Stocks
    tickers = ["AAPL", "MSFT", "GOOGL", "AMZN", "NVDA", "META", "TSLA", "BRK-B", "JPM", "^GSPC", "^NDX"]
    print(f"--- Downloading data for {tickers} ---")
    raw_data = yf.download(tickers, period="1y", interval="1d")["Close"]

    # Convert Pandas to Spark (flattening the data)
    # Spark likes a 'long' format or a clean 'wide' format
    pdf = raw_data.reset_index()
    stock_df = spark.createDataFrame(pdf).dropna()

    # 3. Prepare Features for Correlation
    # PySpark's Correlation tool requires a single column containing a Vector of values
    assembler = VectorAssembler(inputCols=tickers, outputCol="features")
    vector_df = assembler.transform(stock_df).select("features")

    # 4. Calculate Correlation Matrix
    # This runs as a distributed task on your Spark Workers
    print("--- Calculating Correlation Matrix on Spark Workers ---")
    matrix = Correlation.corr(vector_df, "features").head()
    
    # Convert the dense matrix back to a readable format
    corr_array = matrix[0].toArray()
    corr_matrix_df = pd.DataFrame(corr_array, index=tickers, columns=tickers)

    print("\n--- Stock Correlation Matrix (1 Year History) ---")
    print(corr_matrix_df)

    # 5. Validation Logic
    print("\n--- Spark Workload Verification ---")
    print(f"Processed {stock_df.count()} rows across {len(tickers)} dimensions.")

finally:
    spark.stop()
    print("--- Session Closed ---")
