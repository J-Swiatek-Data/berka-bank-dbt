{% snapshot snap_accounts %}

{{
    config(
        target_schema='snapshots',
        unique_key='account_id',
        strategy='check',
        check_cols=['statement_frequency', 'district_id']
    )
}}

select * from {{ ref('stg_berka__account') }}

{% endsnapshot %}
