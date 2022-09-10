# How do I calculate the remaining days until the end of a calendar quarter?

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
---calculate remaining days in calendar quarter
select
Quarter(Now()) as CurrentCalendarQuarter,
	case 
		when Quarter(Now()) = 1 Then datediff('dd', Date(Now()), to_date(Concat(Year(Now()),'-03-31'), 'YYYY-MM-DD')) 
		when Quarter(Now()) = 2 Then datediff('dd', Date(Now()), to_date(Concat(Year(Now()),'-06-30'), 'YYYY-MM-DD')) 
		when Quarter(Now()) = 3 Then datediff('dd', Date(Now()), to_date(Concat(Year(Now()),'-09-30'), 'YYYY-MM-DD')) 
		when Quarter(Now()) = 4 Then datediff('dd', Date(Now()), to_date(Concat(Year(Now()),'-12-31'), 'YYYY-MM-DD')) 
		
	end as Remaining_In_Cal_Quarter
```	
	
##  2. <a name='SQLServer'></a>SQL Server

```sql
select
datepart(quarter, getdate()) as CurrentCalendarQuarter
case 
	when datepart(quarter, getdate() ) = '1'
		then datediff(day, getdate(), convert(date, Concat(Year(getdate()),'-03-31')) ) 
		
	when datepart(quarter, getdate() ) = '2'
		then datediff(day, getdate(), convert(date, Concat(Year(getdate()),'-06-30')) ) 

	when datepart(quarter, getdate() ) = '3'	
		then datediff(day, getdate(), convert(date, Concat(Year(getdate()),'-09-30')) ) 

	when datepart(quarter, getdate() ) = '4'		
		then datediff(day, getdate(), convert(date, Concat(Year(getdate()),'-12-31')) )
		
end as Remaining_In_Cal_Quarter
```

##  3. <a name='MySQL'></a>MySQL

```sql
select
extract(quarter from Now()) as CurrentCalendarQuarter,
case 
	when extract(quarter from Now()) = '1'
		then timestampdiff(day, Now(), str_to_date(Concat(Year(Now()),'-03-31'), '%Y-%m-%d'))
		
	when extract(quarter from Now()) = '2'
		then timestampdiff(day, Now(), str_to_date(Concat(Year(Now()),'-06-30'), '%Y-%m-%d'))
		
	when extract(quarter from Now()) = '3'
		then timestampdiff(day, Now(), str_to_date(Concat(Year(Now()),'-09-30'), '%Y-%m-%d'))
		
	when extract(quarter from Now()) = '4' 
		then timestampdiff(day, Now(), str_to_date(Concat(Year(Now()),'-12-31'), '%Y-%m-%d'))
		
end as Remaining_In_Cal_Quarter
```


##  4. <a name='PostgreSQL'></a>PostgreSQL

```sql
select
date_part('quarter', Now()) as CurrentCalendarQuarter

case 
	when date_part('quarter', Now()) = '1' 
		then date_part('day', to_date(date_part('year', current_date) || '-03-31', 'YYYY-MM-DD') - Now() ) + 1
	
	when date_part('quarter', Now()) = '2' 
		then date_part('day', to_date(date_part('year', current_date) || '-06-30', 'YYYY-MM-DD') - NoW() ) + 1 
		
	when date_part('quarter', Now()) = '3' 
		then date_part('day', to_date(date_part('year', current_date) || '-09-30', 'YYYY-MM-DD') - Now() ) + 1

	when date_part('quarter', Now()) = '4' 	
		then date_part('day', to_date(date_part('year', current_date) || '-12-31', 'YYYY-MM-DD') - Now() ) + 1
		
end as Remaining_In_Cal_Quarter
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
