
# How do I find the first postion of a string?

```json
[
   {
    "sentence": "The first agreement is to be impeccable with your word.When you are impeccable, you take responsibility for your actions, but you do not judge or blame yourself! Being impeccable with your word is not using the word against yourself.Being impeccable with your word is the correct use of your energy"
   } 
]
```

<!-- vscode-markdown-toc -->
* 1. [MySQL](#MySQL)
* 2. [PostgreSQL](#PostgreSQL)
* 3. [SQL Server](#SQLServer)
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

## 1. <a name='MySQL'></a>MySQL

```sql
SELECT
    INSTR(sentence, 'IMPECCABLE') AS first_pos
FROM phrases
```

## 2. <a name='PostgreSQL'></a>PostgreSQL

```sql
SELECT
    POSITION('IMPECCABLE' IN sentence) AS first_pos
FROM phrases

---add full syntax
```

## 3. <a name='SQLServer'></a>SQL Server

```sql
SELECT
    CHARINDEX('IMPECCABLE', sentence) AS first_pos,
    CHARINDEX('IMPECCABLE', sentence, 32) AS second_pos
FROM phrases
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
