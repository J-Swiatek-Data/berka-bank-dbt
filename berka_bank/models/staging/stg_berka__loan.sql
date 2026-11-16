select
    loan_id,
    account_id,
    cast(date as date) as loan_date,
    cast(amount as decimal(12, 2)) as loan_amount,
    duration as duration_months,
    cast(payments as decimal(12, 2)) as monthly_payment,
    status as status_code,
    case status
        when 'A' then 'finished_paid'
        when 'B' then 'finished_unpaid'
        when 'C' then 'running_ok'
        when 'D' then 'running_in_debt'
    end as loan_status
from {{ source('raw', 'loan') }}
