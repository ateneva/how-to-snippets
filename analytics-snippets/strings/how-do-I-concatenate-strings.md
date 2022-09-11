
# How do I concatenate strings?

<!-- vscode-markdown-toc -->
* 1. [MySQL](#MySQL)
* 2. [SQL Server](#SQLServer)
* 3. [PostgreSQL](#PostgreSQL)
* 4. [Vertica](#Vertica)
* 5. [BigQuery](#BigQuery)
* 6. [Redshift](#Redshift)
* 7. [Python](#Python)
* 8. [Tableau](#Tableau)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

##  1. <a name='MySQL'></a>MySQL
```sql
SELECT
    CONCAT('2017','-FEB')               AS two_strings,
    CONCAT('2017','-','FEB')            AS multiple_strings
```

##  2. <a name='SQLServer'></a>SQL Server
```sql
SELECT
    CONCAT('2017','-FEB')                AS two_strings,
    Concat('2017','-','Feb')             as multiple_strings
```

##  3. <a name='PostgreSQL'></a>PostgreSQL

```sql
SELECT
    '2017' || '-FEB'                     AS two_strings,
    '2017' || '-' || 'FEB'               AS multiple_strings
```

##  4. <a name='Vertica'></a>Vertica
```sql
SELECT
    --concat in vertica is only applicable to two strings
    CONCAT('2017','-FEB')                 AS two_strings
    CONCAT('2017',CONCAT('-', 'FEB'))     AS multiple_strings
    '2017' || '-' || 'FEB'                AS multiple_strings
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