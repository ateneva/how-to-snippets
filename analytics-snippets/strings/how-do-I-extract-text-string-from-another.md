
# How do I extract part of a string from another?
<!-- TOC -->

- [How do I extract part of a string from another?](#how-do-i-extract-part-of-a-string-from-another)
    - [SQL Server](#sql-server)
    - [PostgreSQL](#postgresql)
    - [MySQL](#mysql)
    - [Bigquery](#bigquery)
    - [Redshift](#redshift)
    - [Python](#python)
    - [Tableau](#tableau)

<!-- /TOC -->

## SQL Server

```sql
SELECT
    ---simple phrase---
    'I LOVE YOU'                    AS phrase,

    LEFT ('I LOVE YOU', 1)          AS left_,
    RIGHT('I LOVE YOU', 3)          AS right_,
    RIGHT(LEFT('I LOVE YOU', 6),4)  AS mid_
    --sql server does not support MID function,

    SUBSTRING('I LOVE YOU', 3,4)    AS substring_fixed,

    --longer, more complex phrase but pattermn obvious

```

## PostgreSQL

```sql
SELECT
    ---simple phrase---
    'I LOVE YOU'                    AS phrase,

    LEFT ('I LOVE YOU', 1)          AS left_,
    RIGHT('I LOVE YOU', 3)          AS right_,
    RIGHT(LEFT('I LOVE YOU', 6),4)  AS mid_,
    --postgresql does not support mid function,

    SUBSTRING('I LOVE YOU', 3,4)    AS substring_fixed,
    SUBSTR('I LOVE YOU', 3,4)       AS substr_fixed

    --longer, more complex phrase but pattermn obvious
```

## MySQL

```sql
SELECT
    ---simple phrase---
    'I LOVE YOU'                    AS phrase,

    LEFT ('I LOVE YOU', 1)          AS left_,
    RIGHT('I LOVE YOU', 3)          AS right_,
    MID('I LOVE YOU', 3, 4)         AS mid_,

    SUBSTRING('I LOVE YOU', 3, 4)   AS substring_fixed,
    SUBSTR('I LOVE YOU.', 3, 4)     AS substr_fixed,

    --longer, more complex phrase but pattern obvious

```

## Bigquery

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
