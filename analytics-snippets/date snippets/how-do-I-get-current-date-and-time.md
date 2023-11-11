# How do I get current time?

<!-- TOC -->

- [How do I get current time?](#how-do-i-get-current-time)
    - [VERTICA](#vertica)
    - [MySQL](#mysql)
    - [MS SQL Server](#ms-sql-server)
    - [PostgreSQL](#postgresql)
    - [BigQueryy](#bigqueryy)
    - [Redshift](#redshift)
    - [Python](#python)
    - [Tableau](#tableau)

<!-- /TOC -->

## VERTICA

```sql
SELECT 
    CURRENT_TIMESTAMP          AS CurrentTimestamp,
    CURRENT_DATE               AS CurrentDate,
    CURRENT_TIME               AS CurrentTime,
    GETUTCDATE()               AS UTCDateAndTime,
    getdate()
    NOW()                      AS MyTimeRightNow,
    DATE(NOW())                AS Today,
    TIME(NOW())                AS MyTime
```

## MySQL

```sql
SELECT
    UTC_TIMESTAMP              AS UTCDateAndTime,
    UTC_DATE                   AS UTCDate,
    UTC_TIME                   AS UTCTime,
    CURRENT_TIMESTAMP          AS MyLocalDateAndTime,
    CURRENT_DATE               AS Today,
    CURRENT_TIME               AS MyTimeNow,
    NOW()                      AS MyTimeRightNow,
    DATE(NOW())                AS Today,
    TIME(NOW())                AS MyTime
```

## MS SQL Server

```sql
SELECT
    GETUTCDATE()               AS UTCDATEANDTIME,
    GETDATE()                  AS LOCALSERVERDATEANDTIME,
    CURRENT_TIMESTAMP          AS TODAYDATEANDTIME,
    CONVERT(DATE,GETDATE())    AS TODAY, 
    CONVERT(TIME,GETDATE())    AS NOW 
```

## PostgreSQL

```sql
SELECT 
    CURRENT_TIMESTAMP          AS CurrentTimestamp,
    CURRENT_DATE               AS CurrentDate,
    CURRENT_TIME               AS CurrentTime,
    NOW()                      AS MyTimeRightNow
```

## BigQueryy

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
