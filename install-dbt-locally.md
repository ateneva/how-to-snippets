
# What is Analytics Engineering

* **Data Engineer**
  * build custom data integrations
  * manage overall pipeline orchestration
  * develop & deploy machine learning endpoints
  * build and maintain the data platform
  * data warehouse performance optimizations


* **Analytics Engineer**
  * provide cleaned transformed data, ready for analysis
  * apply software engineering best practices to analytics code
    * version control
    * testing
    * continuous integration
  * maintain data documentation and definitions
  * train business users on how to use data vizualization tools


* **Data Analyst**
  * deep insights work
    - e.g. why did churn spike last month
    - e.g. what are the best acquisition channels
  * work with business users to understand data requirements
  * build critical dashboards
  * forecasting

https://www.getdbt.com/what-is-analytics-engineering/

## What is dbt?

* **dbt** (data build tool) enables analytics engineers to transform data in their warehouses by simply writing select statements.


* **dbt** handles turning these select statements into tables and views.


* **dbt** does the T in ELT (Extract, Load, Transform) processes
  * it doesn’t extract or load data, but it’s extremely good at transforming data that’s already loaded into your warehouse.

https://docs.getdbt.com/docs/introduction

## DBT installation

* ### clone the dbt repository and set up a virtual environment
```bash
python3.8 -m venv dbt_env
source dbt_env/bin/activate
python3 --version
```

* ### install dbt with brew
```bash
brew update
brew install git
brew tap dbt-labs/dbt
brew install dbt-postgres

dbt --version
```
https://docs.getdbt.com/dbt-cli/install/homebrew

* ### install dbt with pip
```bash
pip install dbt==0.20.1

OR

pip install \
  dbt-core \
  dbt-postgres \
  dbt-redshift \
  dbt-snowflake \
  dbt-bigquery
```
* https://docs.getdbt.com/dbt-cli/install/pip

* ### install dbt dependencies
```bash
dbt deps
```

### create a local profile to store your connection details and credentials
```bash
cp profiles.example.yml ~/.dbt/profiles.yml
```

```bash
default:
  outputs:
    dev:
      type: <bigquery | postgres | redshift | snowflake | other>
      threads: 1
      host: dbhost
      port: 5439
      user: changeme
      pass: changeme
      dbname: dbname
      schema: changeme
  target: dev
```
* https://docs.getdbt.com/reference/profiles.yml

**DBT & BigQuery**
```bash
my-bigquery-db:
  target: dev
  outputs:
    dev:
      type: bigquery
      method: service-account
      project: [GCP project id]
      dataset: [the name of your dbt dataset]
      threads: [1 or more]
      keyfile: [/path/to/bigquery/keyfile.json]
      [<optional_config>](#optional-configurations): <value>
```
* https://docs.getdbt.com/reference/warehouse-profiles/bigquery-profile

**DBT & Redshift**
```bash
company-name:
  target: dev
  outputs:
    dev:
      type: redshift
      host: hostname.region.redshift.amazonaws.com
      user: username
      password: password1
      port: 5439
      dbname: analytics
      schema: analytics
      threads: 4
      keepalives_idle: 240 # default 240 seconds
      connect_timeout: 10 # default 10 seconds
      # search_path: public # optional, not recommended
      sslmode: [optional, set the sslmode used to connect to the database (in case this parameter is set, will look for ca in ~/.postgresql/root.crt)]
      ra3: true # enables cross-database sources
```
* https://docs.getdbt.com/reference/warehouse-profiles/redshift-profile

### verify successful setup
```bash
dbt debug
```

## DBT materializations
* **TABLE** -- the model is rebuilt as a table on each run, via a `CREATE TABLE AS` statement.
  * **Pros**: Tables are fast to query
  * **Cons**:
    * Tables can take a long time to rebuild, especially for complex transformations
    * New records in underlying source data are not automatically added to the table
  * **Advice**:
    * Use the table materialization for any models being queried by BI tools, to give your end user a faster experience
    * Also use the table materialization for any slower transformations that are used by many downstream models

```json
{{
    config(
        materialized='table',
        unique_key='restaurant_id',
        dist='restaurant_id',
        sort=['restaurant_last_processed_at', 'insert_date']
    )
}}
```

* **VIEW** -- **the model is rebuilt as a view on each run, via a `CREATE VIEW AS` statement**.

  * **Pros**:
    * No additional data is stored, views on top of source data will always have the latest records in them.
  * **Cons**:
    * Views that perform significant transformation, or are stacked on top of other views, are slow to query.
  * **Advice**:
    * Generally start with views for your models, and only change to another materialization when you're noticing performance problems.
    * Views are best suited for models that do not do significant transformation, e.g. renaming, recasting columns.

```json
{{
    config(
        materialized='view',
        unique_key='restaurant_id',
        dist='restaurant_id',
        sort=['restaurant_last_processed_at', 'insert_date']
    )
}}
```

* **INCREMENTAL** -- models allow dbt to insert or update records into a table since the last time that dbt was run
  * **Pros**:
    * You can significantly reduce the build time by just transforming new records
  * **Cons**:
    * Incremental models require extra configuration and are an advanced usage of dbt.
  * **Advice**:
    * Incremental models are best for event-style data
    * Use incremental models when your dbt runs are becoming too slow (i.e. don't start with incremental models)

```json
{{
    config(
        materialized='incremental',
        unique_key='restaurant_id',
        dist='restaurant_id',
        sort=['restaurant_last_processed_at', 'insert_date']
    )
}}
```
https://docs.getdbt.com/docs/building-a-dbt-project/building-models/configuring-incremental-models

Incremental models are built as tables in your data warehouse
- the first time a model is run, the table is built by transforming all rows of source data.
  - On subsequent runs, dbt transforms **only the rows in your source data that you tell dbt to filter for**,
    - **inserting them into the table** that has already been built (the target table)

```json
{{
    config(
        materialized='incremental',
        unique_key='date_day'
    )
}}

select
    date_trunc('day', event_at) as date_day,
    count(distinct user_id) as daily_active_users

from raw_app_data.events


{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where date_day >= (select max(date_day) from {{ this }})

{% endif %}

group by 1
```
**Unique_key** is an optional parameter for incremental models that specifies a field which should be unique within your model.

**If the unique key of an existing row in your target table matches one of your incrementally transformed rows**, the existing row will be updated.

**This ensures that you don't have multiple rows in your target table for a single row in your source data.**

### What if my incremental model changes?

For dbt versions

To force dbt to rebuild the entire incremental model from scratch, use the --full-refresh flag on the command line.
This flag will cause dbt to drop the existing target table in the database before rebuilding it for all-time.

```bash
$ dbt run --full-refresh -m +<model name>+
```
https://docs.getdbt.com/docs/building-a-dbt-project/building-models/configuring-incremental-models

* **EPHEMERAL** -- models are not directly built into the database.
  * Instead, dbt will interpolate the code from this model into dependent models as a common table expression

* **Pros**:
  * You can still write reusable logic
  * Ephemeral models can help keep your data warehouse clean by reducing clutter (also consider splitting your models across multiple schemas by using custom schemas).


* **Cons**:
  * You cannot select directly from this model.
  * Operations (e.g. macros called via dbt run-operation cannot ref() ephemeral nodes)
  * Overuse of the ephemeral materialization can also make queries harder to debug.


* **Advice**: Use the ephemeral materialization for:
  * very light-weight transformations that are early on in your DAG
    * are only used in one or two downstream models, and
    * do not need to be queried directly

```json
{{
    config(
        materialized='ephemeral',
        unique_key='restaurant_id',
        dist='restaurant_id',
        sort=['restaurant_last_processed_at', 'insert_date']
    )
}}
```
* https://docs.getdbt.com/docs/building-a-dbt-project/building-models/materializations

## Handy DBT commands
```bash

dbt debug                         # check if your dbt setup is configured properly
dbt --version                     # check which dbt version you're running

dbt compile                       # check for syntax errors
dbt run                           # run all dbt models in the dependency graph
dbt run -m <model name>           # run only a specific model
dbt run -m +<model name>          # run a model and its upstream dependencies
dbt run -m <model_name>+          # run a model and its downstream dependencies
dbt run -m +<model name>+         # run a model and its upstream and downstream dependencies
dbt run -m source:<source name>+  # run all models that depend on a given source

# As of dbt 1.0.3 you can also use the --select flag to run models
dbt run --select <model name>           # run only a specific model
dbt run --select +<model name>          # run a model and its upstream dependencies
dbt run --select <model_name>+          # run a model and its downstream dependencies
dbt run --select +<model name>+         # run a model and its upstream and downstream dependencies
dbt run --select source:<source name>+  # run all models that depend on a given source

# force rebuiild the entire incremental model from scratch
dbt run --full-refresh -m +<model name>
dbt run --full-refresh --select <model name>
 

# run dbt test(s)
dbt test -m <name_of_the_sql_file_of_the_test>
dbt test -m <subdirectory_within_where_test_files_exist>

dbt test --select <name_of_the_sql_file_of_the_test>
dbt test --select <subdirectory_within_where_test_files_exist>

dbt test --select source:<source name>+  # run all tests defined on a source
```
* https://docs.getdbt.com/reference/node-selection/syntax
* https://docs.getdbt.com/reference/node-selection/graph-operators
* https://docs.getdbt.com/reference/commands/compile
* https://docs.getdbt.com/reference/commands/snapshot
