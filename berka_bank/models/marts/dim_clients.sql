select
    client_id,
    gender,
    birth_date,
    extract(year from birth_date) as birth_year,
    district_id
from {{ ref('stg_berka__client') }}
