
# How do I concatenate strings?
<!-- TOC -->

- [How do I concatenate strings?](#how-do-i-concatenate-strings)
    - [MySQL](#mysql)
    - [SQL Server](#sql-server)
    - [PostgreSQL](#postgresql)
    - [Vertica](#vertica)
    - [BigQuery](#bigquery)
    - [Redshift](#redshift)
    - [Python](#python)
    - [Tableau](#tableau)

<!-- /TOC -->

## MySQL

```sql
SELECT
    CONCAT('2017','-FEB')               AS two_strings,
    CONCAT('2017','-','FEB')            AS multiple_strings
```

## SQL Server

```sql
SELECT
    CONCAT('2017','-FEB')                AS two_strings,
    Concat('2017','-','Feb')             as multiple_strings
```

## PostgreSQL

```sql
SELECT
    '2017' || '-FEB'                     AS two_strings,
    '2017' || '-' || 'FEB'               AS multiple_strings
```

## Vertica

```sql
SELECT
    --concat in vertica is only applicable to two strings
    CONCAT('2017','-FEB')                 AS two_strings
    CONCAT('2017',CONCAT('-', 'FEB'))     AS multiple_strings
    '2017' || '-' || 'FEB'                AS multiple_strings
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
