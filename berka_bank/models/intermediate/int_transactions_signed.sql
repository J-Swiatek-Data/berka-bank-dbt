select
    *,
    {{ signed_amount('transaction_type', 'amount') }} as signed_amount
from {{ ref('stg_berka__trans') }}
