
# How can I compare values?

<!-- vscode-markdown-toc -->
* 1. [Vertica](#Vertica)
* 2. [MySQL](#MySQL)
* 3. [PostgreSQL](#PostgreSQL)
* 4. [SQL Server](#SQLServer)
* 5. [BigQuery](#BigQuery)
* 6. [Reshift](#Reshift)
* 7. [Python](#Python)
* 8. [Tableau](#Tableau)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

<!-- markdownlint-disable MD033 -->

## 1. <a name='Vertica'></a>Vertica

```sql
    SELECT
        GREATEST(5.5, 8.2, -8.2)  AS highest_value,
        LEAST(5.5, 8.2, -8.2)     AS lowest_value
```

## 2. <a name='MySQL'></a>MySQL

```sql
    SELECT
        GREATEST(5.5, 8.2, -8.2)  AS highest_value, 
        LEAST(5.5, 8.2, -8.2)     AS lowest_value
```

## 3. <a name='PostgreSQL'></a>PostgreSQL

```sql
    SELECT
        GREATEST(5.5, 8.2, -8.2)  AS highest_value, 
        LEAST(5.5, 8.2, -8.2)     AS lowest_value
```

## 4. <a name='SQLServer'></a>SQL Server

```sql
    SELECT
        MAX(MyValue)              AS highest_value,
        MIN(MyValue)              AS lowest_value
        FROM (values (5.5), (8.2), (-8.2)) AS a(MyValue)
```

## 5. <a name='BigQuery'></a>BigQuery

```sql
```

## 6. <a name='Reshift'></a>Reshift

```sql
```

## 7. <a name='Python'></a>Python

```python
```

## 8. <a name='Tableau'></a>Tableau

```text
```
