select
    loan_id,
    account_id,
    loan_date,
    loan_amount,
    duration_months,
    monthly_payment,
    loan_status,
    loan_status in ('finished_unpaid', 'running_in_debt') as is_problem_loan
from {{ ref('stg_berka__loan') }}
