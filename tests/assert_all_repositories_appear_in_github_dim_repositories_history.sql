-- Assert that all repositories in the source table appear in github_dim_repositories_history
SELECT
	repositories.full_name
FROM {{ source('github_source', 'repositories') }} repositories
WHERE NOT EXISTS (
	SELECT github_dim_repositories_history.full_name
	FROM {{ ref('github_dim_repositories_history') }} github_dim_repositories_history
	WHERE github_dim_repositories_history.full_name = repositories.full_name)