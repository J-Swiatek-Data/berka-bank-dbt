select
    client_id,
    gender,
    cast(birth_date as date) as birth_date,
    district_id
from {{ source('raw', 'client') }}
