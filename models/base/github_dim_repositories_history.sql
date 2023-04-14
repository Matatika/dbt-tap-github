{{ config(materialized='table') }}

with repositories as (
    select * from {{ ref('github_dim_repositories_snapshot') }}
),
pull_requests as (
    select * from {{ ref('github_dim_pull_requests_snapshot') }}
),
most_recent_daily_repositories as (
    select
        *
    from repositories r1
    where not exists (select * from repositories r2
                    where r2."_sdc_batched_at"::date = r1."_sdc_batched_at"::date
                    and r2."_sdc_batched_at" > r1."_sdc_batched_at"
                    and r2.id = r1.id)
),
most_recent_pull_requests_per_day as (
    select
        *
    from pull_requests pr1
    where not exists (select * from pull_requests pr2
                where pr2."_sdc_batched_at"::date = pr1."_sdc_batched_at"::date
                and pr2."_sdc_batched_at" > pr1."_sdc_batched_at"
                and pr2.id = pr1.id)
),
dates as (
    select
        *
    from {{ ref('dim_date') }}
    where date_day <= current_date
),
count_pull_requests_per_day_per_org_per_repo as (
    select
        "_sdc_batched_at"::date "date"
        , org
        , repo
        , coalesce(count(*), 0) "open_pull_requests"
    from most_recent_pull_requests_per_day
    where state = 'open'
    group by "date", org, repo
),
join_repositories as (
    select
        *
    from dates d
    left join most_recent_daily_repositories mrdr on mrdr._sdc_batched_at::date = d.date_day
),
final as (
    select
        jr.*
        , jpr.open_pull_requests
    from join_repositories jr
    left join count_pull_requests_per_day_per_org_per_repo jpr on jpr.date = jr.date_day
    and jpr.org = jr.org
    and jpr.repo = jr.repo
)

select * from final