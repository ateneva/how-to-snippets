
# How do I convert string to a date?

## VERTICA

```sql
SELECT
  '2017-03-31'                          as text_field,
  TO_DATE('2017-03-31', 'YYYY-MM-DD')   as date_field
```

## PostgreSQL

```sql
SELECT
  '2017-03-31'                          as text_field,
  TO_DATE('2017-03-31', 'YYYY-MM-DD')   as date_field
```

## MySQL

```sql
SELECT
  '2017-03-31'                          as text_field,
  STR_TO_DATE('2017-03-31', '%Y-%m-%d') as date_field
```

## SQL Server

```sql
SELECT
  '2017-03-31'                          as text_field,
  CONVERT(date, '2017-03-31')           as date_field1,
  CAST('2017-03-31' as date)            as date_field2
```

## BigQuery

```sql
SELECT
  CURRENT_DATE() AS NOW,
  PARSE_DATE("%Y/%m/%d", "2012/12/21") AS THE_DATE,

  FORMAT_DATE("%Y-%b-%d",
      PARSE_DATE("%Y/%m/%d", "2012/12/21")) AS THE_DATE_FORMATTED
```

```json
[
  {
    "NOW": "2020-11-08",
    "THE_DATE": "2012-12-21",
    "THE_DATE_FORMATTED": "2012-Dec-21"
  }
]
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
