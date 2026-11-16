select
    card_id,
    disp_id,
    lower(type) as card_type,
    cast(issued as date) as issued_date
from {{ source('raw', 'card') }}
