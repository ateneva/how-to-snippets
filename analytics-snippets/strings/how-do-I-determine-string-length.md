
# How do I determine string length?

<!-- vscode-markdown-toc -->
* 1. [SQL Server](#SQLServer)
* 2. [MySQL](#MySQL)
* 3. [PostgreSQL](#PostgreSQL)
* 4. [BigQuery](#BigQuery)
* 5. [Redshift](#Redshift)
* 6. [Python](#Python)
* 7. [Tableau](#Tableau)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

<!-- markdownlint-disable MD033 -->

## 1. <a name='SQLServer'></a>SQL Server

```sql
SELECT
    'I LOVE YOU'                AS phrase,
    LEN('I LOVE YOU')           AS phrase_length,
    LEN(' I LOVE YOU ')         AS phrase_length2,
    DATALENGTH(' I LOVE YOU ')  AS phrase_length3

--unlike len, datalength counts all leading and trailing spaces
```

## 2. <a name='MySQL'></a>MySQL

```sql
SELECT
    'I LOVE YOU'            AS phrase,
    LENGTH('I LOVE YOU')    AS phrase_length
```

## 3. <a name='PostgreSQL'></a>PostgreSQL

```sql
SELECT
    'I LOVE YOU'            AS phrase,
    LENGTH('I LOVE YOU')    AS phrase_length
```

## 4. <a name='BigQuery'></a>BigQuery

```sql
```

## 5. <a name='Redshift'></a>Redshift

```sql
```

## 6. <a name='Python'></a>Python

```python
```

## 7. <a name='Tableau'></a>Tableau

```text
```
