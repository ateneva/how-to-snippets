
# How do I remove extra spaces from a string?

## Vertica

```sql
SELECT
    REPLACE('WE LOVE YOU', 'WE', 'I'), 
                    '     I LOVE YOU   ' AS my_phrase,
    LTRIM('     I LOVE YOU   ')          AS before_ltrim,      
    RTRIM('     I LOVE YOU   ')          AS before_rtrim,      
    TRIM('  I LOVE YOU ')                AS before_trim             
```

## MySQL

```sql
SELECT
    REPLACE('I LOVE YOU', 'I', 'WE')     AS replace_,
    LENGTH('I LOVE YOU ')                AS before_rtrim,
    RTRIM('I LOVE YOU ')                 AS rtrim_,
    LENGTH(RTRIM('I LOVE YOU '))         AS after_rtrim,

    LENGTH(' I LOVE YOU')                AS before_ltrim,
    LTRIM(' I LOVE YOU')                 AS Ltrim_,
    LENGTH(LTRIM(' I LOVE YOU'))         AS after_ltrim,

    TRIM(' I LOVE YOU  ')                AS trim_,
    LENGTH(TRIM(' I LOVE YOU  '))        AS after_trim
```

## PostgreSQL

```sql
SELECT
    REPLACE('I LOVE YOU', 'I', 'WE'),
    LENGTH('I LOVE YOU ')                AS before_rtrim,
    RTRIM('I LOVE YOU ')                 AS rtrim_,
    LENGTH(RTRIM('I LOVE YOU '))         AS after_rtrim,

    LENGTH(' I LOVE YOU')                AS before_ltrim,
    LTRIM(' I LOVE YOU')                 AS ltrim_,
    LENGTH(LTRIM(' I LOVE YOU'))         AS after_ltrim,

    TRIM(' I LOVE YOU  ')                AS trim_,
    LENGTH(TRIM(' I LOVE YOU  '))        AS after_trim
```

## SQL Server

```sql
SELECT
    REPLACE('I LOVE YOU', 'I', 'WE')     AS replace_,

    DATALENGTH('I LOVE YOU ')            AS before_rtrim,
    RTRIM('I LOVE YOU ')                 AS rtrim_,
    DATALENGTH(RTRIM('I LOVE YOU '))     AS after_rtrim,

    DATALENGTH(' I LOVE YOU')            AS before_ltrim,
    LTRIM(' I LOVE YOU')                 AS ltrim_,
    DATALENGTH(LTRIM(' I LOVE YOU'))     AS after_ltrim
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
