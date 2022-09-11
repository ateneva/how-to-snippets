# How do I find the first day of the current week?

<!-- vscode-markdown-toc -->
* 1. [Vertica](#Vertica)
* 2. [PostgreSQL](#PostgreSQL)
* 3. [SQL Server](#SQLServer)
* 4. [MySQL](#MySQL)
* 5. [BigQuery](#BigQuery)
* 6. [Redshift](#Redshift)
* 7. [Python](#Python)
* 8. [Tableau](#Tableau)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

<!-- markdownlint-disable MD033 -->

## 1. <a name='Vertica'></a>Vertica

```sql
SELECT
    DATE(DATE_TRUNC('WEEK', NOW()))  AS first_day_of_current_week,
    DATE(DATE_TRUNC('MONTH', NOW())) AS first_day_of_current_month,
    DATE(DATE_TRUNC('YEAR', NOW()))  AS first_day_of_current_year
```

## 2. <a name='PostgreSQL'></a>PostgreSQL

```sql
SELECT
    DATE(DATE_TRUNC('WEEK', NOW()))  AS first_day_of_current_week,
    DATE(DATE_TRUNC('MONTH', NOW())) AS first_dayof_current_month,
    DATE(DATE_TRUNC('YEAR', NOW()))  AS first_day_of_current_year
```

## 3. <a name='SQLServer'></a>SQL Server

```sql
SELECT
    CONVERT(DATE, GETDATE())  AS today,
    DATEPART(DW, GETDATE())  AS weekdaytoday,

    CASE ----------------------------MON-SUN WEEK---------------------------------
        WHEN DATEPART(DW, GETDATE()) = 1 THEN CONVERT(DATE, DATEADD(DAY, -6, GETDATE()))WHEN DATEPART(DW, GETDATE()) = 2 THEN CONVERT(DATE, DATEADD(DAY,  0, GETDATE()))
        WHEN DATEPART(DW, GETDATE()) = 3 THEN CONVERT(DATE, DATEADD(DAY, -1, GETDATE()))
        WHEN DATEPART(DW, GETDATE()) = 4 THEN CONVERT(DATE, DATEADD(DAY, -2, GETDATE()))
        WHEN DATEPART(DW, GETDATE()) = 5 THEN CONVERT(DATE, DATEADD(DAY, -3, GETDATE()))
        WHEN DATEPART(DW, GETDATE()) = 6 THEN CONVERT(DATE, DATEADD(DAY, -4, GETDATE()))
        WHEN DATEPART(DW, GETDATE()) = 7 THEN CONVERT(DATE, DATEADD(DAY, -5, GETDATE()))
    END AS first_day_of_current_week,

    CONVERT(DATE, CONVERT(VARCHAR(7), GETDATE(), 120) + '-01')    AS first_day_of_current_month,
    
    CONVERT(DATE, CONVERT(VARCHAR(4), GETDATE(), 120) + '-01-01') AS first_day_of_current_year
```

## 4. <a name='MySQL'></a>MySQL

```sql
SELECT
    DATE(NOW())       AS today,
    WEEKDAY(NOW())    AS weekdaytoday,

    CASE #---------------------------MON-SUN WEEK--------------------------------
        WHEN WEEKDAY(NOW()) = 0 THEN DATE(NOW()) 
        WHEN WEEKDAY(NOW()) = 1 THEN DATE(DATE_ADD(NOW(), INTERVAL -1 DAY))
        WHEN WEEKDAY(NOW()) = 2 THEN DATE(DATE_ADD(NOW(), INTERVAL -2 DAY))
        WHEN WEEKDAY(NOW()) = 3 THEN DATE(DATE_ADD(NOW(), INTERVAL -3 DAY))
        WHEN WEEKDAY(NOW()) = 4 THEN DATE(DATE_ADD(NOW(), INTERVAL -4 DAY))
        WHEN WEEKDAY(NOW()) = 5 THEN DATE(DATE_ADD(NOW(), INTERVAL -5 DAY))
        WHEN WEEKDAY(NOW()) = 6 THEN DATE(DATE_ADD(NOW(), INTERVAL -6 DAY))
    END AS first_day_of_current_week,

    DATE_FORMAT(NOW(), '%Y-%M-01')  AS first_day_of_current_month,
    DATE_FORMAT(NOW(), '%Y-01-01')  AS first_day_of_current_year
```

## 5. <a name='BigQuery'></a>BigQuery

```sql
SELECT
    CURRENT_DATE() AS NOW,
    DATE_TRUNC(CURRENT_DATE(), WEEK)           AS first_day_of_current_week,
    DATE_TRUNC(CURRENT_DATE(), WEEK(FRIDAY))   AS first_day_of_defined_current_week,
    DATE_TRUNC(CURRENT_DATE(), ISOWEEK)        AS first_day_of_current_iso_week,
    DATE_TRUNC(CURRENT_DATE(), MONTH)          AS first_day_of_current_month,
    DATE_TRUNC(CURRENT_DATE(), QUARTER)        AS first_day_of_current_quarter,
    DATE_TRUNC(CURRENT_DATE(), YEAR)           AS first_day_of_current_year,
    DATE_TRUNC(CURRENT_DATE(), ISOYEAR)        AS first_day_of_current_iso_year
```

```json
[
  {
    "now": "2020-11-08",
    "first_day_of_current_week": "2020-11-08",
    "first_day_of_defined_current_week": "2020-11-06",
    "first_day_of_current_iso_week": "2020-11-02",
    "first_day_of_current_month": "2020-11-01",
    "first_day_of_current_quarter": "2020-10-01",
    "first_day_of_current_year": "2020-01-01",
    "first_day_of_current_iso_year": "2019-12-30"
  }
]
```

## 6. <a name='Redshift'></a>Redshift

```sql
```

## 7. <a name='Python'></a>Python

```python
```

## 8. <a name='Tableau'></a>Tableau

```text
```
