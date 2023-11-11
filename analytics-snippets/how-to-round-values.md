
# How can I round numbers?

<!-- TOC -->

- [How can I round numbers?](#how-can-i-round-numbers)
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
        CEILING(285.32)     AS ceiling,
        FLOOR(285.82)       AS floor,
        
        285.253             AS number1,
        ROUND(285.253,0)    AS round_less_5_to_0,
        ROUND(285.253,1)    AS round_less_5_to_1,
        ROUND(285.253,2)    AS round_less_5_to_2,
        
        285.753             AS number2,
        ROUND(285.753,0)    AS round_more_5_to_0,
        ROUND(285.753,1)    AS round_more_5_to_1,
        ROUND(285.753,2)    AS round_more_5_to_2
```

## MySQL

```sql
    SELECT
        CEILING(285.32)     AS ceiling,
        FLOOR(285.82)       AS floor,
        
        285.253             AS number1,
        ROUND(285.253,0)    AS round_less_5_to_0,
        ROUND(285.253,1)    AS round_less_5_to_1,
        ROUND(285.253,2)    AS round_less_5_to_2,
        
        285.753             AS number2,
        ROUND(285.753,0)    AS round_more_5_to_0,
        ROUND(285.753,1)    AS round_more_5_to_1,
        ROUND(285.753,2)    AS round_more_5_to_2
```

## PostgreSQL

```sql
    SELECT
        CEILING(285.32)     AS ceiling,
        FLOOR(285.82)       AS floor,
        
        285.253             AS number1,
        ROUND(285.253,0)    AS round_less_5_to_0,
        ROUND(285.253,1)    AS round_less_5_to_1,
        ROUND(285.253,2)    AS round_less_5_to_2,
        
        285.753             AS number2,
        ROUND(285.753,0)    AS round_more_5_to_0,
        ROUND(285.753,1)    AS round_more_5_to_1,
        ROUND(285.753,2)    AS round_more_5_to_2
```

## SQL Server

```sql
    SELECT
        CEILING(285.32)     AS ceiling,
        FLOOR(285.82)       AS floor,
        
        285.253             AS number1,
        ROUND(285.253,0)    AS round_less_5_to_0,
        ROUND(285.253,1)    AS round_less_5_to_1,
        ROUND(285.253,2)    AS round_less_5_to_2,
        
        285.753             AS number2,
        ROUND(285.753,0)    AS round_more_5_to_0,
        ROUND(285.753,1)    AS round_more_5_to_1,
        ROUND(285.753,2)    AS round_more_5_to_2
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
