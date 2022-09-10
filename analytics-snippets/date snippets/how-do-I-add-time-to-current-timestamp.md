
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
SELECT
    GETDATE() AS SERVERTIME,
    TIMESTAMPADD('HOUR', -1, GETDATE())  AS one_hour_ago,
    TIMESTAMPADD('HOUR', -3, GETDATE())  AS three_hours_ago,
    TIMESTAMPADD('HOUR', 5,  GETDATE())  AS five_hours_from_now,
    TIMESTAMPADD('HOUR', 6,  GETDATE())  AS six_hours_from_now,
    TIMESTAMPADD('HOUR', 7,  GETDATE())  AS seven_hours_from_now
```

##  2. <a name='SQLServer'></a>SQL Server
```sql
SELECT
    DATEADD(HOUR, -1, GETDATE())         AS one_hour_ago,
    DATEADD(HOUR, -3, GETDATE())         AS three_hours_ago,
    DATEADD(HOUR, 5, GETDATE())          AS five_hours_from_now,
    DATEADD(HOUR, 6, GETDATE())          AS six_hours_from_now,
    DATEADD(HOUR, 7, GETDATE())          AS seven_hours_from_now
```

##  3. <a name='MySQL'></a>MySQL
```sql
SELECT
    DATE_ADD(NOW(), INTERVAL -1 HOUR)    AS one_hour_ago,
    DATE_ADD(NOW(), INTERVAL -3 HOUR)    AS three_hours_ago,
    DATE_ADD(NOW(), INTERVAL 5 HOUR)     AS five_hours_from_now,
    DATE_ADD(NOW(), INTERVAL 6 HOUR)     AS six_hours_from_now,
    DATE_ADD(NOW(), INTERVAL 7 HOUR)     AS seven_hours_from_now
```

##  4. <a name='PostgreSQL'></a>PostgreSQL
```sql
SELECT
    NOW() - INTERVAL '1 HOUR'            AS one_hour_ago,
    NOW() - INTERVAL '3 HOUR'            AS three_hours_ago,
    NOW() + INTERVAL '5 HOUR'            AS five_hours_from_now,
    NOW() + INTERVAL '6 HOUR'            AS six_hours_from_now,
    NOW() + INTERVAL '7 HOUR'            AS seven_hours_from_now
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