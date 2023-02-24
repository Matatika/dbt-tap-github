-- Assert that github_dim_repositories_history, github_fact_daily_stats and github_fact_stars
--  and github_fact_stars contain no future dates
SELECT
    date_day
FROM {{ ref('github_dim_repositories_history') }}
WHERE date_day > current_date
UNION
SELECT
    date_day
FROM {{ ref('github_fact_daily_stats') }}
WHERE date_day > current_date
UNION
SELECT
    date_day
FROM {{ ref('github_fact_stars') }}
WHERE date_day > current_date
