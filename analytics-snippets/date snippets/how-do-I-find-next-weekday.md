# How do I find the next Monday/Tuesday/etc?

<!-- vscode-markdown-toc -->
* 1. [Vertica](#Vertica)
* 2. [SQL Server](#SQLServer)
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

##  1. <a name='Vertica'></a>Vertica
```sql
select
Now()                          as Today,
next_day(Now(), 'Monday')      as NextMonday,       --returns the date of next Monday
next_day(Now(), 'Tuesday')     as NextTuesday,      --returns the date of next Tuesday
next_day(Now(), 'Wednesday')   as NextWednesday,    --returns the date of next Wednesday
next_day(Now(), 'Thursday')    as NextThursday,     --returns the date of next Thursday
next_day(Now(), 'Friday')      as NextFriday,       --returns the date of next Friday
next_day(Now(), 'Saturday')    as NextSaturday,     --returns the date of next Saturday
next_day(Now(), 'Sunday')      as NextSunday        --returns the date of next Sunday
```

##  2. <a name='SQLServer'></a>SQL Server

```sql
select 
convert(date,getdate()) as Today,

-- 1=Sunday, 2=Monday, 3=Tuesday, 4=Wednesday, 5=Thursday, 6=Friday, 7=Sturday

convert(date, dateadd(day, 2, getdate() - datepart(dw, getdate())
           + case when datepart(dw, getdate()) < 2 then 0 else 7 end )) as NextMonday,
           
convert(date, dateadd(day, 3, getdate() - datepart(dw, getdate())
           + case when datepart(dw, getdate()) < 3 then 0 else 7 end )) as NextTuesday,
           
convert(date, dateadd(day, 4, getdate() - datepart(dw, getdate())
           + case when datepart(dw, getdate()) < 4 then 0 else 7 end )) as NextWednesday,
           
convert(date, dateadd(day, 5, getdate() - datepart(dw, getdate())
           + case when datepart(dw, getdate()) < 5 then 0 else 7 end )) as NextThursday,
           
convert(date, dateadd(day, 6, getdate() - datepart(dw, getdate())
           + case when datepart(dw, getdate()) < 6 then 0 else 7 end )) as NextFriday,
           
convert(date, dateadd(day, 7, getdate() - datepart(dw, getdate())
           + case when datepart(dw, getdate()) < 7 then 0 else 7 end )) as NextSaturday,
           
convert(date, dateadd(day, 1, getdate() - datepart(dw, getdate())
           + case when datepart(dw, getdate()) < 1 then 0 else 7 end )) as NextSunday
	
```
		   
##  3. <a name='MySQL'></a>MySQL
```sql
select 
date(Now()) as Today,

-- 1=Sunday, 2=Monday, 3=Tuesday, 4=Wednesday, 5=Thursday, 6=Friday, 7=Sturday

date(adddate(Now(), 2 - dayofweek(Now())
           + case when dayofweek(Now()) < 2 then 0 else 7 end )) as NextMonday,

date(adddate(Now(), 3 - dayofweek(Now())
           + case when dayofweek(Now()) < 3 then 0 else 7 end )) as NextTuesday,

date(adddate(Now(), 4 - dayofweek(Now())
           + case when dayofweek(Now()) < 4 then 0 else 7 end )) as NextWednesday,

date(adddate(Now(), 5 - dayofweek(Now())
           + case when dayofweek(Now()) < 5 then 0 else 7 end )) as NextThursday,

date(adddate(Now(), 6 - dayofweek(Now())
           + case when dayofweek(Now()) < 6 then 0 else 7 end )) as NextFriday,
           
date(adddate(Now(), 7 - dayofweek(Now())
           + case when dayofweek(Now()) < 7 then 0 else 7 end )) as NextSaturday,
           
date(adddate(Now(), 1 - dayofweek(Now())
           + case when dayofweek(Now()) < 1 then 0 else 7 end )) as NextSunday
```
       

##  4. <a name='PostgreSQL'></a>PostgreSQL

```sql
select
-- 1=Monday, 2=Tuesday, 3=Wednesday, 4=Thursday, 5=Friday, 6=Saturday, 7=Sunday
---------------------------------------------------------------------------------------------------------------
-- timestamp + cast((num_of_days || ' day') as interval) 
---OR  
-- timestamp + "interval" (num_of_days || ' days')
----------------------------------------------------------------------------------------------------------------
Date(Now()) as Today,

Date(Now() + cast((1 - extract(dow from Now()))
           + (case when extract(dow from Now()) < 1 then 0 else 7 end) || ' day' as interval)) as NextMonday,

Date(Now() + cast((2 - extract(dow from Now()))
           + (case when extract(dow from Now()) < 2 then 0 else 7 end) || ' day' as interval)) as NextTuesday, 
           
Date(Now() + cast((3 - extract(dow from Now()))
           + (case when extract(dow from Now()) < 3 then 0 else 7 end) || ' day' as interval)) as NextWednesday,
           
Date(Now() + cast((4 - extract(dow from Now()))
           + (case when extract(dow from Now()) < 4 then 0 else 7 end) || ' day' as interval)) as NextThursday,
           
Date(Now() + cast((5 - extract(dow from Now()))
           + (case when extract(dow from Now()) < 5 then 0 else 7 end) || ' day' as interval)) as NextFriday,
           
Date(Now() + cast((6 - extract(dow from Now()))
           + (case when extract(dow from Now()) < 6 then 0 else 7 end) || ' day' as interval)) as NextSaturday,
           
Date(Now() + cast((7 - extract(dow from Now()))
           + (case when extract(dow from Now()) < 7 then 0 else 7 end) || ' day' as interval)) as NextSunday		  
```

--------------------------------------OR------------------------------------------------------------------

```sql
select
-- 1=Monday, 2=Tuesday, 3=Wednesday, 4=Thursday, 5=Friday, 6=Saturday, 7=Sunday
---------------------------------------------------------------------------------------------------------------
-- timestamp + cast((num_of_days || ' day') as interval) 
---OR  
-- timestamp + "interval" (num_of_days || ' days')
----------------------------------------------------------------------------------------------------------------

Date(Now()) as Today,

Date(Now() + "interval" ((1 - extract(dow from Now()))
           + (case when extract(dow from Now()) < 1 then 0 else 7 end) || ' day')) as NextMonday,

Date(Now() + "interval" ((2 - extract(dow from Now()))
           + (case when extract(dow from Now()) < 2 then 0 else 7 end) || ' day')) as NextTuesday, 
           
Date(Now() + "interval" ((3 - extract(dow from Now()))
           + (case when extract(dow from Now()) < 3 then 0 else 7 end) || ' day')) as NextWednesday,
           
Date(Now() + "interval" ((4 - extract(dow from Now()))
           + (case when extract(dow from Now()) < 4 then 0 else 7 end) || ' day')) as NextThursday,
           
Date(Now() + "interval" ((5 - extract(dow from Now()))
           + (case when extract(dow from Now()) < 5 then 0 else 7 end) || ' day')) as NextFriday,
           
Date(Now() + "interval" ((6 - extract(dow from Now()))
           + (case when extract(dow from Now()) < 6 then 0 else 7 end) || ' day')) as NextSaturday,
           
Date(Now() + "interval" ((7 - extract(dow from Now()))
           + (case when extract(dow from Now()) < 7 then 0 else 7 end) || ' day')) as NextSunday	

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