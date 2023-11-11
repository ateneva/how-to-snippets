
# How do I concatenate strings?

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
