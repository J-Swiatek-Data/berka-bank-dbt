select
    district_id,
    A2 as district_name,
    A3 as region,
    A4 as population,
    A10 as urban_inhabitants_pct,
    A11 as avg_salary,
    A12 as unemployment_rate_1995,
    A13 as unemployment_rate_1996,
    A14 as entrepreneurs_per_1000,
    A15 as crimes_1995,
    A16 as crimes_1996
from {{ source('raw', 'district') }}
