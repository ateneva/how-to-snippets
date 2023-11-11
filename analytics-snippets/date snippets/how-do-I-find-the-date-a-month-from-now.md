
# How do I find the date that is a number of months from/before now with SQL?

## SQL Server

```sql
SELECT
    DATEADD(YEAR,    -1, GETDATE())   AS one_year_ago,
    DATEADD(MONTH,   -1, GETDATE())   AS one_month_ago,
    DATEADD(WEEK,    -1, GETDATE())   AS one_week_ago,
    DATEADD(DAY,     -1, GETDATE())   AS one_day_ago,
    DATEADD(WEEKDAY, -1, GETDATE())   AS one_weekday_ago,
    DATEADD(HOUR,    -1, GETDATE())   AS one_hour_ago
```

```sql
SELECT
    DATEADD(YEAR,     1, GETDATE())   AS one_year_from_now,
    DATEADD(MONTH,    1, GETDATE())   AS month_from_now,
    DATEADD(WEEK,     1, GETDATE())   AS one_week_from_now,
    DATEADD(DAY,      1, GETDATE())   AS one_day_from_now,
    dATEADD(WEEKDAY,  1, GETDATE())   AS one_weekday_from_now,
    DATEADD(HOUR,     1, GETDATE())   AS one_hour_from_now
```

## MySQL

```sql
SELECT
    DATE_SUB(NOW(), INTERVAL 1 YEAR)    AS one_year_ago,
    DATE_SUB(NOW(), INTERVAL 1 MONTH)   AS one_month_ago,
    DATE_SUB(NOW(), INTERVAL 1 WEEK)    AS one_week_ago,
    DATE_SUB(NOW(), INTERVAL 1 DAY)     AS one_day_ago,
    DATE_SUB(NOW(), INTERVAL 1 HOUR)    AS one_hour_ago

 --or

SELECT
    DATE_ADD(NOW(), INTERVAL -1 YEAR)    AS one_year_ago,
    DATE_ADD(NOW(), INTERVAL -1 MONTH)   AS one_month_ago,
    DATE_ADD(NOW(), INTERVAL -1 WEEK)    AS one_week_ago,
    DATE_ADD(NOW(), INTERVAL -1 DAY)     AS one_day_ago,
    DATE_ADD(NOW(), INTERVAL -1 HOUR)    AS one_hour_ago

--or
SELECT
    TIMESTAMPADD(YEAR,  -1, NOW())     AS one_year_ago,
    TIMESTAMPADD(MONTH, -1, NOW())     AS one_month_ago,
    TIMESTAMPADD(WEEK, -1, NOW())      AS one_week_ago,
    TIMESTAMPADD(DAY, -1, NOW())       AS one_day_ago,
    TIMESTAMPADD(HOUR, -1, NOW())      AS one_hour_ago
```

```sql
SELECT
    DATE_ADD(NOW(), INTERVAL 1 YEAR)    AS one_year_from_now,
    DATE_ADD(NOW(), INTERVAL 1 MONTH)   AS month_from_now,
    DATE_ADD(NOW(), INTERVAL 1 WEEK)    AS one_week_from_now,
    DATE_ADD(NOW(), INTERVAL 1 DAY)     AS one_day_from_now,
    DATE_ADD(NOW(), INTERVAL 1 HOUR)    AS one_hour_from_now

--OR

SELECT
    TIMESTAMPADD(YEAR, 1, NOW())        AS one_year_from_now,
    TIMESTAMPADD(MONTH, 1, NOW())       AS month_from_now,
    TIMESTAMPADD(WEEK, 1, NOW())        AS one_week_from_now,
    TIMESTAMPADD(DAY, 1, NOW())         AS one_day_from_now,
    TIMESTAMPADD(HOUR, 1, NOW())        AS one_hour_from_now
```

OR

```sql
SELECT 
    NOW(),
    DATE(ADDDATE(NOW(), 5)) AS 5_days_from_now,    
    TIME(ADDTIME(NOW(), 5)) AS 5_seconds_from_now,

    DATE(SUBDATE(NOW(), 5)) AS 5_days_ago,
    TIME(SUBTIME(NOW(), 5)) AS 5_seconds_ago,


    --fixed input month
    PERIOD_ADD(201801, 3) AS 3_month_from_ym,
    PERIOD_ADD(201801,-3) AS 3_month_ago,

    CONCAT(YEAR(NOW()),  --GET CURRENT YEAR MONTH
        CASE 
            WHEN MONTH(NOW()) < 10 
            THEN CONCAT(0, MONTH(NOW())) 
            ELSE MONTH(NOW()) 
        END) AS this_ym,
        
    --dynamic input month
    PERIOD_ADD(CONCAT(YEAR(NOW()),
                    CASE 
                        WHEN MONTH(NOW()) < 10 
                        THEN CONCAT(0, MONTH(NOW())) 
                        ELSE MONTH(NOW()) 
                    END), 5) AS 5_months_from_now
```

## VERTICA: timestampaddd

```sql
SELECT
    TIMESTAMPADD('YEAR',  -1, NOW())    AS one_year_ago,
    TIMESTAMPADD('MONTH', -1, NOW())    AS one_month_ago,
    TIMESTAMPADD('WEEK', -1, NOW())     AS one_week_ago,
    TIMESTAMPADD('DAY', -1, NOW())      AS one_day_ago,
    TIMESTAMPADD('HOUR', -1, NOW())     AS one_hour_ago,

    TIMESTAMPADD('YEAR', 1, NOW())      AS one_year_from_now,
    TIMESTAMPADD('MONTH', 1, NOW())     AS month_from_now,
    TIMESTAMPADD('WEEK', 1, NOW())      AS one_week_from_now,
    TIMESTAMPADD('DAY', 1, NOW())       AS one_day_from_now,
    TIMESTAMPADD('HOUR', 1, NOW())      AS one_hour_from_now
```

OR

```sql
SELECT 
    NOW(),
    ADD_MONTHS(NOW(), 1) AS 1_month_from_now,
    ADD_MONTHS(NOW(),-1) AS 1_month_ago,

    ADD_MONTHS(NOW(), 5) AS 5_months_from_now,
    ADD_MONTHS(NOW(),-5) AS 5_months_ago,

    ADD_MONTHS(NOW(), 8) AS 8_months_from_now,
    ADD_MONTHS(NOW(),-8) AS 8_months_ago
```

## PostgreSQL

```sql
SELECT
    NOW() - INTERVAL '1 YEAR'    AS one_year_ago,
    NOW() - INTERVAL '1 MONTH'   AS one_month_ago,
    NOW() - INTERVAL '1 WEEK'    AS one_week_ago,
    NOW() - INTERVAL '1 DAY'     AS one_day_ago,
    NOW() - INTERVAL '1 HOUR'    AS one_hour_ago
```

```sql
SELECT
    NOW() + INTERVAL '1 YEAR'    AS one_year_from_now,
    NOW() + INTERVAL '1 MONTH'   AS one_month_from_now,
    NOW() + INTERVAL '1 WEEK'    AS one_week_from_now,
    NOW() + INTERVAL '1 DAY'     AS one_day_from_now,
    NOW() + INTERVAL '1 HOUR'    AS one_hour_from_now
```

## BigQuery

```sql
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
