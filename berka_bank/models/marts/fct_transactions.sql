{{
    config(
        materialized='incremental',
        unique_key='trans_id',
        incremental_strategy='delete+insert'
    )
}}

select
    trans_id,
    account_id,
    transaction_date,
    transaction_type,
    operation_code,
    amount,
    signed_amount,
    balance_after,
    characterization_code,
    counterparty_bank,
    counterparty_account,
    _loaded_at
from {{ ref('int_transactions_signed') }}

{% if is_incremental() %}
where _loaded_at > (select max(_loaded_at) from {{ this }})
{% endif %}
