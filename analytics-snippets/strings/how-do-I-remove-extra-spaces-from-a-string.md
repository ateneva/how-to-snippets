
# How do I remove extra spaces from a string?

<!-- vscode-markdown-toc -->
* 1. [Vertica](#Vertica)
* 2. [MySQL](#MySQL)
* 3. [PostgreSQL](#PostgreSQL)
* 4. [SQL Server](#SQLServer)
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
SELECT
    REPLACE('WE LOVE YOU', 'WE', 'I'), 
                    '     I LOVE YOU   ' AS my_phrase,
    LTRIM('     I LOVE YOU   ')          AS before_ltrim,      
    RTRIM('     I LOVE YOU   ')          AS before_rtrim,      
    TRIM('  I LOVE YOU ')                AS before_trim             
```

##  2. <a name='MySQL'></a>MySQL

```sql
SELECT
    REPLACE('I LOVE YOU', 'I', 'WE')     AS replace_,
    LENGTH('I LOVE YOU ')                AS before_rtrim,
    RTRIM('I LOVE YOU ')                 AS rtrim_,
    LENGTH(RTRIM('I LOVE YOU '))         AS after_rtrim,

    LENGTH(' I LOVE YOU')                AS before_ltrim,
    LTRIM(' I LOVE YOU')                 AS Ltrim_,
    LENGTH(LTRIM(' I LOVE YOU'))         AS after_ltrim,

    TRIM(' I LOVE YOU  ')                AS trim_,
    LENGTH(TRIM(' I LOVE YOU  '))        AS after_trim
```



##  3. <a name='PostgreSQL'></a>PostgreSQL
```sql
SELECT
    REPLACE('I LOVE YOU', 'I', 'WE'),
    LENGTH('I LOVE YOU ')                AS before_rtrim,
    RTRIM('I LOVE YOU ')                 AS rtrim_,
    LENGTH(RTRIM('I LOVE YOU '))         AS after_rtrim,

    LENGTH(' I LOVE YOU')                AS before_ltrim,
    LTRIM(' I LOVE YOU')                 AS ltrim_,
    LENGTH(LTRIM(' I LOVE YOU'))         AS after_ltrim,

    TRIM(' I LOVE YOU  ')                AS trim_,
    LENGTH(TRIM(' I LOVE YOU  '))        AS after_trim
```

##  4. <a name='SQLServer'></a>SQL Server

```sql
SELECT
    REPLACE('I LOVE YOU', 'I', 'WE')     AS replace_,

    DATALENGTH('I LOVE YOU ')            AS before_rtrim,
    RTRIM('I LOVE YOU ')                 AS rtrim_,
    DATALENGTH(RTRIM('I LOVE YOU '))     AS after_rtrim,

    DATALENGTH(' I LOVE YOU')            AS before_ltrim,
    LTRIM(' I LOVE YOU')                 AS ltrim_,
    DATALENGTH(LTRIM(' I LOVE YOU'))     AS after_ltrim
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