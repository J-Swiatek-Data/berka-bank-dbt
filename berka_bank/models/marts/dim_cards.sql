select
    c.card_id,
    c.disp_id,
    c.card_type,
    c.issued_date,
    d.client_id,
    d.account_id
from {{ ref('stg_berka__card') }} c
left join {{ ref('stg_berka__disp') }} d
    on c.disp_id = d.disp_id
