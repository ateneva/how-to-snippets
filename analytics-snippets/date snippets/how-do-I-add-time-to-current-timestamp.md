# How do I add hours to the current tumestamp?

<!-- TOC -->

- [How do I add hours to the current tumestamp?](#how-do-i-add-hours-to-the-current-tumestamp)
    - [VERTICA](#vertica)
    - [SQL Server](#sql-server)
    - [MySQL](#mysql)
    - [PostgreSQL](#postgresql)
    - [BigQuery](#bigquery)
    - [Redshift](#redshift)
    - [Python](#python)
    - [Tableau](#tableau)

<!-- /TOC -->

## VERTICA

```sql
SELECT
    GETDATE() AS SERVERTIME,
    TIMESTAMPADD('HOUR', -1, GETDATE())  AS one_hour_ago,
    TIMESTAMPADD('HOUR', -3, GETDATE())  AS three_hours_ago,
    TIMESTAMPADD('HOUR', 5,  GETDATE())  AS five_hours_from_now,
    TIMESTAMPADD('HOUR', 6,  GETDATE())  AS six_hours_from_now,
    TIMESTAMPADD('HOUR', 7,  GETDATE())  AS seven_hours_from_now
```

## SQL Server

```sql
SELECT
    DATEADD(HOUR, -1, GETDATE())         AS one_hour_ago,
    DATEADD(HOUR, -3, GETDATE())         AS three_hours_ago,
    DATEADD(HOUR, 5, GETDATE())          AS five_hours_from_now,
    DATEADD(HOUR, 6, GETDATE())          AS six_hours_from_now,
    DATEADD(HOUR, 7, GETDATE())          AS seven_hours_from_now
```

## MySQL

```sql
SELECT
    DATE_ADD(NOW(), INTERVAL -1 HOUR)    AS one_hour_ago,
    DATE_ADD(NOW(), INTERVAL -3 HOUR)    AS three_hours_ago,
    DATE_ADD(NOW(), INTERVAL 5 HOUR)     AS five_hours_from_now,
    DATE_ADD(NOW(), INTERVAL 6 HOUR)     AS six_hours_from_now,
    DATE_ADD(NOW(), INTERVAL 7 HOUR)     AS seven_hours_from_now
```

## PostgreSQL

```sql
SELECT
    NOW() - INTERVAL '1 HOUR'            AS one_hour_ago,
    NOW() - INTERVAL '3 HOUR'            AS three_hours_ago,
    NOW() + INTERVAL '5 HOUR'            AS five_hours_from_now,
    NOW() + INTERVAL '6 HOUR'            AS six_hours_from_now,
    NOW() + INTERVAL '7 HOUR'            AS seven_hours_from_now
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
