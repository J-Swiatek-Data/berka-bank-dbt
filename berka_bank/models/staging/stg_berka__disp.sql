select
    disp_id,
    client_id,
    account_id,
    lower(type) as disposition_type
from {{ source('raw', 'disp') }}
