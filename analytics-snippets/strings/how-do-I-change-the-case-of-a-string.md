
# How do I change the case of a string?

```json
[
    {
        "title": "Academy Dinosaur"
    },
    {
        "title": "Agent Truman"
    },
    {
        "title": "When Harry met Sally"
    }
]
```

<!-- vscode-markdown-toc -->
* 1. [SQL Server](#SQLServer)
* 2. [MySQL](#MySQL)
* 3. [PostgreSQL](#PostgreSQL)
* 4. [Bigquery](#Bigquery)
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
    TITLE,
    LOWER(TITLE) AS lowercase_string,
    UPPER(TITLE) AS uppercase_string
    ---add proper case
FROM datageeking.dbo.films
```

## 2. <a name='MySQL'></a>MySQL

```sql
SELECT
    TITLE,
    LOWER(TITLE) AS lowercase_string,
    UPPER(TITLE) AS uppercase_string,

    LCASE(TITLE) AS lowercase_string,
    UCASE(TITLE) AS uppercase_string
    --add proper case
FROM sakila.film
```

## 3. <a name='PostgreSQL'></a>PostgreSQL

```sql
SELECT
    TITLE,
    LOWER(TITLE) AS lowercase_string,
    UPPER(TITLE) AS uppercase_string
    --add proper case
FROM public.film
```

## 4. <a name='Bigquery'></a>Bigquery

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
