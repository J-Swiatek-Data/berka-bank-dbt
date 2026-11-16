select
    order_id,
    account_id,
    bank_to,
    account_to,
    cast(amount as decimal(12, 2)) as order_amount,
    k_symbol as payment_type_code
from {{ source('raw', 'orders') }}
