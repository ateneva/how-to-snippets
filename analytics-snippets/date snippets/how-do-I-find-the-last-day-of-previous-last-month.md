# How do I find the last day of the previous/next month?


<!-- vscode-markdown-toc -->
* 1. [SQL Server](#SQLServer)
* 2. [Vertica](#Vertica)
* 3. [MySQL](#MySQL)
* 4. [PostgreSQL](#PostgreSQL)
* 5. [BigQuery](#BigQuery)
* 6. [Redshift](#Redshift)
* 7. [Python](#Python)
* 8. [Tableau](#Tableau)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->


##  1. <a name='SQLServer'></a>SQL Server
```sql
select
convert(date,getdate()) as Today,
eomonth(getdate(),-1)   as LastDayPreviousMonth,
eomonth(getdate(),+0)   as LastDayThisMonth,
eomonth(getdate(),+1)   as LastDayNextMonth
```

##  2. <a name='Vertica'></a>Vertica
```sql
select
now()                          as Today
last_day(Now())                as LastDayofCurrentMonth,
last_day(add_months(Now(),-1)) as LastDayofPreviousMonth,
last_day(add_months(Now(), 1)) as LastDayofNextMonth
```


##  3. <a name='MySQL'></a>MySQL
```sql
select
date(now())                   as Today,
last_day(adddate(Now(), -31)) as LastDayPreviousMonth,
last_day(Now())               as LastDayThisMonth,
last_day(adddate(Now(), +31)) as LastDayNextMonth
```


##  4. <a name='PostgreSQL'></a>PostgreSQL
```sql
select
Date(Now()) as Today,
Date(date_trunc('month', Now() + interval '0 month') - interval '1 day')  as LastDayPreviousMonth,
Date(date_trunc('month', Now() + interval '1 month') - interval '1 day')  as LastDayThisMonth,
Date(date_trunc('month', Now() + interval '2 month') - interval '1 day')  as LastDayNextMonth
```

##  5. <a name='BigQuery'></a>BigQuery
```sql
SELECT
  CURRENT_DATE() AS NOW,
  LAST_DAY(CURRENT_DATE(), WEEK)            AS LastDayOfCurrentWeek,
  LAST_DAY(CURRENT_DATE(), WEEK(FRIDAY))    AS LastDayOfCurrentDefinedWeek,
  LAST_DAY(CURRENT_DATE(), ISOWEEK)         AS LastDayOfCurrentISOWeek,
  LAST_DAY(CURRENT_DATE(), MONTH)           AS LastDayofCurrentMonth,
  LAST_DAY(CURRENT_DATE(), QUARTER)         AS LastDayofCurrentQuarter,
  LAST_DAY(CURRENT_DATE(), YEAR)            AS LastDayOfCurrentYear,
  LAST_DAY(CURRENT_DATE(), ISOYEAR)         AS LastDayOfCurrentISOYear
```
```json
[
  {
    "now": "2020-11-08",
    "last_day_of_current_week": "2020-11-14",
    "last_day_of_current_defined_week": "2020-11-12",
    "last_day_of_current_iso_week": "2020-11-08",
    "last_day_of_current_month": "2020-11-30",
    "last_day_of_current_quarter": "2020-12-31",
    "last_day_of_current_year": "2020-12-31",
    "last_day_of_current_iso_year": "2021-01-03"
  }
]
```

##  6. <a name='Redshift'></a>Redshift
```sql
```


##  7. <a name='Python'></a>Python
```python
```

##  8. <a name='Tableau'></a>Tableau
```
```