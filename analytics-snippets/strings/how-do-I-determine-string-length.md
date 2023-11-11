
# How do I determine string length?
<!-- TOC -->

- [How do I determine string length?](#how-do-i-determine-string-length)
    - [SQL Server](#sql-server)
    - [MySQL](#mysql)
    - [PostgreSQL](#postgresql)
    - [BigQuery](#bigquery)
    - [Redshift](#redshift)
    - [Python](#python)
    - [Tableau](#tableau)

<!-- /TOC -->

## SQL Server

```sql
SELECT
    'I LOVE YOU'                AS phrase,
    LEN('I LOVE YOU')           AS phrase_length,
    LEN(' I LOVE YOU ')         AS phrase_length2,
    DATALENGTH(' I LOVE YOU ')  AS phrase_length3

--unlike len, datalength counts all leading and trailing spaces
```

## MySQL

```sql
SELECT
    'I LOVE YOU'            AS phrase,
    LENGTH('I LOVE YOU')    AS phrase_length
```

## PostgreSQL

```sql
SELECT
    'I LOVE YOU'            AS phrase,
    LENGTH('I LOVE YOU')    AS phrase_length
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
