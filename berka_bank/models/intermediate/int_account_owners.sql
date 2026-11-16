select
    account_id,
    client_id as owner_client_id
from {{ ref('stg_berka__disp') }}
where disposition_type = 'owner'
