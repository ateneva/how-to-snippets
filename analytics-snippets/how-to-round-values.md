
# How can I round numbers?

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
        CEILING(285.32)     AS ceiling,
        FLOOR(285.82)       AS floor,
        
        285.253             AS number1,
        ROUND(285.253,0)    AS round_less_5_to_0,
        ROUND(285.253,1)    AS round_less_5_to_1,
        ROUND(285.253,2)    AS round_less_5_to_2,
        
        285.753             AS number2,
        ROUND(285.753,0)    AS round_more_5_to_0,
        ROUND(285.753,1)    AS round_more_5_to_1,
        ROUND(285.753,2)    AS round_more_5_to_2
```

## 2. <a name='MySQL'></a>MySQL

```sql
    SELECT
        CEILING(285.32)     AS ceiling,
        FLOOR(285.82)       AS floor,
        
        285.253             AS number1,
        ROUND(285.253,0)    AS round_less_5_to_0,
        ROUND(285.253,1)    AS round_less_5_to_1,
        ROUND(285.253,2)    AS round_less_5_to_2,
        
        285.753             AS number2,
        ROUND(285.753,0)    AS round_more_5_to_0,
        ROUND(285.753,1)    AS round_more_5_to_1,
        ROUND(285.753,2)    AS round_more_5_to_2
```

## 3. <a name='PostgreSQL'></a>PostgreSQL

```sql
    SELECT
        CEILING(285.32)     AS ceiling,
        FLOOR(285.82)       AS floor,
        
        285.253             AS number1,
        ROUND(285.253,0)    AS round_less_5_to_0,
        ROUND(285.253,1)    AS round_less_5_to_1,
        ROUND(285.253,2)    AS round_less_5_to_2,
        
        285.753             AS number2,
        ROUND(285.753,0)    AS round_more_5_to_0,
        ROUND(285.753,1)    AS round_more_5_to_1,
        ROUND(285.753,2)    AS round_more_5_to_2
```

## 4. <a name='SQLServer'></a>SQL Server

```sql
    SELECT
        CEILING(285.32)     AS ceiling,
        FLOOR(285.82)       AS floor,
        
        285.253             AS number1,
        ROUND(285.253,0)    AS round_less_5_to_0,
        ROUND(285.253,1)    AS round_less_5_to_1,
        ROUND(285.253,2)    AS round_less_5_to_2,
        
        285.753             AS number2,
        ROUND(285.753,0)    AS round_more_5_to_0,
        ROUND(285.753,1)    AS round_more_5_to_1,
        ROUND(285.753,2)    AS round_more_5_to_2
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
