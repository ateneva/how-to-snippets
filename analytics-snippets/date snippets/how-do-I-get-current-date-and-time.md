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
SELECT 
    CURRENT_TIMESTAMP          AS CurrentTimestamp,
    CURRENT_DATE               AS CurrentDate,
    CURRENT_TIME               AS CurrentTime,
    GETUTCDATE()               AS UTCDateAndTime,
    getdate()
    NOW()                      AS MyTimeRightNow,
    DATE(NOW())                AS Today,
    TIME(NOW())                AS MyTime
```

##  2. <a name='MySQL'></a>MySQL
```sql
SELECT
    UTC_TIMESTAMP              AS UTCDateAndTime,
    UTC_DATE                   AS UTCDate,
    UTC_TIME                   AS UTCTime,
    CURRENT_TIMESTAMP          AS MyLocalDateAndTime,
    CURRENT_DATE               AS Today,
    CURRENT_TIME               AS MyTimeNow,
    NOW()                      AS MyTimeRightNow,
    DATE(NOW())                AS Today,
    TIME(NOW())                AS MyTime
```


##  3. <a name='MSSQLServer'></a>MS SQL Server
```sql
SELECT
    GETUTCDATE()               AS UTCDATEANDTIME,
    GETDATE()                  AS LOCALSERVERDATEANDTIME,
    CURRENT_TIMESTAMP          AS TODAYDATEANDTIME,
    CONVERT(DATE,GETDATE())    AS TODAY, 
    CONVERT(TIME,GETDATE())    AS NOW 
```


##  4. <a name='PostgreSQL'></a>PostgreSQL
```sql
SELECT 
    CURRENT_TIMESTAMP          AS CurrentTimestamp,
    CURRENT_DATE               AS CurrentDate,
    CURRENT_TIME               AS CurrentTime,
    NOW()                      AS MyTimeRightNow
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