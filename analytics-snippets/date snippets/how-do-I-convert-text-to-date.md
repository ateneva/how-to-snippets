
# How do I convert string to a date?

<!-- vscode-markdown-toc -->
* 1. [VERTICA](#VERTICA)
* 2. [PostgreSQL](#PostgreSQL)
* 3. [MySQL](#MySQL)
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


##  1. <a name='VERTICA'></a>VERTICA
```sql
SELECT
'2017-03-31'                          as text_field,
TO_DATE('2017-03-31', 'YYYY-MM-DD')   as date_field
```

##  2. <a name='PostgreSQL'></a>PostgreSQL
```sql
SELECT
'2017-03-31'                          as text_field,
TO_DATE('2017-03-31', 'YYYY-MM-DD')   as date_field
```

##  3. <a name='MySQL'></a>MySQL
```sql
SELECT
'2017-03-31'                          as text_field,
STR_TO_DATE('2017-03-31', '%Y-%m-%d') as date_field
```


##  4. <a name='SQLServer'></a>SQL Server
```sql
SELECT
'2017-03-31'                          as text_field,
CONVERT(date, '2017-03-31')           as date_field1,
CAST('2017-03-31' as date)            as date_field2
```


##  5. <a name='BigQuery'></a>BigQuery
```sql
SELECT
CURRENT_DATE() AS NOW,
PARSE_DATE("%Y/%m/%d", "2012/12/21") AS THE_DATE,

FORMAT_DATE("%Y-%b-%d",
    PARSE_DATE("%Y/%m/%d", "2012/12/21")) AS THE_DATE_FORMATTED
```
```json
[
  {
    "NOW": "2020-11-08",
    "THE_DATE": "2012-12-21",
    "THE_DATE_FORMATTED": "2012-Dec-21"
  }
]
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