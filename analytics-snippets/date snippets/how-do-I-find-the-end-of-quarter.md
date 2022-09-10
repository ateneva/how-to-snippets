
# How do I find the end of a quarter?

<!-- vscode-markdown-toc -->
* 1. [Vertica](#Vertica)
* 2. [PostgreSQL](#PostgreSQL)
* 3. [MySQL](#MySQL)
* 4. [SQL Server: Convert](#SQLServer:Convert)
* 5. [SQL Server: Cast](#SQLServer:Cast)
* 6. [BigQuery](#BigQuery)
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
select
to_date(Concat(Year(Now()),'-03-31'), 'YYYY-MM-DD') as EndOfCalQ1,
to_date(Concat(Year(Now()),'-06-30'), 'YYYY-MM-DD') as EndOfCalQ2,
to_date(Concat(Year(Now()),'-09-30'), 'YYYY-MM-DD') as EndOfCalQ3,
to_date(Concat(Year(Now()),'-12-31'), 'YYYY-MM-DD') as EndOfCalQ4,

to_date(Concat(Year(Now()),'-01-31'), 'YYYY-MM-DD') as EndOfFQ1,
to_date(Concat(Year(Now()),'-04-30'), 'YYYY-MM-DD') as EndOfFQ2,
to_date(Concat(Year(Now()),'-07-31'), 'YYYY-MM-DD') as EndOfFQ3,
to_date(Concat(Year(Now()),'-10-31'), 'YYYY-MM-DD') as EndOfFQ4
```

##  2. <a name='PostgreSQL'></a>PostgreSQL
```sql
select
to_date(date_part('year', current_date) || '-03-31', 'YYYY-MM-DD') as EndOfCalQ1,
to_date(date_part('year', current_date) || '-06-30', 'YYYY-MM-DD') as EndOfCalQ2,
to_date(date_part('year', current_date) || '-09-30', 'YYYY-MM-DD') as EndOfCalQ3,
to_date(date_part('year', current_date) || '-12-31', 'YYYY-MM-DD') as EndOfCalQ4,

to_date(date_part('year', current_date) || '-01-31', 'YYYY-MM-DD') as EndOfFQ1,
to_date(date_part('year', current_date) || '-04-30', 'YYYY-MM-DD') as EndOfFQ2,
to_date(date_part('year', current_date) || '-07-31', 'YYYY-MM-DD') as EndOfFQ3,
to_date(date_part('year', current_date) || '-10-31', 'YYYY-MM-DD') as EndOfFQ4
```

##  3. <a name='MySQL'></a>MySQL 
```sql
select
str_to_date(Concat(Year(Now()),'-03-31'), '%Y-%m-%d') as EndOfCalQ1,      #--find the end of calendar Q1
str_to_date(Concat(Year(Now()),'-06-30'), '%Y-%m-%d') as EndofCalQ2,      #---find the end of calendar Q2'  
str_to_date(Concat(Year(Now()),'-09-30'), '%Y-%m-%d') as EndOfCalQ3,      #---find the end of calendar Q3'
str_to_date(Concat(Year(Now()),'-12-31'), '%Y-%m-%d') as EndOfCalQ4,      #---find the end of calendar Q4' 

str_to_date(Concat(Year(Now()),'-01-31'), '%Y-%m-%d') as EndOfFQ1,        #---find the end of fiscal Q1'
str_to_date(Concat(Year(Now()),'-04-30'), '%Y-%m-%d') as EndofFQ2,        #---find the end of fiscal Q2' 
str_to_date(Concat(Year(Now()),'-07-31'), '%Y-%m-%d') as EndOfFQ3,        #---find the end of fiscal Q3'
str_to_date(Concat(Year(Now()),'-10-31'), '%Y-%m-%d') as EndOfFQ4         #---find the end of fiscal Q4'
```


##  4. <a name='SQLServer:Convert'></a>SQL Server: Convert
```sql
select
convert(date, Concat(Year(getdate()),'-03-31')) as EndOfCalQ1,
convert(date, Concat(Year(getdate()),'-06-30')) as EndOfCalQ2,
convert(date, Concat(Year(getdate()),'-09-30')) as EndOfCalQ3,
convert(date, Concat(Year(getdate()),'-12-31')) as EndOfCalQ4,

convert(date, Concat(Year(getdate()),'-01-31')) as EndOfFQ1,
convert(date, Concat(Year(getdate()),'-04-30')) as EndOfFQ2,
convert(date, Concat(Year(getdate()),'-07-31')) as EndOfFQ3,
convert(date, Concat(Year(getdate()),'-10-31')) as EndOfFQ4
```

##  5. <a name='SQLServer:Cast'></a>SQL Server: Cast
```
select
cast(Concat(Year(getdate()),'-03-31') as date) as EndOfCalQ1,
cast(Concat(Year(getdate()),'-06-30') as date) as EndOfCalQ2,
cast(Concat(Year(getdate()),'-09-30') as date) as EndOfCalQ3,
cast(Concat(Year(getdate()),'-12-31') as date) as EndOfCalQ4,

cast(Concat(Year(getdate()),'-01-31') as date) as EndOfFQ1,
cast(Concat(Year(getdate()),'-04-30') as date) as EndOfFQ2,
cast(Concat(Year(getdate()),'-07-31') as date) as EndOfFQ3,
cast(Concat(Year(getdate()),'-10-31') as date) as EndOfFQ4
```

##  6. <a name='BigQuery'></a>BigQuery
```sql
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
