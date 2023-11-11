# How do I find the difference between two dates?

<!-- TOC -->

- [How do I find the difference between two dates?](#how-do-i-find-the-difference-between-two-dates)
    - [Vertica](#vertica)
    - [SQL Server](#sql-server)
    - [MySQL](#mysql)
    - [PostgreSQL](#postgresql)
    - [BigQuery datetime_expression, datetime_expression, part](#bigquery-datetime_expression-datetime_expression-part)
    - [Redshift](#redshift)
    - [Python](#python)
    - [Tableau](#tableau)

<!-- /TOC -->

## Vertica

```sql
SELECT
    DATEDIFF('YEAR',    '1988-06-21', NOW()) AS years_between_dates,
    DATEDIFF('QUARTER', '1988-06-21', NOW()) AS quarters_between_dates,
    DATEDIFF('MONTH',   '1988-06-21', NOW()) AS months_between_dates,
    DATEDIFF('DAY',     '1988-06-21', NOW()) AS days_between_dates,
    DATEDIFF('HOUR',    '1988-06-21', NOW()) AS hours_between_dates,
    DATEDIFF('MINUTE',  '1988-06-21', NOW()) AS minutes_between_dates,
    DATEDIFF('SECOND',  '1988-06-21', NOW()) AS seconds_between_dates,


    TIMESTAMPDIFF('YEAR',   '2015-08-22', NOW()) AS years_between,
    TIMESTAMPDIFF('MONTH',  '2015-08-22', NOW()) AS months_between,
    TIMESTAMPDIFF('WEEK',   '2015-08-22', NOW()) AS weeks_between,
    TIMESTAMPDIFF('DAY',    '2015-08-22', NOW()) AS days_between,
    TIMESTAMPDIFF('HOUR',   '2015-08-22', NOW()) AS hours_between,
    TIMESTAMPDIFF('MINUTE', '2015-08-22', NOW()) AS minutes_betwee
```

OR

```sql
SELECT

--calculates completed period without current month
AGE_IN_MONTHS(NOW(), '1988-06-21'), 

--calculates completed period without current month
AGE_IN_YEARS(NOW(), '1988-06-21'),                                   

--includes current month in calculation
DATEDIFF('MONTH', '1988-06-21', NOW()) AS months_between_dates, 

--includes current month in calculation
DATEDIFF('YEAR', '1988-06-21', NOW()) AS years_between_dates,          

-- calculates months between two dates as a float
MONTHS_BETWEEN (NOW(),'2017-01-01')                                
```

## SQL Server

```sql
SELECT
    DATEDIFF(YEAR,    '1988-06-21', GETDATE()) AS years_between_dates,
    DATEDIFF(QUARTER, '1988-06-21', GETDATE()) AS quarters_between_dates,
    DATEDIFF(MONTH,   '1988-06-21', GETDATE()) AS months_between_dates,
    DATEDIFF(DAY,     '1988-06-21', GETDATE()) AS days_between_dates,
    DATEDIFF(HOUR,    '1988-06-21', GETDATE()) AS hours_between_dates,
    DATEDIFF(MINUTE,  '1988-06-21', GETDATE()) AS minutes_between_dates,
    DATEDIFF(SECOND,  '1988-06-21', GETDATE()) AS seconds_between_dates
```

## MySQL

```sql
SELECT
    DATEDIFF(NOW(), '1988-06-21')               AS days_between,
    TIMESTAMPDIFF(YEAR,    '1988-06-21', NOW()) AS years_between_dates,
    TIMESTAMPDIFF(QUARTER, '1988-06-21', NOW()) AS quarters_between_dates,
    TIMESTAMPDIFF(MONTH,   '1988-06-21', NOW()) AS months_between_dates,
    TIMESTAMPDIFF(DAY,     '1988-06-21', NOW()) AS days_between_dates,
    TIMESTAMPDIFF(HOUR,    '1988-06-21', NOW()) AS hours_between_dates,
    TIMESTAMPDIFF(MINUTE,  '1988-06-21', NOW()) AS minutes_between_dates,
    TIMESTAMPDIFF(SECOND,  '1988-06-21', NOW()) AS seconds_between_dates
```

OR

```sql
SELECT
--months between now and a past date
PERIOD_DIFF(201712, 201707) AS past,

 --months between now and a future date
PERIOD_DIFF(201806, 201712) AS future    
```

## PostgreSQL

```sql
SELECT
AGE(NOW(), '1988-06-21') AS years_between_dates
```

```text
yearsbetweendates                                      |
-------------------------------------------------------|
29 years 5 mons 19 days 21 hours 0 mins 39.466046 secs |
```

## BigQuery (datetime_expression, datetime_expression, part)

```sql
SELECT
    CURRENT_DATE() AS NOW,
    DATETIME_DIFF(CURRENT_DATE(), 
        CAST('2019-01-21' AS DATE), YEAR )          AS years_between_datetimes,

    DATETIME_DIFF(CURRENT_DATE(), 
        CAST('2019-01-21' AS DATE), QUARTER)        AS quarters_between_datetimes,

    DATETIME_DIFF(CURRENT_DATE(), 
        CAST('2019-01-21' AS DATE), MONTH)          AS months_between_datetimes,

    DATETIME_DIFF(CURRENT_DATE(), 
        CAST('2019-01-21' AS DATE), ISOWEEK)        AS iso_weeks_between_datetimes,

    DATETIME_DIFF(CURRENT_DATE(), 
        CAST('2019-01-21' AS DATE), WEEK)           AS weeks_between_datetimes,

    DATETIME_DIFF(CURRENT_DATE(),
        CAST('2019-01-21' AS DATE), WEEK(FRIDAY))   AS defined_weeks_between_datetimes,

    DATETIME_DIFF(CURRENT_DATE(), 
        CAST('2019-01-21' AS DATE), DAY)            AS days_between_datetimes,

    DATETIME_DIFF(CURRENT_DATE(), 
        CAST('2019-01-21' AS DATE), HOUR)           AS hours_between_datetimes,

    DATETIME_DIFF(CURRENT_DATE(), 
        CAST('2019-01-21' AS DATE), MINUTE)         AS minutes_between_datetimes,

    DATETIME_DIFF(CURRENT_DATE(), 
        CAST('2019-01-21' AS DATE), SECOND)         AS seconds_between_datetimes,


    DATETIME_DIFF(CAST('2019-01-21' AS DATE), 
        CURRENT_DATE(), YEAR )                      AS years_between_datetimes,

    DATETIME_DIFF(CAST('2019-01-21' AS DATE), 
        CURRENT_DATE(), QUARTER)                    AS quarters_between_datetimes,

    DATETIME_DIFF(CAST('2019-01-21' AS DATE), 
        CURRENT_DATE(), MONTH)                      AS months_between_datetimes,

    DATETIME_DIFF(CAST('2019-01-21' AS DATE), 
        CURRENT_DATE(), ISOWEEK)                    AS iso_weeks_between_datetimes,

    DATETIME_DIFF(CAST('2019-01-21' AS DATE), 
        CURRENT_DATE(), WEEK)                       AS weeks_between_datetimes,

    DATETIME_DIFF(CAST('2019-01-21' AS DATE), 
        CURRENT_DATE(), WEEK(FRIDAY))               AS defined_weeks_between_datetimes,

    DATETIME_DIFF(CAST('2019-01-21' AS DATE), 
        CURRENT_DATE(), DAY)                        AS days_between_datetimes,

    DATETIME_DIFF(CAST('2019-01-21' AS DATE), 
        CURRENT_DATE(), HOUR)                       AS hours_between_datetimes,

    DATETIME_DIFF(CAST('2019-01-21' AS DATE), 
        CURRENT_DATE(), MINUTE)                     AS minutess_between_datetimes,

    DATETIME_DIFF(CAST('2019-01-21' AS DATE), 
        CURRENT_DATE(), SECOND)                     AS seconds_between_datetimes
```

```json
[
  {
    "now": "2020-11-08",
    "years_between_datetimes": 1,
    "quarters_between_datetimes": 7,
    "months_between_datetimes": 22,
    "iso_weeks_between_datetimes": 93,
    "weeks_between_datetimes": 94,
    "defined_weeks_between_datetimes": 94,
    "days_between_datetimes": 657,
    "hours_between_datetimes": 15768,
    "minutes_between_datetimes": 946080,
    "seconds_between_datetimes": 56764800,

    "years_between_datetimes_1": -1,
    "quarters_between_datetimes_1": -7,
    "months_between_datetimes_1": -22,
    "iso_weeks_between_datetimes_1": -93,
    "weeks_between_datetimes_1": -94,
    "defined_weeks_between_datetimes_1": -94,
    "days_between_datetimes_1": -657,
    "hours_between_datetimes_1": -15768,
    "minutess_between_datetimes": -946080,
    "seconds_between_datetimes_1": -56764800
  }
]
```

## Redshift

```sql

```

## Python

```python
```

## Tableau

```text
```
