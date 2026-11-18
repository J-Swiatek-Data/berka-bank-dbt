"""Download the Berka (PKDD'99) financial dataset from the public CTU Relational Repository."""
import warnings
from pathlib import Path

import pandas as pd
import pymysql

warnings.filterwarnings("ignore", category=UserWarning)

OUT = Path(__file__).resolve().parents[1] / "data" / "raw"
TABLES = ["account", "card", "client", "disp", "district", "loan", "order", "trans"]

OUT.mkdir(parents=True, exist_ok=True)

# Public read-only guest login, published on the CTU repository's dataset page.
conn = pymysql.connect(
    host="relational.fel.cvut.cz",
    port=3306,
    user="guest",
    password="ctu-relational",
    database="financial",
)

for table in TABLES:
    df = pd.read_sql(f"SELECT * FROM financial.{table}", conn)
    df.to_csv(OUT / f"{table}.csv", index=False)
    print(f"{table}: {len(df)} rows")

conn.close()
