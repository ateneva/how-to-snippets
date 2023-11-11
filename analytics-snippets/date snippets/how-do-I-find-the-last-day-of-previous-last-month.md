# How do I find the last day of the previous/next month?

## SQL Server

```sql
SELECT
    CONVERT(DATE,GETDATE()) AS today,
    EOMONTH(GETDATE(),-1)   AS last_day_previous_month,
    EOMONTH(GETDATE(),+0)   AS last_day_this_month,
    EOMONTH(GETDATE(),+1)   AS last_day_next_month
```

## Vertica

```sql
SELECT
    NOW()                          AS today
    LAST_DAY(NOW())                AS LastDayofCurrentMonth,
    LAST_DAY(ADD_MONTHS(NOW(),-1)) AS LastDayofPreviousMonth,
    LAST_DAY(ADD_MONTHS(NOW(), 1)) AS LastDayofNextMonth
```

## MySQL

```sql
SELECT
    DATE(NOW())                   AS today,
    LAST_DAY(ADDDATE(NOW(), -31)) AS last_day_previous_month,
    LAST_DAY(NOW())               AS last_day_this_month,
    LAST_DAY(ADDDATE(NOW(), +31)) AS last_day_next_month
```

## PostgreSQL

```sql
SELECT
    DATE(NOW()) AS Today,

    DATE(DATE_TRUNC('MONTH', NOW() 
        + INTERVAL '0 MONTH') - INTERVAL '1 DAY')  AS last_day_previous_month,

    DATE(DATE_TRUNC('MONTH', NOW() 
        + INTERVAL '1 MONTH') - INTERVAL '1 DAY')  AS last_day_this_month,

    DATE(DATE_TRUNC('MONTH', NOW() 
        + INTERVAL '2 MONTH') - INTERVAL '1 DAY')  AS last_day_next_month
```

## BigQuery

```sql
SELECT
    CURRENT_DATE() AS NOW,
    LAST_DAY(CURRENT_DATE(), WEEK)            AS last_day_of_current_week,
    LAST_DAY(CURRENT_DATE(), WEEK(FRIDAY))    AS last_day_of_current_defined_week,
    LAST_DAY(CURRENT_DATE(), ISOWEEK)         AS last_day_of_current_iso_week,
    LAST_DAY(CURRENT_DATE(), MONTH)           AS last_dayof_current_month,
    LAST_DAY(CURRENT_DATE(), QUARTER)         AS last_dayof_current_quarter,
    LAST_DAY(CURRENT_DATE(), YEAR)            AS last_day_of_current_year,
    LAST_DAY(CURRENT_DATE(), ISOYEAR)         AS last_day_of_current_iso_year
```

```json
[
  {
    "now": "2020-11-08",
    "last_day_of_current_week": "2020-11-14",
    "last_day_of_current_defined_week": "2020-11-12",
    "last_day_of_current_iso_week": "2020-11-08",
    "last_day_of_current_month": "2020-11-30",
    "last_day_of_current_quarter": "2020-12-31",
    "last_day_of_current_year": "2020-12-31",
    "last_day_of_current_iso_year": "2021-01-03"
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
