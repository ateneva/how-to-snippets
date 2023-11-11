
# How do I convert string to a date?

<!-- TOC -->

- [How do I convert string to a date?](#how-do-i-convert-string-to-a-date)
    - [Vertica](#vertica)
    - [PostgreSQL](#postgresql)
    - [MySQL](#mysql)
    - [SQL Server](#sql-server)
    - [BigQuery](#bigquery)
    - [Reshift](#reshift)
    - [Python](#python)
    - [Tableau](#tableau)

<!-- /TOC -->

## Vertica

```sql
    SELECT
    '2017-03-31'                          as TextField,
    TO_DATE('2017-03-31', 'YYYY-MM-DD')   as Datefield
```

## PostgreSQL

```sql
    SELECT
    '2017-03-31'                          as TextField,
    TO_DATE('2017-03-31', 'YYYY-MM-DD')   as Datefield
```

## MySQL

```sql
    SELECT
    '2017-03-31'                          as TextField,
    STR_TO_DATE('2017-03-31', '%Y-%m-%d') as DateField  
```

## SQL Server

```sql
    SELECT
    '2017-03-31'                          as TextField,
    CONVERT(date, '2017-03-31')           as DateField1,
    CAST('2017-03-31' as date)            as DateField2
```

## BigQuery

```sql
    SELECT
    CURRENT_DATE() AS NOW,
    PARSE_DATE("%Y/%m/%d", "2012/12/21") AS THE_DATE,

    FORMAT_DATE("%Y-%b-%d",
            PARSE_DATE("%Y/%m/%d", "2012/12/21")) AS THE_DATE_FORMATTED
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
