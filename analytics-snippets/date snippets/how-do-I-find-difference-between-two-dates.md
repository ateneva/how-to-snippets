# How do I find the difference between two dates?

<!-- vscode-markdown-toc -->
* 1. [Vertica](#Vertica)
* 2. [SQL Server](#SQLServer)
* 3. [MySQL](#MySQL)
* 4. [PostgreSQL](#PostgreSQL)
* 5. [BigQuery (datetime_expression, datetime_expression, part)](#BigQuerydatetime_expressiondatetime_expressionpart)
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
datediff('year',    '1988-06-21', Now()) as YearsBetweenDates,
datediff('quarter', '1988-06-21', Now()) as QuartersBetweenDates,
datediff('month',   '1988-06-21', Now()) as MonthsBetweenDates,
datediff('day',     '1988-06-21', Now()) as DaysBetweenDates,
datediff('hour',    '1988-06-21', Now()) as HoursBetweenDates,
datediff('minute',  '1988-06-21', Now()) as MinutesBetweenDates,
datediff('second',  '1988-06-21', Now()) as SecondsBetweenDates,


timestampdiff('year',   '2015-08-22', Now()) as YearsBetween,
timestampdiff('month',  '2015-08-22', Now()) as MonthsBetween,
timestampdiff('week',   '2015-08-22', Now()) as WeeksBetween,
timestampdiff('day',    '2015-08-22', Now()) as DaysBetween,
timestampdiff('hour',   '2015-08-22', Now()) as HoursBetween,
timestampdiff('minute', '2015-08-22', Now()) as MinutesBetwee
```

OR 
```sql
select

--calculates completed period without current month
age_in_months(Now(), '1988-06-21'), 

--calculates completed period without current month
age_in_years(Now(), '1988-06-21'),                                   

--includes current month in calculation
datediff('month', '1988-06-21', Now()) as MonthsBetweenDates, 

--includes current month in calculation
datediff('year', '1988-06-21', Now()) as YearsBetweenDates,          

-- calculates months between two dates as a float
months_between (Now(),'2017-01-01')                                
```

##  2. <a name='SQLServer'></a>SQL Server
```sql
select
datediff(year,    '1988-06-21', getdate()) as YearsBetweenDates,
datediff(quarter, '1988-06-21', getdate()) as QuartersBetweenDates,
datediff(month,   '1988-06-21', getdate()) as MonthsBetweenDates,
datediff(day,     '1988-06-21', getdate()) as DaysBetweenDates,
datediff(hour,    '1988-06-21', getdate()) as HoursBetweenDates,
datediff(minute,  '1988-06-21', getdate()) as MinutesBetweenDates,
datediff(second,  '1988-06-21', getdate()) as SecondsBetweenDates
```


##  3. <a name='MySQL'></a>MySQL

```sql
select
datediff(Now(), '1988-06-21') as DaysBetween,

timestampdiff(year,    '1988-06-21', Now()) as YearsBetweenDates,
timestampdiff(quarter, '1988-06-21', Now()) as QuartersBetweenDates,
timestampdiff(month,   '1988-06-21', Now()) as MonthsBetweenDates,
timestampdiff(day,     '1988-06-21', Now()) as DaysBetweenDates,
timestampdiff(hour,    '1988-06-21', Now()) as HoursBetweenDates,
timestampdiff(minute,  '1988-06-21', Now()) as MinutesBetweenDates,
timestampdiff(second,  '1988-06-21', Now()) as SecondsBetweenDates
```

OR 

```sql
select
--months between now and a past date
period_diff(201712, 201707) as Past,

 --months between now and a future date
period_diff(201806, 201712) as Future    
```


##  4. <a name='PostgreSQL'></a>PostgreSQL 

```sql
select
age(Now(), '1988-06-21') as YearsBetweenDates
```

```
yearsbetweendates                                      |
-------------------------------------------------------|
29 years 5 mons 19 days 21 hours 0 mins 39.466046 secs |
```



##  5. <a name='BigQuerydatetime_expressiondatetime_expressionpart'></a>BigQuery (datetime_expression, datetime_expression, part)
```sql
SELECT
  CURRENT_DATE() AS NOW,
  DATETIME_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), YEAR )          AS YearsBetweenDatetimes,
  DATETIME_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), QUARTER)        AS QuartersBetweenDatetimes,
  DATETIME_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), MONTH)          AS MonthsBetweenDatetimes,
  DATETIME_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), ISOWEEK)        AS IsoWeeksBetweenDatetimes,
  DATETIME_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), WEEK)           AS WeeksBetweenDatetimes,
  DATETIME_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), WEEK(FRIDAY))   AS DefinedWeeksBetweenDatetimes,
  DATETIME_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), DAY)            AS DaysBetweenDatetimes,
  DATETIME_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), HOUR)           AS HoursBetweenDatetimes,
  DATETIME_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), MINUTE)         AS MinutesBetweenDatetimes,
  DATETIME_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), SECOND)         AS SecondsBetweenDatetimes,


  DATETIME_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), YEAR )          AS YearsBetweenDatetimes,
  DATETIME_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), QUARTER)        AS QuartersBetweenDatetimes,
  DATETIME_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), MONTH)          AS MonthsBetweenDatetimes,
  DATETIME_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), ISOWEEK)        AS IsoWeeksBetweenDatetimes,
  DATETIME_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), WEEK)           AS WeeksBetweenDatetimes,
  DATETIME_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), WEEK(FRIDAY))   AS DefinedWeeksBetweenDatetimes,
  DATETIME_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), DAY)            AS DaysBetweenDatetimes,
  DATETIME_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), HOUR)           AS HoursBetweenDatetimes,
  DATETIME_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), MINUTE)         AS MinutessBetweenDatetimes,
  DATETIME_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), SECOND)         AS SecondsBetweenDatetimes
```

```json
[
  {
    "now": "2020-11-08",
    "years_between_datetimes": 1,
    "quarters_between_datetimes": 7,
    "months_between_datetimes": 22,
    "iso_weeks_between_datetimes": 93,
    "weeks_between_datetimes": 94,
    "defined_weeks_between_datetimes": 94,
    "days_between_datetimes": 657,
    "hours_between_datetimes": 15768,
    "minutes_between_datetimes": 946080,
    "seconds_between_datetimes": 56764800,
    "years_between_datetimes_1": -1,
    "quarters_between_datetimes_1": -7,
    "months_between_datetimes_1": -22,
    "iso_weeks_between_datetimes_1": -93,
    "weeks_between_datetimes_1": -94,
    "defined_weeks_between_datetimes_1": -94,
    "days_between_datetimes_1": -657,
    "hours_between_datetimes_1": -15768,
    "minutess_between_datetimes": -946080,
    "seconds_between_datetimes_1": -56764800
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