
# How can I compare values?

<!-- TOC -->

- [How can I compare values?](#how-can-i-compare-values)
    - [Vertica](#vertica)
    - [MySQL](#mysql)
    - [PostgreSQL](#postgresql)
    - [SQL Server](#sql-server)
    - [BigQuery](#bigquery)
    - [Reshift](#reshift)
    - [Python](#python)
    - [Tableau](#tableau)

<!-- /TOC -->

## Vertica

```sql
    SELECT
        GREATEST(5.5, 8.2, -8.2)  AS highest_value,
        LEAST(5.5, 8.2, -8.2)     AS lowest_value
```

## MySQL

```sql
    SELECT
        GREATEST(5.5, 8.2, -8.2)  AS highest_value, 
        LEAST(5.5, 8.2, -8.2)     AS lowest_value
```

## PostgreSQL

```sql
    SELECT
        GREATEST(5.5, 8.2, -8.2)  AS highest_value, 
        LEAST(5.5, 8.2, -8.2)     AS lowest_value
```

## SQL Server

```sql
    SELECT
        MAX(MyValue)              AS highest_value,
        MIN(MyValue)              AS lowest_value
        FROM (values (5.5), (8.2), (-8.2)) AS a(MyValue)
```

## BigQuery

```sql
```

## Reshift

```sql
```

## Python

```python
```

## Tableau

```text
```
