select
    a.account_id,
    a.statement_frequency,
    a.opened_date,
    a.district_id,
    o.owner_client_id
from {{ ref('stg_berka__account') }} a
left join {{ ref('int_account_owners') }} o
    on a.account_id = o.account_id
