
# How do I add hours to the current tumestamp?

<!-- vscode-markdown-toc -->
* 1. [VERTICA](#VERTICA)
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


##  1. <a name='VERTICA'></a>VERTICA

```sql
select
getdate() as ServerTime,
timestampadd('hour', -1, getdate())  as one_hour_ago,
timestampadd('hour', -3, getdate())  as three_hours_ago,
timestampadd('hour', 5,  getdate())  as five_hours_from_now,
timestampadd('hour', 6,  getdate())  as six_hours_from_now,
timestampadd('hour', 7,  getdate())  as seven_hours_from_now
```

##  2. <a name='SQLServer'></a>SQL Server
```sql
select
dateadd(hour, -1, getdate())         as one_hour_ago,
dateadd(hour, -3, getdate())         as three_hours_ago,
dateadd(hour, 5, getdate())          as five_hours_from_now,
dateadd(hour, 6, getdate())          as six_hours_from_now,
dateadd(hour, 7, getdate())          as seven_hours_from_now
```

##  3. <a name='MySQL'></a>MySQL
```sql
select
date_add(Now(), interval -1 hour)    as one_hour_ago,
date_add(Now(), interval -3 hour)    as three_hours_ago,
date_add(Now(), interval 5 hour)     as five_hours_from_now,
date_add(Now(), interval 6 hour)     as six_hours_from_now,
date_add(Now(), interval 7 hour)     as seven_hours_from_now
```

##  4. <a name='PostgreSQL'></a>PostgreSQL
```sql
select
Now() - INTERVAL '1 hour'            as one_hour_ago,
Now() - INTERVAL '3 hour'            as three_hours_ago,
Now() + INTERVAL '5 hour'            as five_hours_from_now,
Now() + INTERVAL '6 hour'            as six_hours_from_now,
Now() + INTERVAL '7 hour'            as seven_hours_from_now
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