
# How do I calculate the remaining days until the end of a fiscal quarter?

<!-- vscode-markdown-toc -->
* 1. [Vertica](#Vertica)
* 2. [SQL Server](#SQLServer)
* 3. [MySQL](#MySQL)
* 4. [PostgreSQL](#PostgreSQL)
* 5. [Bigquery](#Bigquery)
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
---calculate remaining days in fiscal quarter
select
case 
	when Month(Now()) in (11,12,1) then 'FQ1'
	when Month(Now()) in (2,3,4) then 'FQ2'
	when Month(Now()) in (5,6,7) then 'FQ3'
	when Month(Now()) in (8,9,10) then 'FQ4'
end as CurrentFiscalQuarter,

case 
	when Month(Now()) in (11,12,1) Then datediff('dd', Date(Now()), to_date(Concat(Year(Now()),'-01-31'), 'YYYY-MM-DD')) 
	when Month(Now()) in (2,3,4) Then datediff('dd', Date(Now()), to_date(Concat(Year(Now()),'-04-30'), 'YYYY-MM-DD')) 
	when Month(Now()) in (5,6,7) Then datediff('dd', Date(Now()), to_date(Concat(Year(Now()),'-07-31'), 'YYYY-MM-DD')) 
	when Month(Now()) in (8,9,10) Then datediff('dd', Date(Now()), to_date(Concat(Year(Now()),'-10-31'), 'YYYY-MM-DD')) 
end as RemainingDaysInQuarter
```

##  2. <a name='SQLServer'></a>SQL Server
```sql
select
case 
	when Month(getdate()) in (11,12,1) then 'FQ1'
	when Month(getdate()) in (2,3,4) then 'FQ2'
	when Month(getdate()) in (5,6,7) then 'FQ3'
	when Month(getdate()) in (8,9,10) then 'FQ4'
end as CurrentFiscalQuarter,

case 
	when Month(getdate()) in (11,12,1)
		then datediff(day, getdate(), convert(date, Concat(Year(getdate())+1,'-01-31')) ) 
		
	when Month(getdate()) in (2,3,4)
		then datediff(day, getdate(), convert(date, Concat(Year(getdate()),'-04-30')) ) 

	when Month(getdate()) in (5,6,7)
		then datediff(day, getdate(), convert(date, Concat(Year(getdate()),'-07-31')) ) 

	when Month(getdate()) in (8,9,10)	
		then datediff(day, getdate(), convert(date, Concat(Year(getdate()),'-10-31')) )
		
```
##  3. <a name='MySQL'></a>MySQL

```sql	
select		
case 
	when Month(Now()) in (11,12,1) then 'FQ1'
	when Month(Now()) in (2,3,4) then 'FQ2'
	when Month(Now()) in (5,6,7) then 'FQ3'
	when Month(Now()) in (8,9,10) then 'FQ4'
end as CurrentFiscalQuarter,

case 
	when Month(Now()) in (11,12,1)
		then timestampdiff(day, Now(), str_to_date(Concat(Year(Now())+1,'-01-31'), '%Y-%m-%d') ) 
		
	when Month(Now()) in (2,3,4)
		then timestampdiff(day, Now(), str_to_date(Concat(Year(Now()),'-04-30'), '%Y-%m-%d') ) 

	when Month(Now()) in (5,6,7)
		then timestampdiff(day, Now(), str_to_date(Concat(Year(Now()),'-07-31'), '%Y-%m-%d') ) 

	when Month(Now()) in (8,9,10)	
		then timestampdiff(day, Now(), str_to_date(Concat(Year(Now()),'-10-31'), '%Y-%m-%d') )
		
end as Remaining_in_Fis_Quarter
 ```
 
##  4. <a name='PostgreSQL'></a>PostgreSQL
 ```sql
 select
 case 
	when date_part('month', Now()) in (11,12,1) then 'FQ1'
	when date_part('month', Now()) in (2,3,4) then 'FQ2'
	when date_part('month', Now()) in (5,6,7) then 'FQ3'
	when date_part('month', Now()) in (8,9,10) then 'FQ4'
end as CurrentFiscalQuarter,

case 
	when date_part('month', Now()) in (11,12,1)
		then date_part('day', to_date(date_part('year', current_date)+1 || '-01-31', 'YYYY-MM-DD') - Now() ) + 1
	
	when date_part('month', Now()) in (2,3,4)
		then date_part('day', to_date(date_part('year', current_date) || '-04-30', 'YYYY-MM-DD') - NoW() ) + 1 
		
	when date_part('month', Now()) in (5,6,7) 
		then date_part('day', to_date(date_part('year', current_date) || '-07-31', 'YYYY-MM-DD') - Now() ) + 1

	when date_part('month', Now()) in (8,9,10)	
		then date_part('day', to_date(date_part('year', current_date) || '-10-31', 'YYYY-MM-DD') - Now() ) + 1
		
end as Remaining_In_Fis_Quarter
```

##  5. <a name='Bigquery'></a>Bigquery
```sql
```


##  6. <a name='Redshift'></a>Redshift
```
```


##  7. <a name='Python'></a>Python
```python
```

##  8. <a name='Tableau'></a>Tableau
```
```
