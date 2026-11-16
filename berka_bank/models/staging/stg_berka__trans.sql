select
    trans_id,
    account_id,
    cast(date as date) as transaction_date,
    case type
        when 'PRIJEM' then 'credit'
        when 'VYDAJ' then 'debit'
        when 'VYBER' then 'cash_withdrawal'
        else type
    end as transaction_type,
    operation as operation_code,
    cast(amount as decimal(12, 2)) as amount,
    cast(balance as decimal(12, 2)) as balance_after,
    k_symbol as characterization_code,
    bank as counterparty_bank,
    account as counterparty_account,
    _loaded_at
from {{ source('raw', 'trans') }}
