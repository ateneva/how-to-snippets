## Overview
BigQuery is Google's fully managed, NoOps, low cost analytics database. 
With BigQuery you can query terabytes and terabytes of data without having any 
infrastructure to manage or needing a database administrator. 

BigQuery uses SQL and can take advantage of the pay-as-you-go model. 

BigQuery allows you to focus on analyzing data to find meaningful insights.

This lab is an in-depth walkthrough of working with semi-structured data (ingesting JSON, Array data types) inside of BigQuery. Denormalizing your schema into a single table with nested and repeated fields can yield performance improvements, but the SQL syntax for working with array data can be tricky. You will practice loading, querying, troubleshooting, and unnesting various semi-structured datasets.

## Objectives
In this lab, you learn about the following:

* Loading semi-structured JSON into BigQuery

* Creating and querying arrays

* Creating and querying structs

* Querying nested and repeated fields

---

### Practice Working with Arrays

Normally in SQL you will have a single value for each row like this list of fruits below:

| Row | Fruit      |
| --- | ---------- |
| 1   | raspberry  |
| 2   | blackberry |
| 3   | strawberry |
| 4   | cherry     |

What if you wanted a list of fruit items for each person at the store? It could look something like this:

| Row | Fruit      | Person    |
| --- | ---------- | --------- |
| 1   | raspberry  | sally     |
| 2   | blackberry | sally     |
| 3   | strawberry | sally     |
| 4   | cherry     | sally     |
| 5   | orange     | frederick |
| 6   | apple      | frederick |

In traditional relational database SQL, you would look at the repetition of names and immediately think to split the above table into two separate tables: Fruit Items and People. 

**That process is called normalization (going from one table to many).** 

**This is a common approach for transactional databases like mySQL.**

**For data warehousing, data analysts often go the reverse direction (denormalization)** 
and bring many separate tables into one large reporting table.

An easier way to interpret the Fruit array:

| Row | Fruit (array)                               | Person    |
| --- | ------------------------------------------- | --------- |
| 1   | [raspberry, blackberry, strawberry, cherry] | sally     |
| 2   | [orange, apple]                             | frederick |

Both of these tables are exactly the same. There are two key learnings here:

- An array is simply a list of items in brackets [ ] 💡

- BigQuery visually displays arrays as flattened. It simply lists the value in the array vertically (note that all of those values still belong to a single row)

```sql
# standardSQL
SELECT
['raspberry', 'blackberry', 'strawberry', 'cherry'] AS fruit_array


# standardSQL
SELECT
['raspberry', 'blackberry', 'strawberry', 'cherry', 1234567] AS fruit_array
```


❌ Unlike Python Lists, BQ arrays must be if of an identical type ‼️ 

#### Loading semi-structured JSON into BigQuery
What if you had a JSON file that you needed to ingest into BigQuery?

1. Create a new table in the `fruit_store` data set.
2. Add the following details for the table:
    - Source: Choose Google Cloud Storage in the Create table from dropdown.
    
    - Select file from GCS bucket: `gs://data-insights-course/labs/optimizing-for-performance/shopping_cart.json` File format: JSONL (Newline delimited JSON)
    
    - Schema: Check Auto detect (Schema and input parameters).
3. Call the new table "fruit_details".
4. Click Create table.

In the schema, note that `fruit_array` is marked as REPEATED which means it's an array.

📋 **REACAP**:
- BigQuery natively supports arrays
- **Array values must share a data type**
- Arrays are called **REPEATED** fields in BigQuery ‼️


### Creating your own arrays with ARRAY_AGG()
Don't have arrays in your tables already? You can create them!
Copy and Paste the below query to explore this public dataset

```sql
SELECT
  fullVisitorId,
  date,
  v2ProductName,
  pageTitle
FROM `data-to-insights.ecommerce.all_sessions`
WHERE visitId = 1501570398
ORDER BY date
```

Now, we will use the `ARRAY_AGG()` function to aggregate our string values into an array. 
and paste the below query to explore this public dataset:

```sql
SELECT
  fullVisitorId,
  date,
  ARRAY_AGG(v2ProductName) AS products_viewed,
  ARRAY_AGG(pageTitle) AS pages_viewed
FROM `data-to-insights.ecommerce.all_sessions`
WHERE visitId = 1501570398
GROUP BY fullVisitorId, date
ORDER BY date
```

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1612008364341_image.png)

Next, we will use the `ARRAY_LENGTH()` function to count the number of pages and products that were viewed.

```sql
SELECT
  fullVisitorId,
  date,
  ARRAY_AGG(v2ProductName)                AS products_viewed,
  ARRAY_LENGTH(ARRAY_AGG(v2ProductName))  AS num_products_viewed,
  ARRAY_AGG(pageTitle)                    AS pages_viewed,
  ARRAY_LENGTH(ARRAY_AGG(pageTitle))      AS num_pages_viewed
FROM `data-to-insights.ecommerce.all_sessions`
WHERE visitId = 1501570398
GROUP BY fullVisitorId, date
ORDER BY date
```

Next, lets deduplicate the pages and products so we can see how many unique products were viewed. We'll simply add `DISTINCT` to our `ARRAY_AGG()`

```sql
SELECT
  fullVisitorId,
  date,
  ARRAY_AGG(DISTINCT v2ProductName)               AS products_viewed,
  ARRAY_LENGTH(ARRAY_AGG(DISTINCT v2ProductName)) AS distinct_products_viewed,
  ARRAY_AGG(DISTINCT pageTitle)                   AS pages_viewed,
  ARRAY_LENGTH(ARRAY_AGG(DISTINCT pageTitle))     AS distinct_pages_viewed
FROM `data-to-insights.ecommerce.all_sessions`
WHERE visitId = 1501570398
GROUP BY fullVisitorId, date
ORDER BY date
```
📋 **REACAP**:

You can do some pretty useful things with arrays like:

- finding the number of elements with `ARRAY_LENGTH(<array>)`


- de-duplicating elements with `ARRAY_AGG(DISTINCT <field>)`


- ordering elements with `ARRAY_AGG(<field> ORDER BY <field>)`


- limiting `ARRAY_AGG(<field> LIMIT 5`)

---

### Querying datasets that already have ARRAYs

‼️ The BigQuery Public Dataset for Google Analytics `bigquery-public-data.google_analytics_sample`, 
which already stores field values like products, pages, and transactions natively as ARRAYs.

```sql
SELECT *
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`
WHERE visitId = 1501570398
    
SELECT DISTINCT
visitId,
h.page.pageTitle
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`,
  UNNEST(hits) AS h
WHERE visitId = 1501570398
LIMIT 10
```

- You need to `UNNEST()` arrays to bring the array elements back into rows
- `UNNEST()` always follows the table name in your FROM clause (think of it conceptually like a pre-joined table)


### Introduction to STRUCTs

‼️ The BigQuery Public Dataset for Google Analytics `bigquery-public-data.google_analytics_sample` has many more fields and rows than our course dataset `data-to-insights.ecommerce.all_sessions`. 


    bigquery-public-data.google_analytics_sample

More importantly, it already stores field values like products, pages, and transactions natively as ARRAYs.


- Copy and Paste the below query to explore the available data and see if you can find fields with repeated values (arrays)


    SELECT
      *
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`
    WHERE visitId = 1501570398
    


    SELECT DISTINCT
      visitId,
      h.page.pageTitle
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`,
      UNNEST(hits) AS h
    WHERE visitId = 1501570398
    LIMIT 10


- You need to UNNEST() arrays to bring the array elements back into rows
- UNNEST() always follows the table name in your FROM clause (think of it conceptually like a pre-joined table)


## Introduction to STRUCTs

You may have wondered why the field alias `hit.page.pageTitle` looks like three fields in one separated by periods. 

⬇️ Just as `ARRAY` values give you the flexibility to go deep into the granularity of your fields

➡️ `STRUCT` allows you to go wide in your schema by grouping related fields together. 

The easiest way to think about a `STRUCT` is to consider it conceptually like a separate table that is already pre-joined into your main table.

A `STRUCT` can have:

- one or many fields in it
- the same or different data types for each field
- it's own alias


**Let's explore a dataset with STRUCTs:**

1. Under Resources find the bigquery-public-data dataset (if it's not present already, use this link to pin the dataset)
2. Click open `bigquery-public-data`
3. Find and open `google_analytics_sample`
4. Click the `ga_sessions` table

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1612009309386_image.png)

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1612009459965_image.png)

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1612009598285_image.png)


As you can imagine, there is an incredible amount of website session data stored for a modern 
ecommerce website. 


The main advantage of having 32 STRUCTs in a single table is it allows you to run queries like this one without having to do any JOINs:

```sql
SELECT
  visitId,
  totals.*,
  device.*
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`
WHERE visitId = 1501570398
LIMIT 10
```

Storing your large reporting tables as STRUCTs (pre-joined "tables") and ARRAYs (deep granularity) allows you to:

- ✅  gain significant performance advantages by avoiding 32 table JOINs
    

- ✅  get granular data from `ARRAYs` when you need it but not be punished if you don’t **(BigQuery stores each column individually on disk)**
    

- ✅  **have all the business context in one table as opposed to worrying about JOIN keys** and which tables have the data you need 

-----

### Practice with STRUCTs and ARRAYs

The next dataset will be lap times of runners around the track. Each lap will be called a "split".

```sql
# standardSQL
SELECT STRUCT("Rudisha" as name, 23.4 as split) as runner
```

| Row | runner.name | runner.split |
| --- | ----------- | ------------ |
| 1   | Rudisha     | 23.4         |

What do you notice about the field aliases? 
Since there are fields nested within the struct (name and split are a subset of runner) you end up with a dot notation.

What if the runner has multiple split times for a single race (like time per lap)?

With an array of course! Run the below query to confirm:

```sql
# standardSQL
SELECT STRUCT("Rudisha" as name, [23.4, 26.3, 26.4, 26.1] as splits) AS runner
```


📋 **RECAP**:

- 🈯 Structs are **containers that can have multiple field names and data types nested inside**


- 💡 An `ARRAY` can be one of the field types inside a `STRUCT` (as shown above with the splits field)

Practice ingesting `JSON` data

- Create a new dataset titled racing and a new table titled race_results
- Ingest this Google Cloud Storage `JSON`file:
`gs://data-insights-course/labs/optimizing-for-performance/race_results.json`

```json
    [
        {
            "name": "race",
            "type": "STRING",
            "mode": "NULLABLE"
        },
        {
            "name": "participants",
            "type": "RECORD",
            "mode": "REPEATED",
            "fields": [
                {
                    "name": "name",
                    "type": "STRING",
                    "mode": "NULLABLE"
                },
                {
                    "name": "splits",
                    "type": "FLOAT",
                    "mode": "REPEATED"
                }
            ]
        }
    ]
```


![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611962388803_image.png)

- Which field is the STRUCT? How do you know?
- Which field is the ARRAY?


- The `participants.splits` field is an array of floats inside the parent `participants` STRUCT.
    - It has a REPEATED Mode which indicates an array. 
    - Values of that array are called nested values since they are multiple values inside a single field.

```sql
# standardSQL
SELECT * FROM racing.race_results
```

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1612009905990_image.png)

```sql
# standardSQL
SELECT race, participants.name
FROM racing.race_results
```


![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611962673277_image.png)


![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611962803532_image.png)

```sql
# standardSQL
SELECT 
  race, 
  participants.name
FROM racing.race_results
CROSS JOIN race_results.participants
```

![](https://paper-attachments.dropbox.com/s_E897A5F74CEA15BFA7024CE1BD1C9E4DE80AEB7E569FC88A91D2DEE8BBA89841_1611962885173_image.png)

```sql
# standardSQL
SELECT 
  race, 
  p.name
FROM racing.race_results AS r, r.participants AS p
```



⚠️ If you have more than one race type (800M, 100M, 200M), wouldn't a `CROSS JOIN` just associate every racer name with every possible race like a cartesian product?

✅ **Answer**: No. This is a **correlated cross join** which only unpacks the elements associated with a single row. For a greater discussion, see working with ARRAYs and STRUCTs


- A SQL STRUCT is simply a container of other data fields which can be of different data types. The word struct means data structure. 
- Recall the example from earlier:
    __`STRUCT(`__`"Rudisha" as name, [23.4, 26.3, 26.4, 26.1] as splits`__`)`__`AS runner`


- **STRUCTs** are given an alias (like runner above) and can conceptually be thought of as a table inside of your main table.


- **STRUCTs** (and ARRAYs) must be unpacked before you can operate over their elements. 
    - Wrap an `UNNEST()` around the name of the struct itself 🆚 or the struct field that is an array in order to unpack and flatten it

### Lab Question: STRUCT()

Answer the below questions using the `racing.race_results` table you created previously.

**_How many racers were there in total?_**

```sql
# standardSQL
SELECT COUNT(p.name) AS racer_count
FROM racing.race_results AS r, 
      UNNEST(r.participants) AS p
```


### Lab Question: Unpacking ARRAYs with UNNEST( )

- Write a query that will list the total race time for racers whose names begin with R.
- Order the results with the fastest total time first. 
- Use the `UNNEST()` operator and start with the partially written query below.

```sql
# standardSQL
SELECT
  p.name,
  SUM(split_times) as total_race_time

FROM racing.race_results AS r
  , UNNEST(r.participants) AS p
  , UNNEST(p.splits) AS split_times
    
WHERE p.name LIKE 'R%'
GROUP BY p.name
ORDER BY total_race_time ASC;
```

### Lab Question: Filtering within ARRAY values

You happened to see that the fastest lap time recorded for the 800 M race was 23.2 seconds, 
but you did not see which runner ran that particular lap. 

Create a query that returns that result.
```sql
# standardSQL
SELECT
  p.name,
  split_time
FROM racing.race_results AS r
  , UNNEST(r.participants) AS p
  , UNNEST(p.splits) AS split_time
    
WHERE split_time = 23.2;
```

## References: 
https://cloud.google.com/bigquery/docs/reference/standard-sql/arrays#accessing_array_elements