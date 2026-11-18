-- Each balance should equal the previous balance plus the signed amount.
-- Only single-transaction days are checked, because same-day row order is unreliable.
-- Tolerance of 1 unit: the source data has off-by-one gaps (see README).
with base as (
    select
        account_id,
        transaction_date,
        trans_id,
        balance_after,
        signed_amount,
        count(*) over (partition by account_id, transaction_date) as n_day
    from {{ ref('fct_transactions') }}
),

t as (
    select
        *,
        lag(balance_after) over w as prev_balance,
        lag(n_day) over w as prev_n_day
    from base
    window w as (partition by account_id order by transaction_date, trans_id)
)

select
    account_id,
    transaction_date,
    trans_id,
    prev_balance,
    signed_amount,
    balance_after,
    balance_after - prev_balance - signed_amount as gap
from t
where prev_balance is not null
    and n_day = 1
    and prev_n_day = 1
    and abs(balance_after - prev_balance - signed_amount) > 1
