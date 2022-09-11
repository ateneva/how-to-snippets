
# How do I extract part of a string from another?

<!-- vscode-markdown-toc -->
* 1. [SQL Server](#SQLServer)
* 2. [PostgreSQL](#PostgreSQL)
* 3. [MySQL](#MySQL)
* 4. [Bigquery](#Bigquery)
* 5. [Redshift](#Redshift)
* 6. [Python](#Python)
* 7. [Tableau](#Tableau)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

##  1. <a name='SQL Server'></a>SQL Server

```sql
SELECT
    ---simple phrase---
    'I LOVE YOU'                    AS phrase,

    LEFT ('I LOVE YOU', 1)          AS left_,
    RIGHT('I LOVE YOU', 3)          AS right_,
    RIGHT(LEFT('I LOVE YOU', 6),4)  AS mid_
    --sql server does not support MID function,

    SUBSTRING('I LOVE YOU', 3,4)    AS substring_fixed,

    --longer, more complex phrase but pattermn obvious

```

##  2. <a name='PostgreSQL'></a>PostgreSQL

```sql
SELECT
    ---simple phrase---
    'I LOVE YOU'                    AS phrase,

    LEFT ('I LOVE YOU', 1)          AS left_,
    RIGHT('I LOVE YOU', 3)          AS right_,
    RIGHT(LEFT('I LOVE YOU', 6),4)  AS mid_,
    --postgresql does not support mid function,

    SUBSTRING('I LOVE YOU', 3,4)    AS substring_fixed,
    SUBSTR('I LOVE YOU', 3,4)       AS substr_fixed

    --longer, more complex phrase but pattermn obvious
```

##  3. <a name='MySQL'></a>MySQL

```sql
SELECT
    ---simple phrase---
    'I LOVE YOU'                    AS phrase,

    LEFT ('I LOVE YOU', 1)          AS left_,
    RIGHT('I LOVE YOU', 3)          AS right_,
    MID('I LOVE YOU', 3, 4)         AS mid_,

    SUBSTRING('I LOVE YOU', 3, 4)   AS substring_fixed,
    SUBSTR('I LOVE YOU.', 3, 4)     AS substr_fixed,

    --longer, more complex phrase but pattern obvious

```

##  4. <a name='Bigquery'></a>Bigquery
```sql
```


##  5. <a name='Redshift'></a>Redshift
```sql
```

##  6. <a name='Python'></a>Python
```python
```

##  7. <a name='Tableau'></a>Tableau
```
```
