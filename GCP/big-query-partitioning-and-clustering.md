# BigQuery Partitioning

##  📥 Partitioned Tables

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1612011201004_image.png)

For example, assume we have partitioned this table by the eventDate column, 
BigQuery will then change its internal Storage so the **dates are stored**  📥  
**in separate shards and** a table partitioned by a date or timestamp column 📅 

**WHERE clause  will have to read only 2/5 of the full data-set** 
and will process no data if no partitions that match the filtering criteria 

```sql
CREATE OR REPLACE TABLE ecommerce.partitions
 PARTITION BY date_formatted
 OPTIONS(
   description="a table partitioned by date"
 ) AS


SELECT
  COUNT(transactionId) AS total_transactions,
  PARSE_DATE("%Y%m%d", date) AS date_formatted
FROM
  `data-to-insights.ecommerce.all_sessions`
WHERE
  transactionId IS NOT NULL
GROUP BY date
```

```sql
SELECT
  total_transactions,
  date_formatted
FROM
  `data-to-insights.ecommerce.partitions`
WHERE date_formatted >= '2018-01-01'
ORDER BY date_formatted DESC
```

```text
# .7 seconds, 0 bytes processed
# it knows there are no 2018 partitions
```

### **THIS can lead to dramatic cost and time savings**

#### COMPARE vs NON-PARTITIONED TABLE

```sql
SELECT
  COUNT(transactionId) AS total_transactions,
  date
FROM
  `data-to-insights.ecommerce.all_sessions`
WHERE
  transactionId IS NOT NULL
  AND PARSE_DATE("%Y%m%d", date) >= '2018-01-01'
GROUP BY date
ORDER BY date DESC
```

```text
# This query will process 205.9 MB when run.
# 1.3 seconds, 0 results

We processed data but got no results! 
```

----

### 🔏  **A partitioned table maintains these properties across all operations that modify it**:

- Query jobs, 
- DML statements, 
- DDL statements, 
- Load jobs, 
- Copy jobs


![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1612011273105_image.png)


This slide shows how to migrate an existing table to an ingestion time partitioned table. 

- Using a destination table, it will cost you one table scan. 
- As new records are added to the table, they will be put into the right partition 🗃️ 
    - BigQuery creates new 📆 date-based partitions automatically with no need for additional maintenance. 
        - In addition, you can specify ⏳ expiration time for data in the partitions


![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1656163597676_Screenshot+2022-06-25+at+15.26.32.png)

‼️isolating the field on the left side ensures that BigQuery **can quickly discard unnessary partitions**

### Create time-unit-partitioned tables

```sql
# partition by date
 CREATE TABLE
   mydataset.newtable (transaction_id INT64,
     transaction_date DATE)
 PARTITION BY
   transaction_date
 OPTIONS (
  partition_expiration_days=3,
  description="a table partitioned by transaction_date",
  require_partition_filter=true
)
```

```sql
# partition by hour
CREATE TABLE
   mydataset.newtable (transaction_id INT64,
     transaction_ts TIMESTAMP)
 PARTITION BY
   TIMESTAMP_TRUNC(transaction_ts, HOUR)
 OPTIONS (
  partition_expiration_days=3,
  description="a table partitioned by transaction_date",
  require_partition_filter=true
)
```

```sql
# partition by month
 CREATE TABLE
   mydataset.newtable (transaction_id INT64,
     transaction_ts TIMESTAMP)
 PARTITION BY
   TIMESTAMP_TRUNC(transaction_ts, MONTH)
 OPTIONS (
  partition_expiration_days=3,
  description="a table partitioned by transaction_date",
  require_partition_filter=true
)
```

```python
# from google.cloud import bigquery
# client = bigquery.Client()
# project = client.project
# dataset_ref = bigquery.DatasetReference(project, 'my_dataset')

table_ref = dataset_ref.table("my_partitioned_table")
schema = [
    bigquery.SchemaField("name", "STRING"),
    bigquery.SchemaField("post_abbr", "STRING"),
    bigquery.SchemaField("date", "DATE"),
]
table = bigquery.Table(table_ref, schema=schema)
table.time_partitioning = bigquery.TimePartitioning(
    type_=bigquery.TimePartitioningType.DAY,
    field="date",  # name of column to use for partitioning
    expiration_ms=7776000000,
    require_partition_filter=true
)  # 90 days

table = client.create_table(table)

print(
    "Created table {}, partitioned on column {}".format(
        table.table_id, table.time_partitioning.field
    )
)
```

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1612011324354_image.png)


A good practice is to acquire the queries always include the partition filter 🔖 

‼️ ⚠️ Make sure that the partition field is isolated on the left side because that's the only way that BigQuery can quickly discard unnecessary partitions

```sql
# standardSQL
/* Often performs better */

SELECT
  field1
FROM
  dataset.table1
WHERE
  _PARTITIONTIME > TIMESTAMP_SUB(TIMESTAMP('2016-04-15'), INTERVAL 5 DAY)
```

```sql
# standardSQL
/* Can be slower */
  
SELECT
  field1
FROM
dataset.table1

WHERE TIMESTAMP_ADD(_PARTITIONTIME, INTERVAL 5 DAY) > TIMESTAMP("2016-04-15")
```

```sql
SELECT
  column,
  _PARTITIONTIME AS pt,
FROM
  dataset.table2
WHERE
  -- This filter condition limits the scanned partitions:
  _PARTITIONTIME BETWEEN TIMESTAMP('2017-01-01') AND TIMESTAMP('2017-03-01')
  
  -- This one doesn't, because it uses dynamic table values:
  AND _PARTITIONTIME = (SELECT MAX(timestamp) from dataset.table1)
```

```sql
-- Scans all partitions of table2. No pruning.
SELECT
  field1,
  _PARTITIONTIME as pt
FROM
  dataset.table2
WHERE
  _PARTITIONTIME + field1 = TIMESTAMP('2016-03-28');
---does not limit the scanned partitions, because field1 is a column in the table
```

⚠️ **TO LIMIT the partitions scanned**, 
don't include any other columns in a `_PARTITIONTIME` filter

---

### Querying ingestion-time partitioned tables using pseudo columns

When you create an ingestion-time partitioned table, two pseudo columns are added to the table: a `_PARTITIONTIME` pseudo column and a `_PARTITIONDATE` pseudo column. 

- The `_PARTITIONTIME` pseudo column contains a date-based timestamp for data that is loaded into the table. 


- The `_PARTITIONDATE` pseudo column contains a date representation. 


- ⚠️ Both pseudo column names are reserved, which means that you cannot create a column with either name in any of your tables.

```sql
# This example demonstrates limiting the number of scanned partitions using 
# a pseudo column filter in a subquery

SELECT
  column1,
  column2,
  _PARTITIONTIME as pt
FROM (
      SELECT
        column1,
        column2,
        _PARTITIONTIME as pt
      FROM
        dataset.table
      WHERE
        _PARTITIONTIME = TIMESTAMP('2016-03-28')
) t1
CROSS JOIN
  dataset.table t2
WHERE
  t1.column2 = "one"
```


### 📍Creating integer partitioned tables
https://cloud.google.com/bigquery/docs/creating-integer-range-partitions#console


```sql
CREATE TABLE
  mydataset.newtable
PARTITION BY 
  RANGE_BUCKET(customer_id, GENERATE_ARRAY(0, 100, 10))
AS 
SELECT 
  1 AS customer_id, 
  DATE "2019-10-01" AS date1
```

```python
from google.cloud import bigquery
    
    # Construct a BigQuery client object.
    client = bigquery.Client()
    
    # TODO(developer): Set table_id to the ID of the table to create.
    # table_id = "your-project.your_dataset.your_table_name"
    
    schema = [
        bigquery.SchemaField("full_name", "STRING"),
        bigquery.SchemaField("city", "STRING"),
        bigquery.SchemaField("zipcode", "INTEGER"),
    ]
    
    table = bigquery.Table(table_id, schema=schema)
    table.range_partitioning = bigquery.RangePartitioning(
        # To use integer range partitioning, select a top-level REQUIRED /
        # NULLABLE column with INTEGER / INT64 data type.
        field="zipcode",
        range_=bigquery.PartitionRange(start=0, end=100000, interval=10),
    )
    table = client.create_table(table)  # Make an API request.
    print(
        "Created table {}.{}.{}".format(table.project, table.dataset_id, table.table_id)
    )
```


### ✅ BEST PRACTICES for partition pruning

* ✅ **USE A CONSTANT FILTER EXPRESSION**

If you use dynamic expressions in your query filter, BigQuery **scans** all of the partitions.

```sql
# prunes partitions because the filter contains a constant expression
SELECT
  t1.name,
  t2.category
FROM
  table1 AS t1
INNER JOIN
  table2 AS t2
ON t1.id_field = t2.field2
WHERE
  t1.ts = CURRENT_TIMESTAMP()
```

```sql
# does not prune partitions, because the filter is not a constant expression
# it depends on the dynamic values of the timestamp and key fields
  
SELECT
  t1.name,
  t2.category
FROM
  table1 AS t1
INNER JOIN
  table2 AS t2
ON
  t1.id_field = t2.field2
WHERE
  t1.ts = (SELECT timestamp from table3 where key = 2)
```

* ✅ **ISOLATE THE PARTITION COLUMN IN YOUR FILTER**

Filters that require data from multiple fields to compute will not prune partitions. For example, a query with a date comparison using the partitioning column and a second field, or queries containing some field concatenations will not prune partitions.

For example, the following filter does not prune partitions because 
it requires a computation based on the partitioning `ts` field and a second field `ts2`:

`WHERE TIMESTAMP_ADD(ts, INTERVAL 6 HOUR) > ts2`

* ✅ **REQUIRE A PARTITION FILTER IN QUERIES**

When you create a partitioned table, you can require the use of predicate filters 
by enabling the Require partition filter option. 

When this option is applied, attempts to query the partitioned table w
ithout specifying a WHERE clause produce the following error:

`Cannot query over table 'project_id.dataset.table' without a filter that can 
be used for partition elimination.`


---

# BigQuery Clustering

[BQ clustering](https://cloud.google.com/bigquery/docs/clustered-tables) 
can dramatically reduce the time and cost of queries on large datasets.

The [Wikipedia pageviews](https://console.cloud.google.com/bigquery?sq=316488749670:97c8ffb43aad44a98a5ff80e1375c62b) query runs over a dataset which is partitioned but not clustered:

```sql
# https://medium.com/google-cloud/bigquery-optimized-cluster-your-tables-65e2f684594b
SELECT
  title, 
  sum(views) AS sumViews
FROM `fh-bigquery.wikipedia_v2.pageviews_2018` # Change to v3 for clustered table
WHERE datehour >= "2018-01-01"
AND wiki IN ("en","en.m")
AND regexp_contains(title, "G.*o.*o.*g.*")
GROUP BY title
ORDER BY sumViews DESC
```

To show the benefit of partitioning, change the date to "2018-07-01" and note the reduction in bytes ingested. Run the query. Expand the Execution details tab and note:
* total bytes processed (which should match the validator's number in green) * elapsed time
* slot time
* bytes shuffled
* number of rows ingested in the first stage of the query

Now modify the query to use a clustered version of the dataset by changing the dataset name from "v2" to "v3". Note the ~50% reduction in all the above metrics. BQ can take advantage of clustering even for queries involving LIKE and regular expressions as long as the first letter is fixed. Note that the total bytes processed is less than the validator's number because the validator does not yet take into account clustering, but the user is only billed for the amount actually processed.

We can infer that BQ uses a fairly large block size for clustering. 

In this case, it's still having to ingest about half the blocks (~1TB), 
suggesting that titles beginning with A-L may be clustered together, 
or perhaps A-G and G-L. In this example, the benefit from clustering i
s therefore not as great as it would be in a larger dataset. 

It is possible for a query over a clustered petabyte dataset to result in 
ingest of only a few hundred GB.


## 🗃️ Clustered Tables
![In this example, the tables partitioned by eventDate and clustered by user ID.](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1612011588254_image.png)


✅ Clustering can improve the performance of certain types of queries, such as: 

    - queries that use filter clauses 
    - those that aggregates data.

Once data is written to a cluster table by a query or a low job, 
⬆️ ⬇️ BigQuery sorts the data using the values in the clustering columns

    - These values are used to organize the data and some multiple blocks and BigQuery storage. 

When you submit a query containing a closet filters data based on the clustering columns, BigQuery uses assorted blocks to eliminate scans of unnecessary data. 

Similarly, when you submit a query that aggregates data based on the values in the clustering columns, performance is improved because the sorted blocks co-locate rows with similar values. 


### Creating Clustered Tables
![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1612011401897_image.png)


ℹ️ The columns you specify in the cluster are used to co-locate related data. 


- ⚠️ When you cluster a table using multiple columns, the order of columns you specify is important.
- ▶️ The order of the specified columns determines the sort order of the data. 

```sql
# partition by date, clustered by userID
  CREATE TABLE
    mydataset.newtable (transaction_id INT64,
      transaction_date DATE)
    
    PARTITION BY transaction_date
    CLUSTER BY UserID
    OPTIONS (
      partition_expiration_days=3,
      description="partitioned by transaction_date and clustered by user",
      require_partition_filter=true
    )
```


⚠️ Currently **CLUSTERING** is not supported for non-partitioned tables ⚠️ 

When you use clustering and partitioning together:

📥 the data can be partitioned by a date or timestamp column 

🗃️ then clustered on a different set of columns 

```python
from google.cloud import bigquery

# Construct a BigQuery client object.
client = bigquery.Client()
    
# TODO: Set table_id to the ID of the table to create.
# table_id = "your-project.your_dataset.your_table_name"
    
schema = [
        bigquery.SchemaField("full_name", "STRING"),
        bigquery.SchemaField("city", "STRING"),
        bigquery.SchemaField("zipcode", "INTEGER"),
    ]
    
table = bigquery.Table(table_id, schema=schema)
table.clustering_fields = ["city", "zipcode"]
table = client.create_table(table)  # Make an API request.
    
print(
        "Created clustered table {}.{}.{}".format(
            table.project, table.dataset_id, table.table_id
        )
    )
```


![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1612011732980_image.png)

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1612011449506_image.png)

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1612011507769_image.png)


✅  **CLUSTERING** provides **additional cost and performance benefits** to the partitioning benefits ✅ 

```python
from google.cloud import bigquery
    
# Construct a BigQuery client object.
client = bigquery.Client()
    
# TODO: Set table_id to the ID of the table to create.
# table_id = "your-project.your_dataset.your_table_name"
    
job_config = bigquery.LoadJobConfig(
    skip_leading_rows=1,
    source_format=bigquery.SourceFormat.CSV,
    schema=[
            bigquery.SchemaField("timestamp", bigquery.SqlTypeNames.TIMESTAMP),
            bigquery.SchemaField("origin", bigquery.SqlTypeNames.STRING),
            bigquery.SchemaField("destination", bigquery.SqlTypeNames.STRING),
            bigquery.SchemaField("amount", bigquery.SqlTypeNames.NUMERIC),
        ],
    time_partitioning=bigquery.TimePartitioning(field="timestamp"),
    clustering_fields=["origin", "destination"],
    )
    
job = client.load_table_from_uri(
        ["gs://cloud-samples-data/bigquery/sample-transactions/transactions.csv"],
        table_id,
        job_config=job_config,
    )
    
job.result()  # Waits for the job to complete.
    
table = client.get_table(table_id)  # Make an API request.
print(
    "Loaded {} rows and {} columns to {}".format(
            table.num_rows, len(table.schema), table_id
        )
    )
```


### ✅  BEST PRACTICES when querying CLUSTERED TABLES

❌ Do not use clustered columns in complex filter expressions
If you use a clustered column in a complex filter expression, the performance of the query is not optimized because block pruning cannot be applied.

👎 For example, the following query will not prune blocks because a clustered column — `customer_id` — is used in a function in the filter expression.

```sql
SELECT
SUM(totalSale)

FROM
  `mydataset.ClusteredSalesData`
    
WHERE
  CAST(customer_id AS STRING) = "10000"
```


👍 To optimize query performance by pruning blocks, use simple filter expressions like the following. In this example, a simple filter is applied to the clustered column — `customer_id`

```sql
SELECT
  SUM(totalSale)
FROM
  `mydataset.ClusteredSalesData`
WHERE
  customer_id = 10000
```

 ❌ Do not compare clustered columns to other columns
If a filter expression compares a clustered column to another column (either a clustered column or a non-clustered column), the performance of the query is not optimized because block pruning cannot be applied

👇 The following query does not prune blocks because the filter expression compares a clustered column — `customer_id` to another column — `order_id`

```sql
SELECT
SUM(totalSale)

FROM
  `mydataset.ClusteredSalesData`

WHERE
  customer_id = order_id
```


## 📖 Further References:

### PARTITIONED TABLES
* https://cloud.google.com/bigquery/docs/creating-partitioned-tables
* https://cloud.google.com/bigquery/docs/creating-partitioned-tables#sql
* https://cloud.google.com/bigquery/docs/creating-partitioned-tables#sql_2
* https://cloud.google.com/bigquery/docs/managing-partitioned-tables
* https://cloud.google.com/bigquery/docs/querying-partitioned-tables

### CLUSTERED TABLES
* https://cloud.google.com/bigquery/docs/creating-clustered-tables#python_1
* https://cloud.google.com/bigquery/docs/querying-clustered-tables
