{% snapshot github_dim_pull_requests_snapshot %}

    {{ config(
            target_schema=var('schema'),
            unique_key='id',
            strategy='timestamp',
            updated_at='_sdc_batched_at'
        )
    }}

    with pull_requests as (
        select * from {{ source('github_source', 'pull_requests') }}
    )

    select * from pull_requests
{% endsnapshot %}