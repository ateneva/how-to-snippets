# How do I extract part of a date?

<!-- TOC -->

- [How do I extract part of a date?](#how-do-i-extract-part-of-a-date)
    - [Vertica](#vertica)
    - [MS SQL Server](#ms-sql-server)
    - [MySQL](#mysql)
    - [PostgreSQL: DATE_PART](#postgresql-date_part)
    - [PostgreSQL: EXTRACT](#postgresql-extract)
    - [BigQuery: EXTRACT](#bigquery-extract)
    - [Redshift](#redshift)
    - [Python](#python)
    - [Tableau](#tableau)

<!-- /TOC -->

## Vertica

```sql
SELECT
    CURRENT_DATE()                      AS today,
    CURRENT_TIME                        AS time_now,
    CURRENT_TIMESTAMP                   AS today_date_and_time,
    NOW(),
    DATE_PART('CENTURY', NOW())         AS century,
    DATE_PART('DECADE', NOW())          AS decade,
    DATE_PART('DOY', NOW())             AS day_of_year,
    DATE_PART('DOQ', NOW())             AS day_of_quarter,

    ----FIND DAY OF CURRENT WEEK (0 TO 6)
    DATE_PART('DOW', NOW())             AS day_of_week,
    DATE_PART('ISOYEAR', NOW())         AS iso_year,
    DATE_PART('ISOWEEK', NOW())         AS iso_week,

    ----FIND DAY OF CURRENT WEEK (1 TO 7)
    DATE_PART('ISODOW', NOW())          AS day_of_isoweek,            
    DATE_PART('YEAR', NOW())            AS current_year,
    DATE_PART('QUARTER', NOW())         AS current_quarter,
    DATE_PART('MONTH', NOW())           AS current_month,
    DATE_PART('DAY', NOW())             AS current_day,
    DATE_PART('HOUR', NOW())            AS current_hour
```

OR

```sql
SELECT
    NOW(),                                 
    DATE(NOW())                         AS today,
    YEAR(NOW())                         AS this_year,
    QUARTER(NOW())                      AS this_quarter,
    MONTH(NOW())                        AS this_month,
    DAY(NOW())                          AS this_day,

    DAYOFYEAR(NOW())                    AS day_of_year,
    DAYOFWEEK(NOW())                    AS weekday_us,         
    DAYOFWEEK_ISO(NOW())                AS weekday_eu,     

    WEEK(NOW())                         AS weeknum_us,          
    WEEK_ISO(NOW())                     AS weeknum_eu
```

## MS SQL Server

```sql
SELECT
    CURRENT_TIMESTAMP                   AS today_date_and_time,
    DATEPART(yyyy, CURRENT_TIMESTAMP)   AS current_year,
    DATEPART(qq, CURRENT_TIMESTAMP)     AS current_quarter,
    DATEPART(mm, CURRENT_TIMESTAMP)     AS current_month,

    ---FIND CURRENT WEEK NUMBER (COUNT AS OF 1ST JANUARY),
    DATEPART(wk, CURRENT_TIMESTAMP)     AS week,

    ----FIND CURRENT WEEK NUMBER (COUNT AS OF 1ST FULL WEEK)
    DATEPART(isowk, CURRENT_TIMESTAMP)  AS iso_week,                 

    DATEPART(dd, CURRENT_TIMESTAMP)     AS current_day,
    DATEPART(dy, CURRENT_TIMESTAMP)     AS day_of_year,

    ----FIND DAY OF CURRENT WEEK (SUN-SAT)
    DATEPART(dw, CURRENT_TIMESTAMP)     AS day_of_week,                
    DATEPART(hh, CURRENT_TIMESTAMP)     AS hour
```

OR

```sql
SELECT
    GETDATE()              AS now,
    YEAR(GETDATE())        AS this_year,
    MONTH(GETDATE())       AS this_month,
    DAY(GETDATE())         AS today
```

## MySQL

```sql
SELECT
    CURRENT_TIMESTAMP                        AS my_local_date_and_time,
    EXTRACT(YEAR FROM CURRENT_TIMESTAMP)     AS current_year,
    EXTRACT(QUARTER FROM CURRENT_TIMESTAMP)  AS current_quarter,
    EXTRACT(WEEK FROM CURRENT_TIMESTAMP)     AS current_week,
    EXTRACT(DAY FROM CURRENT_TIMESTAMP)      AS current_day,
    EXTRACT(HOUR FROM CURRENT_TIMESTAMP)     AS current_hour
```

OR

```sql
SELECT
    NOW(),
    DATE(NOW())          AS today,
    YEAR(NOW())          AS this_year,
    QUARTER(NOW())       AS this_quarter,
    MONTH(NOW())         AS this_month,
    DAY(NOW())           AS this_day,

    DAYOFYEAR(NOW())     AS day_of_year,
    DAYOFMONTH(NOW())    AS day_of_month,

    --1 = SUNDAY, 2 = MONDAY, …, 7 = SATURDAY)
    DAYOFWEEK(NOW())     AS day_of_week,

    --0 = MONDAY, 1 = TUESDAY, … 6 = SUNDAY
    WEEKDAY(NOW())       AS weekday_num,

    WEEKOFYEAR(NOW())    AS weeknum_us,
    WEEK(NOW())          AS weeknum_us
```

## PostgreSQL: DATE_PART

```sql
SELECT
    CURRENT_TIMESTAMP,
    DATE_PART('CENTURY', CURRENT_TIMESTAMP)         AS century,
    DATE_PART('DECADE', CURRENT_TIMESTAMP)          AS decade,
    DATE_PART('DOY', CURRENT_TIMESTAMP)             AS day_of_year,
    DATE_PART('DOW', CURRENT_TIMESTAMP)             AS day_of_week,
    DATE_PART('ISOYEAR', CURRENT_TIMESTAMP)         AS iso_year,
    DATE_PART('YEAR', CURRENT_TIMESTAMP)            AS current_year,
    DATE_PART('QUARTER', CURRENT_TIMESTAMP)         AS current_quarter,
    DATE_PART('MONTH', CURRENT_TIMESTAMP)           AS current_month,
    DATE_PART('DAY', CURRENT_TIMESTAMP)             AS current_day,
    DATE_PART('HOUR', CURRENT_TIMESTAMP)            AS current_hour
```

## PostgreSQL: EXTRACT

```sql
SELECT
    CURRENT_TIMESTAMP,
    EXTRACT(century FROM CURRENT_TIMESTAMP)         AS century,
    EXTRACT(decade FROM CURRENT_TIMESTAMP)          AS decade,
    EXTRACT(doy FROM CURRENT_TIMESTAMP)             AS day_of_year,

    ----find day of current week (0 to 6)
    EXTRACT(dow FROM CURRENT_TIMESTAMP)             AS day_of_week,
    EXTRACT(isoyear FROM CURRENT_TIMESTAMP)         AS iso_year,
    EXTRACT(year FROM CURRENT_TIMESTAMP)            AS current_year,
    EXTRACT(quarter FROM CURRENT_TIMESTAMP)         AS current_quarter,
    EXTRACT(month FROM CURRENT_TIMESTAMP)           AS current_month,
    EXTRACT(day FROM CURRENT_TIMESTAMP)             AS current_day,
    EXTRACT(hour FROM CURRENT_TIMESTAMP)            AS current_hour
```

## BigQuery: EXTRACT

```sql
SELECT ---- also supports MILISECOND, MICROSECOND
    CURRENT_DATETIME() AS NOW,
    EXTRACT(YEAR FROM CURRENT_DATETIME())           AS current_year,
    EXTRACT(QUARTER FROM CURRENT_DATETIME())        AS current_quarter,
    EXTRACT(MONTH FROM CURRENT_DATETIME())          AS current_month,

    --starts by default on Sunday, but argument can be passed
    EXTRACT(WEEK FROM CURRENT_DATETIME())           AS current_week,
    
    --starts on Monday
    EXTRACT(ISOWEEK FROM CURRENT_DATETIME())        AS current_iso_week,

    EXTRACT(DAY FROM CURRENT_DATETIME())            AS current_day,
    EXTRACT(DAYOFYEAR FROM CURRENT_DATETIME())      AS current_day_of_year,
    EXTRACT(DAYOFWEEK FROM CURRENT_DATETIME())      AS current_day_of_week,
    EXTRACT(HOUR FROM CURRENT_DATETIME())           AS current_hour,
    EXTRACT(MINUTE FROM CURRENT_DATETIME())         AS current_minute,
    EXTRACT(SECOND FROM CURRENT_DATETIME())         AS current_second
```

```json
[
  {
    "now": "2020-11-08",
    "current_year": 2020,
    "current_quarter": 4,
    "current_month": 11,
    "current_week": 45,
    "current_iso_week": 45,
    "current_day": 8,
    "current_day_of_year": 313,
    "current_day_of_week": 1,
    "current_hour": 8,
    "current_minute": 31,
    "current_second": 14
  }
]
```

OR

```sql
SELECT
    CURRENT_DATE() AS NOW,
    EXTRACT(YEAR FROM CURRENT_DATE())        AS current_year,
    EXTRACT(QUARTER FROM CURRENT_DATE())     AS current_quarter,
    EXTRACT(MONTH FROM CURRENT_DATE())       AS current_month,

    --starts by default on Sunday, but argument can be passed
    EXTRACT(WEEK FROM CURRENT_DATE())        AS current_week,

    --starts on Monday     
    EXTRACT(ISOWEEK FROM CURRENT_DATE())     AS current_iso_week, 

    EXTRACT(DAY FROM CURRENT_DATE())         AS current_day,
    EXTRACT(DAYOFYEAR FROM CURRENT_DATE())   AS current_day_of_year,
    EXTRACT(DAYOFWEEK FROM CURRENT_DATE())   AS current_day_of_week
```

```json
[
  {
    "NOW": "2020-11-08",
    "CurrentYear": 2020,
    "CurrentQuarter": 4,
    "CurrentMonth": 11,
    "CurrentWeek": 45,
    "CurrentIsoWeek": 45,
    "CurrentDay": 8,
    "CurrentDayOfYear": 313,
    "CurrentDayOfWeek": 1
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
