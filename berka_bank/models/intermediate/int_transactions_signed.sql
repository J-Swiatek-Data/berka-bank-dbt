select
    *,
    case
        when transaction_type = 'credit' then amount
        else -amount
    end as signed_amount
from {{ ref('stg_berka__trans') }}
