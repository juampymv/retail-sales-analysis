import pandas as pd
import sqlite3

df = pd.read_csv("../data/superstore.csv", encoding="latin1")

conn = sqlite3.connect("superstore.db")

df.to_sql("orders", conn, if_exists="replace", index=False)

conn.close()

print("Database created successfully.")