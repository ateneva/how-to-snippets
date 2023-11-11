# How do I find the first day of previous/next week?

## SQL Server

```sql
SELECT 
    -----Mon-Sun week-------------------------------------------------
    CONVERT(DATE, GETDATE()) AS TODAY,
    DATEPART(DW, GETDATE()) AS WEEKDAY,

    CASE -------PREVIOUS WEEK--------------------------------------------------------
        WHEN DATEPART(DW, GETDATE()) = 1 THEN CONVERT(DATE, DATEADD(DAY, -13, GETDATE()))
        WHEN DATEPART(DW, GETDATE()) = 2 THEN CONVERT(DATE, DATEADD(DAY, -7, GETDATE()))
        WHEN DATEPART(DW, GETDATE()) = 3 THEN CONVERT(DATE, DATEADD(DAY, -8, GETDATE()))
        WHEN DATEPART(DW, GETDATE()) = 4 THEN CONVERT(DATE, DATEADD(DAY, -9, GETDATE()))
        WHEN DATEPART(DW, GETDATE()) = 5 THEN CONVERT(DATE, DATEADD(DAY, -10, GETDATE()))
        WHEN DATEPART(DW, GETDATE()) = 6 THEN CONVERT(DATE, DATEADD(DAY, -11, GETDATE()))
        WHEN DATEPART(DW, GETDATE()) = 7 THEN CONVERT(DATE, DATEADD(DAY, -12, GETDATE()))
    END AS first_day_of_previous_week,                                                         
                                                         
    CASE ---------------NEXT WEEK--------------------------------------------------------
        WHEN DATEPART(DW, GETDATE()) = 1 THEN CONVERT(DATE, DATEADD(DAY, +1, GETDATE()))
        WHEN DATEPART(DW, GETDATE()) = 2 THEN CONVERT(DATE, DATEADD(DAY, +7, GETDATE()))  
        WHEN DATEPART(DW, GETDATE()) = 3 THEN CONVERT(DATE, DATEADD(DAY, +6, GETDATE()))
        WHEN DATEPART(DW, GETDATE()) = 4 THEN CONVERT(DATE, DATEADD(DAY, +5, GETDATE()))
        WHEN DATEPART(DW, GETDATE()) = 5 THEN CONVERT(DATE, DATEADD(DAY, +4, GETDATE()))
        WHEN DATEPART(DW, GETDATE()) = 6 THEN CONVERT(DATE, DATEADD(DAY, +3, GETDATE()))
        WHEN DATEPART(DW, GETDATE()) = 7 THEN CONVERT(DATE, DATEADD(DAY, +2, GETDATE()))
    END AS first_dayof_next_week,         

    CONVERT(DATE, CONVERT(VARCHAR(7), 
        DATEADD(MONTH, -1, GETDATE()) , 120) + '-01') AS first_dayof_previous_month,
                    
    CONVERT(DATE, CONVERT(VARCHAR(7), 
        DATEADD(MONTH, +1, GETDATE()) , 120) + '-01') AS first_dayof_next_month
```

## MySQL

```sql
SELECT 
    DATE(NOW())  AS TODAY,

    CASE ----------------------PREVIOUS WEEK---------------------------------
        WHEN WEEKDAY(NOW()) = 0 THEN DATE(DATE_ADD(NOW(), INTERVAL -7 DAY))
        WHEN WEEKDAY(NOW()) = 1 THEN DATE(DATE_ADD(NOW(), INTERVAL -8 DAY))
        WHEN WEEKDAY(NOW()) = 2 THEN DATE(DATE_ADD(NOW(), INTERVAL -9 DAY))
        WHEN WEEKDAY(NOW()) = 3 THEN DATE(DATE_ADD(NOW(), INTERVAL -10 DAY))
        WHEN WEEKDAY(NOW()) = 4 THEN DATE(DATE_ADD(NOW(), INTERVAL -11 DAY))
        WHEN WEEKDAY(NOW()) = 5 THEN DATE(DATE_ADD(NOW(), INTERVAL -12 DAY))
        WHEN WEEKDAY(NOW()) = 6 THEN DATE(DATE_ADD(NOW(), INTERVAL -13 DAY))
    END AS first_dayof_previous_week,
                            
    
    CASE ----------------------NEXT WEEK---------------------------------
        WHEN WEEKDAY(NOW()) = 0 THEN DATE(DATE_ADD(NOW(), INTERVAL +7 DAY))
        WHEN WEEKDAY(NOW()) = 1 THEN DATE(DATE_ADD(NOW(), INTERVAL +6 DAY))
        WHEN WEEKDAY(NOW()) = 2 THEN DATE(DATE_ADD(NOW(), INTERVAL +5 DAY))
        WHEN WEEKDAY(NOW()) = 3 THEN DATE(DATE_ADD(NOW(), INTERVAL +4 DAY))
        WHEN WEEKDAY(NOW()) = 4 THEN DATE(DATE_ADD(NOW(), INTERVAL +3 DAY))
        WHEN WEEKDAY(NOW()) = 5 THEN DATE(DATE_ADD(NOW(), INTERVAL +2 DAY))
        WHEN WEEKDAY(NOW()) = 6 THEN DATE(DATE_ADD(NOW(), INTERVAL +1 DAY))
    END AS first_dayof_next_week,
                    
    DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -1 MONTH), '%Y-%M-01')   AS first_day_of_prv_month,                                           
    
    DATE_FORMAT(DATE_ADD(NOW(), INTERVAL +1 MONTH), '%Y-%M-01')   AS first_dayof_next_month
 ```

## PostgreSQL

```sql
SELECT
    DATE(NOW()) AS Today,
    DATE(DATE_TRUNC('WEEK',  NOW() - INTERVAL '7 DAY'))   AS first_day_of_previous_week,
    DATE(DATE_TRUNC('MONTH', NOW() - INTERVAL '1 MONTH')) AS first_day_of_previoust_month,
    DATE(DATE_TRUNC('YEAR',  NOW() - INTERVAL '1 YEAR'))  AS first_day_of_previous_year,

    DATE(DATE_TRUNC('WEEK',  NOW() + INTERVAL '7 DAY'))   AS first_day_of_next_week,
    DATE(DATE_TRUNC('MONTH', NOW() + INTERVAL '1 MONTH')) AS first_day_of_next_month,
    DATE(DATE_TRUNC('YEAR',  NOW() + INTERVAL '1 YEAR'))  AS first_day_of_next_year
```

## Vertica

```sql
SELECT
    DATE(NOW()) AS TODAY,
    DATE(DATE_TRUNC('WEEK',  TIMESTAMPADD('WEEK', -1, NOW())))   AS first_day_of_previous_week,
    DATE(DATE_TRUNC('MONTH', TIMESTAMPADD('MONTH', -1, NOW())))  AS first_day_of_previoust_month,
    DATE(DATE_TRUNC('YEAR',  TIMESTAMPADD('YEAR', -1, NOW())))   AS first_day_of_previous_year,

    DATE(DATE_TRUNC('WEEK',  TIMESTAMPADD('WEEK', +1, NOW())))   AS first_day_of_next_week,
    DATE(DATE_TRUNC('MONTH', TIMESTAMPADD('MONTH', +1, NOW())))  AS first_day_of_next_month,
    DATE(DATE_TRUNC('YEAR',  TIMESTAMPADD('YEAR', +1, NOW())))   AS first_day_of_next_year
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
