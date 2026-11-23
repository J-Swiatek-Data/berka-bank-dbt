select
    order_id,
    account_id,
    bank_to,
    account_to,
    order_amount,
    payment_type_code
from {{ ref('stg_berka__orders') }}
