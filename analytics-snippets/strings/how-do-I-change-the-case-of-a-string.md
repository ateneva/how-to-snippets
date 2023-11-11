
# How do I change the case of a string?
<!-- TOC -->

- [How do I change the case of a string?](#how-do-i-change-the-case-of-a-string)
    - [Sample String](#sample-string)
        - [SQL Server](#sql-server)
        - [MySQL](#mysql)
        - [PostgreSQL](#postgresql)
        - [Bigquery](#bigquery)
        - [Redshift](#redshift)
        - [Python](#python)
        - [Tableau](#tableau)

<!-- /TOC -->

## Sample String

```json
[
    {
        "title": "Academy Dinosaur"
    },
    {
        "title": "Agent Truman"
    },
    {
        "title": "When Harry met Sally"
    }
]
```

## SQL Server

```sql
SELECT
    TITLE,
    LOWER(TITLE) AS lowercase_string,
    UPPER(TITLE) AS uppercase_string
    ---add proper case
FROM datageeking.dbo.films
```

## MySQL

```sql
SELECT
    TITLE,
    LOWER(TITLE) AS lowercase_string,
    UPPER(TITLE) AS uppercase_string,

    LCASE(TITLE) AS lowercase_string,
    UCASE(TITLE) AS uppercase_string
    --add proper case
FROM sakila.film
```

## PostgreSQL

```sql
SELECT
    TITLE,
    LOWER(TITLE) AS lowercase_string,
    UPPER(TITLE) AS uppercase_string
    --add proper case
FROM public.film
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
