# How do I find the first day of previous/next week?

<!-- vscode-markdown-toc -->
* 1. [SQL Server](#SQLServer)
* 2. [MySQL](#MySQL)
* 3. [PostgreSQL](#PostgreSQL)
* 4. [Vertica](#Vertica)
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
----------------------------Mon-Sun week-------------------------------------------------
convert(date, getdate()) as Today,
datepart(dw, getdate()) as Weekday,

case ---------------previous week--------------------------------------------------------
	when datepart(dw, getdate()) = 1 then convert(date, dateadd(day, -13, getdate()))
	when datepart(dw, getdate()) = 2 then convert(date, dateadd(day, -7, getdate()))
	when datepart(dw, getdate()) = 3 then convert(date, dateadd(day, -8, getdate()))
	when datepart(dw, getdate()) = 4 then convert(date, dateadd(day, -9, getdate()))
	when datepart(dw, getdate()) = 5 then convert(date, dateadd(day, -10, getdate()))
	when datepart(dw, getdate()) = 6 then convert(date, dateadd(day, -11, getdate()))
	when datepart(dw, getdate()) = 7 then convert(date, dateadd(day, -12, getdate()))
                                                          end as FirstDayofPreviousWeek,                                                         
                                                         
 case ---------------next week--------------------------------------------------------
	when datepart(dw, getdate()) = 1 then convert(date, dateadd(day, +1, getdate()))
	when datepart(dw, getdate()) = 2 then convert(date, dateadd(day, +7, getdate()))
	when datepart(dw, getdate()) = 3 then convert(date, dateadd(day, +6, getdate()))
	when datepart(dw, getdate()) = 4 then convert(date, dateadd(day, +5, getdate()))
	when datepart(dw, getdate()) = 5 then convert(date, dateadd(day, +4, getdate()))
	when datepart(dw, getdate()) = 6 then convert(date, dateadd(day, +3, getdate()))
	when datepart(dw, getdate()) = 7 then convert(date, dateadd(day, +2, getdate()))
                                                          end as FirstDayofNextWeek,         

convert(date, convert(varchar(7), dateadd(month, -1, getdate()) , 120) + '-01') as FirstDayofPreviousMonth,														  
convert(date, convert(varchar(7), dateadd(month, +1, getdate()) , 120) + '-01') as FirstDayofNextMonth
```


##  2. <a name='MySQL'></a>MySQL
```sql
select 
Date(Now())  as Today,

case #----------------------previous week---------------------------------
	when weekday(Now()) = 0 then date(date_add(Now(), interval -7 day))
	when weekday(Now()) = 1 then date(date_add(Now(), interval -8 day))
	when weekday(Now()) = 2 then date(date_add(Now(), interval -9 day))
	when weekday(Now()) = 3 then date(date_add(Now(), interval -10 day))
	when weekday(Now()) = 4 then date(date_add(Now(), interval -11 day))
	when weekday(Now()) = 5 then date(date_add(Now(), interval -12 day))
	when weekday(Now()) = 6 then date(date_add(Now(), interval -13 day))
                                                          end as FirstDayofPreviousWeek,
                          
 
 case #----------------------next week---------------------------------
	when weekday(Now()) = 0 then date(date_add(Now(), interval +7 day))
	when weekday(Now()) = 1 then date(date_add(Now(), interval +6 day))
	when weekday(Now()) = 2 then date(date_add(Now(), interval +5 day))
	when weekday(Now()) = 3 then date(date_add(Now(), interval +4 day))
	when weekday(Now()) = 4 then date(date_add(Now(), interval +3 day))
	when weekday(Now()) = 5 then date(date_add(Now(), interval +2 day))
	when weekday(Now()) = 6 then date(date_add(Now(), interval +1 day))
                                                           end as FirstDayofNextWeek,
																  
 date_format(date_add(Now(), interval -1 month), '%Y-%m-01')   as FirstDayofPreviousMonth,                                           
 date_format(date_add(Now(), interval +1 month), '%Y-%m-01')   as FirstDayofNextMonth
 ```


##  3. <a name='PostgreSQL'></a>PostgreSQL

```sql
select

Date(Now()) as Today,

Date(date_trunc('week',  Now()  - interval '7 day'))   as FirstDayOfPreviousWeek,
Date(date_trunc('month', Now()  - interval '1 month')) as FirstDayofPrevioustMonth,
Date(date_trunc('year',  Now()  - interval '1 year'))  as FirstDayOfPreviousYear,

Date(date_trunc('week',  Now()  + interval '7 day'))   as FirstDayOfNextWeek,
Date(date_trunc('month', Now()  + interval '1 month')) as FirstDayofNextMonth,
Date(date_trunc('year',  Now()  + interval '1 year'))  as FirstDayOfNextYear
```


##  4. <a name='Vertica'></a>Vertica
```sql
select

Date(Now()) as Today,

Date(date_trunc('week',  timestampadd('week', -1, Now())))   as FirstDayOfPreviousWeek,
Date(date_trunc('month', timestampadd('month', -1, Now())))  as FirstDayofPrevioustMonth,
Date(date_trunc('year',  timestampadd('year', -1, Now())))   as FirstDayOfPreviousYear,

Date(date_trunc('week',  timestampadd('week', +1, Now())))   as FirstDayOfNextWeek,
Date(date_trunc('month', timestampadd('month', +1, Now())))  as FirstDayofNextMonth,
Date(date_trunc('year',  timestampadd('year', +1, Now())))   as FirstDayOfNextYear
```
 
##  5. <a name='BigQuery'></a>BigQueryy
 ```sql
 ```

##  6. <a name='Redshift'></a>Redshift
```sql
```

##  7. <a name='Python'></a>Pythonn
 ```python
 ```

##  8. <a name='Tableau'></a>Tableauu
 ```
 ```