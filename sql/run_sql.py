import sqlite3
import pandas as pd
from pathlib import Path

base_dir = Path(__file__).resolve().parent
db_path = base_dir / "superstore.db"
sql_path = base_dir / "superstore_analysis.sql"

print("DB path:", db_path)
print("SQL path:", sql_path)

content = sql_path.read_text(encoding="utf-8")
print("Raw SQL content:")
print(repr(content))

blocks = content.split(";")
print("Number of blocks found:", len(blocks))

queries = []

for block in blocks:
    lines = block.strip().splitlines()
    cleaned_lines = [line for line in lines if not line.strip().startswith("--")]
    cleaned_query = "\n".join(cleaned_lines).strip()
    if cleaned_query:
        queries.append(cleaned_query)

print("Queries found:", len(queries))
for i, q in enumerate(queries, start=1):
    print(f"\n--- Parsed Query {i} ---")
    print(q)

conn = sqlite3.connect(db_path)

for i, query in enumerate(queries, start=1):
    print(f"\n--- Running Query {i} ---")
    df = pd.read_sql_query(query, conn)
    print(df.head(20).to_string(index=False))

conn.close()
print("\nDone.")