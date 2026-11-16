import duckdb
con = duckdb.connect("berka.duckdb")
ids = [r[0] for r in con.execute(
    "select account_id from raw.account where frequency = 'POPLATEK MESICNE' order by account_id limit 5").fetchall()]
print("changing accounts:", ids)
con.execute("update raw.account set frequency = 'POPLATEK TYDNE' where account_id in (select unnest(?))", [ids])
print("done")
