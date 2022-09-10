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


##  1. <a name='Vertica'></a>Vertica

```sql
select
Date(date_trunc('week', Now()))  as FirstDayOfCurrentWeek,
Date(date_trunc('month', Now())) as FirstDayofCurrentMonth,
Date(date_trunc('year', Now()))  as FirstDayOfCurrentYear
```

##  2. <a name='PostgreSQL'></a>PostgreSQL

```sql
select
Date(date_trunc('week', Now()))  as FirstDayOfCurrentWeek,
Date(date_trunc('month', Now())) as FirstDayofCurrentMonth,
Date(date_trunc('year', Now()))  as FirstDayOfCurrentYear
```


##  3. <a name='SQLServer'></a>SQL Server

```sql
select
convert(date, getdate()) as Today,
datepart(dw, getdate()) as Weekday,

case ----------------------------Mon-Sun week-----------------------------------------
	when datepart(dw, getdate()) = 1 then convert(date, dateadd(day, -6, getdate()))
	when datepart(dw, getdate()) = 2 then convert(date, dateadd(day,  0, getdate()))
	when datepart(dw, getdate()) = 3 then convert(date, dateadd(day, -1, getdate()))
	when datepart(dw, getdate()) = 4 then convert(date, dateadd(day, -2, getdate()))
	when datepart(dw, getdate()) = 5 then convert(date, dateadd(day, -3, getdate()))
	when datepart(dw, getdate()) = 6 then convert(date, dateadd(day, -4, getdate()))
	when datepart(dw, getdate()) = 7 then convert(date, dateadd(day, -5, getdate()))
                                                          end as FirstDayofCurrentWeek,


convert(date, convert(varchar(7), getdate(), 120) + '-01')    as FirstDayofCurrentMonth,
convert(date, convert(varchar(4), getdate(), 120) + '-01-01') as FirstDayofCurrentYear
```


##  4. <a name='MySQL'></a>MySQL

```sql
select
Date(Now())                                                  as Today,
weekday(Now())                                               as WeekdayToday,

case #---------------------------Mon-Sun week--------------------------------
	when weekday(Now()) = 0 then date(Now())
	when weekday(Now()) = 1 then date(date_add(Now(), interval -1 day))
	when weekday(Now()) = 2 then date(date_add(Now(), interval -2 day))
	when weekday(Now()) = 3 then date(date_add(Now(), interval -3 day))
	when weekday(Now()) = 4 then date(date_add(Now(), interval -4 day))
	when weekday(Now()) = 5 then date(date_add(Now(), interval -5 day))
	when weekday(Now()) = 6 then date(date_add(Now(), interval -6 day))
                                                         end as FirstDayofCurrentWeek,

date_format(Now(), '%Y-%m-01')                               as FirstDayofCurrentMonth,
date_format(Now(), '%Y-01-01')                               as FirstDayofCurrentYear
```


##  5. <a name='BigQuery'></a>BigQuery
```sql
SELECT
	CURRENT_DATE() AS NOW,
	DATE_TRUNC(CURRENT_DATE(), WEEK)           AS FirstDayOfCurrentWeek,
	DATE_TRUNC(CURRENT_DATE(), WEEK(FRIDAY))   AS FirstDayOfDefinedCurrentWeek,
	DATE_TRUNC(CURRENT_DATE(), ISOWEEK)        AS FirstDayOfCurrentISOWeek,
	DATE_TRUNC(CURRENT_DATE(), MONTH)          AS FirstDayofCurrentMonth,
	DATE_TRUNC(CURRENT_DATE(), QUARTER)        AS FirstDayofCurrentQuarter,
	DATE_TRUNC(CURRENT_DATE(), YEAR)           AS FirstDayOfCurrentYear,
	DATE_TRUNC(CURRENT_DATE(), ISOYEAR)        AS FirstDayOfCurrentISOYear
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

##  6. <a name='Redshift'></a>Redshift
```sql
```

##  7. <a name='Python'></a>Python
```python
```


##  8. <a name='Tableau'></a>Tableau
```
```