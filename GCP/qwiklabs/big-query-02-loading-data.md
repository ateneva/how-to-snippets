## Overview
BigQuery is Google's fully managed, NoOps, low cost analytics database. 

With BigQuery you can query terabytes and terabytes of data without having 
any infrastructure to manage or needing a database administrator. 

BigQuery uses SQL and can take advantage of the pay-as-you-go model. 

BigQuery allows you to focus on analyzing data to find meaningful insights.


### What you'll learn:
* Loading data into BigQuery from various sources

* Loading data into BigQuery using the CLI and Console

* Using DDL to create tables

### Create a DATASET to store tables

### Ingest a new dataset from CSV

### Ingest a new dataset from Cloud Storage

```bash
bq load \
--source_format=CSV \
--autodetect \
--noreplace  \
nyctaxi.2018trips \
gs://cloud-training/OCBL013/nyc_tlc_yellow_trips_2018_subset_2.csv
```

### Create tables from other tables with DDL
The 2018trips table now has trips from throughout the year. 
What if you were only interested in January trips? 

For the purpose of this lab, we will keep it simple and focus only on pickup date and time.
Let's use DDL to extract this data and store it in another table

In the Query Editor, run the following CREATE TABLE command:

```sql
#standardSQL
CREATE TABLE
  nyctaxi.january_trips AS
SELECT
  *
FROM
  nyctaxi.2018trips
WHERE
  EXTRACT(Month
  FROM
    pickup_datetime)=1;
```

```sql
#standardSQL
SELECT
  *
FROM
  nyctaxi.january_trips
ORDER BY
  trip_distance DESC
LIMIT
  1
```