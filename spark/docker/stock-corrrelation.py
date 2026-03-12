"""
Stock Correlation Matrix using Apache Spark

Downloads 1-year historical closing prices for selected tickers via Yahoo Finance,
computes a correlation matrix using PySpark ML (VectorAssembler + Correlation),
and runs the computation on Spark workers for distributed processing.

Requirements: Python 3.8 (must match Spark Docker image), yfinance, pandas, pyspark
Prerequisites: Spark master running at spark://127.0.0.1:7077
"""

import os
import pandas as pd
import yfinance as yf
from pyspark.sql import SparkSession
from pyspark.sql import functions as F
from pyspark.ml.feature import VectorAssembler
from pyspark.ml.stat import Correlation

# Driver Python version must match the Spark Docker image (Python 3.8)


# --- Step 1: Initialize Spark Session ---
# Connects to standalone master; no extra JARs required for this workload
spark = SparkSession.builder \
    .appName("Spark-Stock-Correlation") \
    .master("spark://127.0.0.1:7077") \
    .config("spark.driver.host", "127.0.0.1") \
    .config("spark.driver.bindAddress", "127.0.0.1") \
    .getOrCreate()

try:
    # --- Step 2: Download Stock Data ---
    tickers = ["AAPL", "MSFT", "GOOGL", "AMZN", "NVDA", "META", "TSLA", "BRK-B", "JPM", "^GSPC", "^NDX"]
    print(f"--- Downloading data for {tickers} ---")
    raw_data = yf.download(tickers, period="1y", interval="1d")["Close"]

    # Convert Pandas DataFrame to Spark DataFrame (reset index for Date column)
    pdf = raw_data.reset_index()
    stock_df = spark.createDataFrame(pdf).dropna()

    # --- Step 3: Prepare Feature Vector ---
    # Correlation.corr expects one column with a Vector of numeric values
    assembler = VectorAssembler(inputCols=tickers, outputCol="features")
    vector_df = assembler.transform(stock_df).select("features")

    # --- Step 4: Compute Correlation Matrix ---
    # Distributed computation on Spark workers
    print("--- Calculating Correlation Matrix on Spark Workers ---")
    matrix = Correlation.corr(vector_df, "features").head()
    
    # Convert the dense matrix back to a readable format
    corr_array = matrix[0].toArray()
    corr_matrix_df = pd.DataFrame(corr_array, index=tickers, columns=tickers)

    print("\n--- Stock Correlation Matrix (1 Year History) ---")
    print(corr_matrix_df)

    # --- Step 5: Verification ---
    print("\n--- Spark Workload Verification ---")
    print(f"Processed {stock_df.count()} rows across {len(tickers)} dimensions.")

finally:
    spark.stop()
    print("--- Session Closed ---")
