
# How do I find the date that is a number of months from/before now with SQL?

<!-- vscode-markdown-toc -->
* 1. [SQL Server](#SQLServer)
* 2. [MySQL](#MySQL)
* 3. [VERTICA: timestampaddd](#VERTICA:timestampaddd)
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
SELECT
    dateadd(year,    -1, getdate())   as OneYearAgo,
    dateadd(month,   -1, getdate())   as OneMonthAgo,
    dateadd(week,    -1, getdate())   as OneWeekAgo,
    dateadd(day,     -1, getdate())   as OneDayAgo,
    dateadd(weekday, -1, getdate())   as OneWeekdayAgo,
    dateadd(hour,    -1, getdate())   as OneHourAgo
```


```sql
SELECT
    dateadd(year,     1, getdate())   as OneYearFromNow,
    dateadd(month,    1, getdate())   as MonthFromNow,
    dateadd(week,     1, getdate())   as OneWeekFromNow,
    dateadd(day,      1, getdate())   as OneDayFromNow,
    dateadd(weekday,  1, getdate())   as OneWeekdayFromNow,
    dateadd(hour,     1, getdate())   as OneHourFromNow
```



##  2. <a name='MySQL'></a>MySQL
```sql
SELECT
    date_sub(Now(), interval 1 year)    as OneYearAgo,
    date_sub(Now(), interval 1 month)   as OneMonthAgo,
    date_sub(Now(), interval 1 week)    as OneWeekAgo,
    date_sub(Now(), interval 1 day)     as OneDayAgo,
    date_sub(Now(), interval 1 hour)    as OneHourAgo

 --or

SELECT
    date_add(Now(), interval -1 year)    as OneYearAgo,
    date_add(Now(), interval -1 month)   as OneMonthAgo,
    date_add(Now(), interval -1 week)    as OneWeekAgo,
    date_add(Now(), interval -1 day)     as OneDayAgo,
    date_add(Now(), interval -1 hour)    as OneHourAgo

--or
SELECT
    timestampadd(year,  -1, Now())    	as OneYearAgo,
    timestampadd(month, -1, Now())    	as OneMonthAgo,
    timestampadd(week, -1, Now())     	as OneWeekAgo,
    timestampadd(day, -1, Now())      	as OneDayAgo,
    timestampadd(hour, -1, Now())     	as OneHourAgo
```

```sql
SELECT
    date_add(Now(), interval 1 year)    as OneYearFromNow,
    date_add(Now(), interval 1 month)   as MonthFromNow,
    date_add(Now(), interval 1 week)    as OneWeekFromNow,
    date_add(Now(), interval 1 day)     as OneDayFromNow,
    date_add(Now(), interval 1 hour)    as OneHourFromNow

--OR

SELECT
    timestampadd(year, 1, Now())        as OneYearFromNow,
    timestampadd(month, 1, Now())       as MonthFromNow,
    timestampadd(week, 1, Now())        as OneWeekFromNow,
    timestampadd(day, 1, Now())         as OneDayFromNow,
    timestampadd(hour, 1, Now())        as OneHourFromNow
```

OR 

```sql
select 

now(),
date(adddate(now(), 5)) as 5DaysFromNow,    
time(addtime(now(), 5)) as 5SecondsFromNow,

date(subdate(now(), 5)) as 5DaysAgo,
time(subtime(now(), 5)) as 5SecondsAgo,


#fixed input month
period_add(201801, 3) as 3MonthFromYM,
period_add(201801,-3) as 3MonthAgo,

concat(year(now()),  #get current year month
	case when month(now()) < 10 then concat(0, month(now())) else month(now()) end) as ThisYM,
	
#dynamic input month
period_add(concat(year(now()),  #get current year month
				case when month(now()) < 10 then concat(0, month(now())) else month(now()) end), 5) as 5MonthsFromNow
```

##  3. <a name='VERTICA:timestampaddd'></a>VERTICA: timestampaddd
```sql
SELECT
    timestampadd('year',  -1, Now())    as OneYearAgo,
    timestampadd('month', -1, Now())    as OneMonthAgo,
    timestampadd('week', -1, Now())     as OneWeekAgo,
    timestampadd('day', -1, Now())      as OneDayAgo,
    timestampadd('hour', -1, Now())     as OneHourAgo,

    timestampadd('year', 1, Now())      as OneYearFromNow,
    timestampadd('month', 1, Now())     as MonthFromNow,
    timestampadd('week', 1, Now())      as OneWeekFromNow,
    timestampadd('day', 1, Now())       as OneDayFromNow,
    timestampadd('hour', 1, Now())      as OneHourFromNow
```

OR 

```sql
select 
    Now(),
    add_months(Now(), 1) as 1MonthFromNow,
    add_months(Now(),-1) as 1MonthAgo,

    add_months(Now(), 5) as 5MonthsFromNow,
    add_months(Now(),-5) as 5MonthsAgo,

    add_months(Now(), 8) as 8MonthsFromNow,
    add_months(Now(),-8) as 8MonthsAgo
```

##  4. <a name='PostgreSQL'></a>PostgreSQL
```sql
SELECT
    Now() - INTERVAL '1 year'    as OneYearAgo,
    Now() - INTERVAL '1 month'   as OneMonthAgo,
    Now() - INTERVAL '1 week'    as OneWeekAgo,
    Now() - INTERVAL '1 day'     as OneDayAgo,
    Now() - INTERVAL '1 hour'    as OneHourAgo
```


```sql
SELECT
    Now() + INTERVAL '1 year'    as OneYearFromNow,
    Now() + INTERVAL '1 month'   as OneMonthFromNow,
    Now() + INTERVAL '1 week'    as OneWeekFromNow,
    Now() + INTERVAL '1 day'     as OneDayFromNow,
    Now() + INTERVAL '1 hour'    as OneHourFromNow
```

##  5. <a name='BigQuery'></a>BigQuery
```sql
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