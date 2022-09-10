# How do I extract part of a date?

<!-- vscode-markdown-toc -->
* 1. [Vertica](#Vertica)
* 2. [MS SQL Server](#MSSQLServer)
* 3. [MySQL](#MySQL)
* 4. [PostgreSQL: DATE_PART](#PostgreSQL:DATE_PART)
* 5. [PostgreSQL: EXTRACT](#PostgreSQL:EXTRACT)
* 6. [BigQuery: EXTRACT](#BigQuery:EXTRACT)
* 7. [Redshift](#Redshift)
* 8. [Python](#Python)
* 9. [Tableau](#Tableau)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

##  1. <a name='Vertica'></a>Vertica
```sql
current_date()                      as Today,
current_time                        as TimeNow,
current_timestamp                   as TodayDateAndTime,
Now(),
date_part('century', Now())         as Century,
date_part('decade', Now())          as Decade,
date_part('doy', Now())             as DayOfYear,
date_part('doq', Now())             as DayofQuarter,

----find day of current week (0 to 6)
date_part('dow', Now())             as DayOfWeek,
date_part('isoyear', Now())         as ISOYear,
date_part('isoweek', Now())         as ISOWeek,

----find day of current week (1 to 7)
date_part('isodow', Now())          as DayOfISOWeek,            
date_part('year', Now())            as CurrentYear,
date_part('quarter', Now())         as CurrentQuarter,
date_part('month', Now())           as CurrentMonth,
date_part('day', Now())             as CurrentDay,
date_part('hour', Now())            as CurrentHour
```

OR

```sql
select
Now(),                                 
Date(Now()) AS Today,
Year(Now()) AS ThisYear,
Quarter(Now()) AS ThisQuarter,
Month(Now()) AS ThisMonth,
Day(Now()) AS ThisDat,

dayofyear(Now()) as DayOfYear,
dayofweek(Now()) as WeekdayUS,         
dayofweek_iso(Now()) as WeekdayEU,     

week(Now())     as WeekNumUS,          
week_iso(Now()) as WeekNumEU
```

##  2. <a name='MSSQLServer'></a>MS SQL Server
```sql
select
current_timestamp                   as TodayDateAndTime,
datepart(yyyy, current_timestamp)   as CurrentYear,
datepart(qq, current_timestamp)     as CurrentQuarter,
datepart(mm, current_timestamp)     as CurrentMonth,

---find current week number (count as of 1st January),
datepart(wk, current_timestamp)     as Week,

----find current week number (count as of 1st full week)
datepart(isowk, current_timestamp)  as ISOWeek,                 

datepart(dd, current_timestamp)     as CurrentDay,
datepart(dy, current_timestamp)     as DayOfYear,

----find day of current week (Sun-Sat)
datepart(dw, current_timestamp)     as DayOfWeek,                
datepart(hh, current_timestamp)     as Hour
```

OR 

```sql
select

getdate()              as Now,
Year(getdate())        as ThisYear,
Month(getdate())       as ThisMonth,
Day(getdate())         as Today
```


##  3. <a name='MySQL'></a>MySQL
```sql
select
current_timestamp                        as MyLocalDateAndTime,
extract(year FROM CURRENT_TIMESTAMP)     as CurrentYear,
extract(quarter FROM CURRENT_TIMESTAMP)  as CurrentQuarter,
extract(month FROM CURRENT_TIMESTAMP)    as CurrentMonth,
extract(week FROM CURRENT_TIMESTAMP)     as CurrentWeek,
extract(day FROM CURRENT_TIMESTAMP)      as CurrentDay,
extract(hour FROM CURRENT_TIMESTAMP)     as CurrentHour
```

OR 

```sql
select

Now(),
Date(Now())          as Today,
Year(Now())          as ThisYear,
Quarter(Now())       as ThisQuarter,
Month(Now())         as ThisMonth,
Day(Now())           as ThisDay,

dayofyear(Now())     as DayOfYear,
dayofmonth(Now())    as DayOfMonth,
dayofweek(Now())     as DayofWeek,   #1 = Sunday, 2 = Monday, …, 7 = Saturday)
weekday(Now())       as WeekdayNum,  #0 = Monday, 1 = Tuesday, … 6 = Sunday

weekofyear(Now())    as WeekNumUS,
week(Now())        	 as WeekNumUS
```


##  4. <a name='PostgreSQL:DATE_PART'></a>PostgreSQL: DATE_PART
```sql
select
current_timestamp,
date_part('century', current_timestamp)         as Century,
date_part('decade', current_timestamp)          as Decade,
date_part('doy', current_timestamp)             as DayOfYear,
date_part('dow', current_timestamp)             as DayOfWeek,
date_part('isoyear', current_timestamp)         as ISOYear,
date_part('year', current_timestamp)            as CurrentYear,
date_part('quarter', current_timestamp)         as CurrentQuarter,
date_part('month', current_timestamp)           as CurrentMonth,
date_part('day', current_timestamp)             as CurrentDay,
date_part('hour', current_timestamp)            as CurrentHour
```


##  5. <a name='PostgreSQL:EXTRACT'></a>PostgreSQL: EXTRACT

```sql
SELECT
  CURRENT_TIMESTAMP,
  EXTRACT(century FROM CURRENT_TIMESTAMP)         as century,
  EXTRACT(decade FROM CURRENT_TIMESTAMP)          as decade,
  EXTRACT(doy FROM CURRENT_TIMESTAMP)             as day_of_year,

  ----find day of current week (0 to 6)
  EXTRACT(dow FROM CURRENT_TIMESTAMP)             as day_of_week,
  EXTRACT(isoyear FROM CURRENT_TIMESTAMP)         as iso_year,
  EXTRACT(year FROM CURRENT_TIMESTAMP)            as current_year,
  EXTRACT(quarter FROM CURRENT_TIMESTAMP)         as current_quarter,
  EXTRACT(month FROM CURRENT_TIMESTAMP)           as current_month,
  EXTRACT(day FROM CURRENT_TIMESTAMP)             as current_day,
  EXTRACT(hour FROM CURRENT_TIMESTAMP)            as current_hour
```


##  6. <a name='BigQuery:EXTRACT'></a>BigQuery: EXTRACT 

```sql
SELECT ---- also supports MILISECOND, MICROSECOND
  CURRENT_DATETIME() AS NOW,
  EXTRACT(YEAR FROM CURRENT_DATETIME())        AS current_year,
  EXTRACT(QUARTER FROM CURRENT_DATETIME())     AS current_quarter,
  EXTRACT(MONTH FROM CURRENT_DATETIME())       AS current_month,

  --starts by default on Sunday, but argument can be passed
  EXTRACT(WEEK FROM CURRENT_DATETIME())        AS current_week,
  
  --starts on Monday
  EXTRACT(ISOWEEK FROM CURRENT_DATETIME())     AS current_iso_week,

  EXTRACT(DAY FROM CURRENT_DATETIME())         AS current_day,
  EXTRACT(DAYOFYEAR FROM CURRENT_DATETIME())   AS current_day_of_year,
  EXTRACT(DAYOFWEEK FROM CURRENT_DATETIME())   AS current_day_of_week,
  EXTRACT(HOUR FROM CURRENT_DATETIME())        AS current_hour,
  EXTRACT(MINUTE FROM CURRENT_DATETIME())      AS current_minute,
  EXTRACT(SECOND FROM CURRENT_DATETIME())      AS current_second
```

OR

```sql
SELECT
  CURRENT_DATE() AS NOW,
  EXTRACT(YEAR FROM CURRENT_DATE())        AS CurrentYear,
  EXTRACT(QUARTER FROM CURRENT_DATE())     AS CurrentQuarter,
  EXTRACT(MONTH FROM CURRENT_DATE())       AS CurrentMonth,

  --starts by default on Sunday, but argument can be passed
  EXTRACT(WEEK FROM CURRENT_DATE())        AS CurrentWeek,

   --starts on Monday     
  EXTRACT(ISOWEEK FROM CURRENT_DATE())     AS CurrentIsoWeek, 

  EXTRACT(DAY FROM CURRENT_DATE())         AS CurrentDay,
  EXTRACT(DAYOFYEAR FROM CURRENT_DATE())   AS CurrentDayOfYear,
  EXTRACT(DAYOFWEEK FROM CURRENT_DATE())   AS CurrentDayOfWeek

[
  {
    "NOW": "2020-11-08",
    "CurrentYear": 2020,
    "CurrentQuarter": 4,
    "CurrentMonth": 11,
    "CurrentWeek": 45,
    "CurrentIsoWeek": 45,
    "CurrentDay": 8,
    "CurrentDayOfYear": 313,
    "CurrentDayOfWeek": 1
  }
]
```

```json
[
  {
    "now": "2020-11-08",
    "current_year": 2020,
    "current_quarter": 4,
    "current_month": 11,
    "current_week": 45,
    "current_iso_week": 45,
    "current_day": 8,
    "current_day_of_year": 313,
    "current_day_of_week": 1,
    "current_hour": 8,
    "current_minute": 31,
    "current_second": 14
  }
]
```

##  7. <a name='Redshift'></a>Redshift
```sql
```


##  8. <a name='Python'></a>Python
```python
```

##  9. <a name='Tableau'></a>Tableau
```
```

