# How do I find the next Monday/Tuesday/etc?

<!-- TOC -->

- [How do I find the next Monday/Tuesday/etc?](#how-do-i-find-the-next-mondaytuesdayetc)
    - [Vertica](#vertica)
    - [SQL Server](#sql-server)
    - [MySQL](#mysql)
    - [PostgreSQL](#postgresql)
    - [BigQuery](#bigquery)
    - [Redshift](#redshift)
    - [Python](#python)
    - [Tableau](#tableau)

<!-- /TOC -->

## Vertica

```sql
SELECT
    NOW()                          AS today,
    NEXT_DAY(NOW(), 'MONDAY')      AS next_monday,
    NEXT_DAY(NOW(), 'TUESDAY')     AS next_tuesday,
    NEXT_DAY(NOW(), 'WEDNESDAY')   AS next_wednesday,
    NEXT_DAY(NOW(), 'THURSDAY')    AS next_thursday,
    NEXT_DAY(NOW(), 'FRIDAY')      AS next_friday,
    NEXT_DAY(NOW(), 'SATURDAY')    AS next_saturday,
    NEXT_DAY(NOW(), 'SUNDAY')      AS next_sunday
```

## SQL Server

```sql
SELECT 
    CONVERT(DATE,GETDATE()) AS today,

    -- 1=Sunday, 2=Monday, 3=Tuesday, 4=Wednesday, 5=Thursday, 6=Friday, 7=Sturday

    CONVERT(DATE, DATEADD(DAY, 2, GETDATE() - DATEPART(DW, GETDATE())
            + CASE WHEN DATEPART(DW, GETDATE()) < 2 THEN 0 ELSE 7 END )) AS next_monday,
            
    CONVERT(DATE, DATEADD(DAY, 3, GETDATE() - DATEPART(DW, GETDATE())
            + CASE WHEN DATEPART(DW, GETDATE()) < 3 THEN 0 ELSE 7 END )) AS next_tuesday,
            
    CONVERT(DATE, DATEADD(DAY, 4, GETDATE() - DATEPART(DW, GETDATE())
            + CASE WHEN DATEPART(DW, GETDATE()) < 4 THEN 0 ELSE 7 END )) AS next_wednesday,
            
    CONVERT(DATE, DATEADD(DAY, 5, GETDATE() - DATEPART(DW, GETDATE())
            + CASE WHEN DATEPART(DW, GETDATE()) < 5 THEN 0 ELSE 7 END )) AS next_thursday,
            
    CONVERT(DATE, DATEADD(DAY, 6, GETDATE() - DATEPART(DW, GETDATE())
            + CASE WHEN DATEPART(DW, GETDATE()) < 6 THEN 0 ELSE 7 END )) AS next_friday,
            
    CONVERT(DATE, DATEADD(DAY, 7, GETDATE() - DATEPART(DW, GETDATE())
            + CASE WHEN DATEPART(DW, GETDATE()) < 7 THEN 0 ELSE 7 END )) AS next_saturday,
            
    CONVERT(DATE, DATEADD(DAY, 1, GETDATE() - DATEPART(DW, GETDATE())
            + CASE WHEN DATEPART(DW, GETDATE()) < 1 THEN 0 ELSE 7 END )) AS next_sunday
 
```

## MySQL

```sql
SELECT 
    DATE(NOW()) AS today,

    -- 1=Sunday, 2=Monday, 3=Tuesday, 4=Wednesday, 5=Thursday, 6=Friday, 7=Sturday

    DATE(ADDDATE(NOW(), 2 - DAYOFWEEK(NOW())
            + CASE WHEN DAYOFWEEK(NOW()) < 2 THEN 0 ELSE 7 END )) AS next_monday,

    DATE(ADDDATE(NOW(), 3 - DAYOFWEEK(NOW())
            + CASE WHEN DAYOFWEEK(NOW()) < 3 THEN 0 ELSE 7 END )) AS next_tuesday,

    DATE(ADDDATE(NOW(), 4 - DAYOFWEEK(NOW())
            + CASE WHEN DAYOFWEEK(NOW()) < 4 THEN 0 ELSE 7 END )) AS next_wednesday,

    DATE(ADDDATE(NOW(), 5 - DAYOFWEEK(NOW())
            + CASE WHEN DAYOFWEEK(NOW()) < 5 THEN 0 ELSE 7 END )) AS next_thursday,

    DATE(ADDDATE(NOW(), 6 - DAYOFWEEK(NOW())
            + CASE WHEN DAYOFWEEK(NOW()) < 6 THEN 0 ELSE 7 END )) AS next_friday,
            
    DATE(ADDDATE(NOW(), 7 - DAYOFWEEK(NOW())
            + CASE WHEN DAYOFWEEK(NOW()) < 7 THEN 0 ELSE 7 END )) AS next_saturday,
            
    DATE(ADDDATE(NOW(), 1 - DAYOFWEEK(NOW())
            + CASE WHEN DAYOFWEEK(NOW()) < 1 THEN 0 ELSE 7 END )) AS next_sunday
```

## PostgreSQL

```sql
SELECT
-- 1=Monday, 2=Tuesday, 3=Wednesday, 4=Thursday, 5=Friday, 6=Saturday, 7=Sunday
---------------------------------------------------------------------------------------------------------------
-- timestamp + cast((num_of_days || ' day') as interval) 
---OR  
-- timestamp + "interval" (num_of_days || ' days')
----------------------------------------------------------------------------------------------------------------
    DATE(NOW()) AS today,

    DATE(NOW() + CAST((1 - EXTRACT(DOW FROM NOW()))
            + (CASE 
                WHEN EXTRACT(DOW FROM NOW()) < 1 
                THEN 0 
                ELSE 7 
                END) || ' DAY' AS INTERVAL)) AS next_monday,

    DATE(NOW() + CAST((2 - EXTRACT(DOW FROM NOW()))
            + (CASE 
                WHEN EXTRACT(DOW FROM NOW()) < 2 
                THEN 0 
                ELSE 7 
                END) || ' DAY' AS INTERVAL)) AS next_tuesday, 
            
    DATE(NOW() + CAST((3 - EXTRACT(DOW FROM NOW()))
            + (CASE 
                WHEN EXTRACT(DOW FROM NOW()) < 3 
                THEN 0 
                ELSE 7 
                END) || ' DAY' AS INTERVAL)) AS next_wednesday,
            
    DATE(NOW() + CAST((4 - EXTRACT(DOW FROM NOW()))
            + (CASE 
                WHEN EXTRACT(DOW FROM NOW()) < 4 
                THEN 0 
                ELSE 7 
                END) || ' DAY' AS INTERVAL)) AS next_thursday,
            
    DATE(NOW() + CAST((5 - EXTRACT(DOW FROM NOW()))
            + (CASE 
                WHEN EXTRACT(DOW FROM NOW()) < 5 
                THEN 0 
                ELSE 7 
                END) || ' DAY' AS INTERVAL)) AS next_friday,
            
    DATE(NOW() + CAST((6 - EXTRACT(DOW FROM NOW()))
            + (CASE 
                WHEN EXTRACT(DOW FROM NOW()) < 6 
                THEN 0 
                ELSE 7 
                END) || ' DAY' AS INTERVAL)) AS next_saturday,
            
    DATE(NOW() + CAST((7 - EXTRACT(DOW FROM NOW()))
            + (CASE 
                WHEN EXTRACT(DOW FROM NOW()) < 7 
                THEN 0 
                ELSE 7 
                END) || ' DAY' AS INTERVAL)) AS next_sunday    
```

--------------------------------------OR-----------------------------------------------

```sql
SELECT
-- 1=Monday, 2=Tuesday, 3=Wednesday, 4=Thursday, 5=Friday, 6=Saturday, 7=Sunday
---------------------------------------------------------------------------------------------------------------
-- timestamp + cast((num_of_days || ' day') as interval) 
---OR  
-- timestamp + "interval" (num_of_days || ' days')
----------------------------------------------------------------------------------------------------------------

    DATE(NOW()) AS today,

    DATE(NOW() + "INTERVAL" ((1 - EXTRACT(DOW FROM NOW()))
            + (CASE 
                WHEN EXTRACT(DOW FROM NOW()) < 1 
                THEN 0 
                ELSE 7 END) || ' DAY')) AS next_monday,

    DATE(NOW() + "INTERVAL" ((2 - EXTRACT(DOW FROM NOW()))
            + (CASE 
                WHEN EXTRACT(DOW FROM NOW()) < 2 
                THEN 0 
                ELSE 7 
                END) || ' DAY')) AS next_tuesday, 
            
    DATE(NOW() + "INTERVAL" ((3 - EXTRACT(DOW FROM NOW()))
            + (CASE 
                WHEN EXTRACT(DOW FROM NOW()) < 3 
                THEN 0 
                ELSE 7 
                END) || ' DAY')) AS next_wednesday,
            
    DATE(NOW() + "INTERVAL" ((4 - EXTRACT(DOW FROM NOW()))
            + (CASE 
                WHEN EXTRACT(DOW FROM NOW()) < 4 
                THEN 0 
                ELSE 7 
                END) || ' DAY')) AS next_thursday,
            
    DATE(NOW() + "INTERVAL" ((5 - EXTRACT(DOW FROM NOW()))
            + (CASE 
                WHEN EXTRACT(DOW FROM NOW()) < 5 
                THEN 0 
                ELSE 7 
                END) || ' DAY')) AS next_friday,
            
    DATE(NOW() + "INTERVAL" ((6 - EXTRACT(DOW FROM NOW()))
            + (CASE 
                WHEN EXTRACT(DOW FROM NOW()) < 6 
                THEN 0 
                ELSE 7 
                END) || ' DAY')) AS next_saturday,
            
    DATE(NOW() + "INTERVAL" ((7 - EXTRACT(DOW FROM NOW()))
            + (CASE 
                WHEN EXTRACT(DOW FROM NOW()) < 7 
                THEN 0 
                ELSE 7 
                END) || ' DAY')) AS next_sunday 

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
