import sys
import duckdb

batch = sys.argv[1] if len(sys.argv) > 1 else "1"
RAW = "../data/raw"
CUTOFF = "1997-01-01"

con = duckdb.connect("berka.duckdb")
con.execute("create schema if not exists raw")

if batch == "1":
    tables = {"account": "account", "client": "client", "disp": "disp",
              "loan": "loan", "district": "district", "card": "card",
              "order": "orders"}
    for src, name in tables.items():
        con.execute(f"create or replace table raw.{name} as "
                    f"select *, now() as _loaded_at from read_csv_auto('{RAW}/{src}.csv')")
    con.execute(f"create or replace table raw.trans as "
                f"select *, now() as _loaded_at from read_csv_auto('{RAW}/trans.csv') "
                f"where date < DATE '{CUTOFF}'")
elif batch == "2":
    con.execute(f"insert into raw.trans by name "
                f"select *, now() as _loaded_at from read_csv_auto('{RAW}/trans.csv') "
                f"where date >= DATE '{CUTOFF}'")

for t in ["account", "client", "disp", "loan", "district", "card", "orders", "trans"]:
    print(t, con.execute(f"select count(*) from raw.{t}").fetchone()[0])
print("trans date range:", con.execute("select min(date), max(date) from raw.trans").fetchone())
con.close()
