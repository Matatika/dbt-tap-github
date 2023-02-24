# dbt-tap-github
From [Matatika](https://www.matatika.com/), a dbt package to help with using your GitHub data to let you track targets, see trends and manage your GitHub data.

## Overview

This dbt package contains models designed for use with:
- Meltano's [tap-github](https://github.com/MeltanoLabs/tap-github)
- Transferwise's [target-postgres](https://github.com/transferwise/pipelinewise-target-postgres)

The main focus of the package is to transform stream `tap-github` data into usable analytics models.

We have created a snapshot so with daily data syncs and dbt runs, you can get and track historical github information.

This package along with the [Analyze Bundle](https://github.com/Matatika/analyze-github) are designed intended to work together to provide instant insights on the [Matatika Platform](https://www.matatika.com).

## Models

| **model**              | **description** |
| ---------------------- | ------------------------------------------------------------- |
| [dim_date](models/base/dim_date.sql) | Date dimension |
| [github_dim_repositories_snapshot](snapshots/github_dim_repositories_snapshot.sql) | Daily github repository snapshot model |
| [github_dim_repositories_history](models/base/dim_repositories_history.sql) | Github repository history |
| [github_fact_daily_stats](models/base/fact_daily_.sql) | Github issues and pull request stats by day |
| [github_fact_stars](models/base/trello_lists.sql) | Github stars gained per day | 


## Installation Instructions
Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions, or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.

Include in your `packages.yml`
```yaml
packages:
  - git: https://github.com/Matatika/dbt-tap-guthub.git
```

### One time setup (after creating a python virtual environment)

```
pip install dbt
dbt deps
```

### development

```
dbt test
```

## Database Support
This package has been tested on Postgres and Snowflake.

## Cloud hosting and SaaS
Deploy on the Matatika Platform within minutes. [www.matatika.com](https://www.matatika.com)

## Contributions

Additional contributions to this package are very welcome! Please create issues
or open PRs against `master`. Check out 
[this post](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) 
on the best workflow for contributing to a package.

## Resources:
- Have questions, feedback, or need help? Please email us at support@matatika.com
- Find all of Matatika's pre-built dbt packages in our [dbt hub](https://hub.getdbt.com/Matatika/)
- Learn how to orchestrate [dbt transformations with Matatika](https://www.matatika.com/docs/getting-started/)
- Learn more about Matatika [in our docs](https://www.matatika.com/docs/introduction)
- Learn more about dbt [in the dbt docs](https://docs.getdbt.com/docs/introduction)

---

Copyright &copy; 2023 Matatika
