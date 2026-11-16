select
    account_id,
    district_id,
    case frequency
        when 'POPLATEK MESICNE' then 'monthly'
        when 'POPLATEK TYDNE' then 'weekly'
        when 'POPLATEK PO OBRATU' then 'after_transaction'
        else frequency
    end as statement_frequency,
    cast(date as date) as opened_date
from {{ source('raw', 'account') }}
