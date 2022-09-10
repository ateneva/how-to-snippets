# How do I get current time?

<!-- vscode-markdown-toc -->
* 1. [VERTICA](#VERTICA)
* 2. [MySQL](#MySQL)
* 3. [MS SQL Server](#MSSQLServer)
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


##  1. <a name='VERTICA'></a>VERTICA
```sql
select 
current_timestamp          as CurrentTimestamp,     ---current laptop/pc date and time
current_date               as CurrentDate,          ---current laptop/pc date
current_time               as CurrentTime,          ---current laptop/pc time

getutcdate()               as UTCDateAndTime,       ---date and time of UTC standard
getdate()                                           ---date and time supplied by the operating system of the server to which you are connected

Now()                      as MyTimeRightNow,       ---current laptop/pc date and time
date(Now())                as Today,                ---current laptop/pc date
time(Now())                as MyTime                ---current laptop/pc time
```

##  2. <a name='MySQL'></a>MySQL
```sql
select
utc_timestamp              as UTCDateAndTime,      #---date and time of UTC standard
utc_date                   as UTCDate,             #---date of UTC standard
utc_time                   as UTCTime,             #---time of UTC standard
current_timestamp          as MyLocalDateAndTime,  #---current laptop/pc date and time
current_date               as Today,               #---current laptop/pc date
current_time               as MyTimeNow,           #---current laptop/pc time

Now()                      as MyTimeRightNow,      #---current laptop/pc date and time
date(Now())                as Today,               #---current laptop/pc date
time(Now())                as MyTime               #---current laptop/pc time
```


##  3. <a name='MSSQLServer'></a>MS SQL Server
```sql
select
getutcdate()               as UTCDateAndTime,
getdate()                  as LocalServerDateAndTime,
current_timestamp          as TodayDateAndTime,
convert(date,getdate())    as Today, 
convert(time,getdate())    as Now 
```


##  4. <a name='PostgreSQL'></a>PostgreSQL
```sql
select 
current_timestamp          as CurrentTimestamp,     ---current laptop/pc date and time
current_date               as CurrentDate,          ---current laptop/pc date
current_time               as CurrentTime,          ---current laptop/pc time

Now()                      as MyTimeRightNow        ---current laptop/pc date and time
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