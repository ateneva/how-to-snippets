
# How do I find the first postion of a string?

<!-- TOC -->

- [How do I find the first postion of a string?](#how-do-i-find-the-first-postion-of-a-string)
    - [Sample Sentence](#sample-sentence)
    - [MySQL](#mysql)
    - [PostgreSQL](#postgresql)
    - [SQL Server](#sql-server)
    - [BigQuery](#bigquery)
    - [Redshift](#redshift)
    - [Python](#python)
    - [<a name='Tableau'></a>Tableau](#a-nametableauatableau)

<!-- /TOC -->

## Sample Sentence

```json
[
   {
    "sentence": "The first agreement is to be impeccable with your word.When you are impeccable, you take responsibility for your actions, but you do not judge or blame yourself! Being impeccable with your word is not using the word against yourself.Being impeccable with your word is the correct use of your energy"
   } 
]
```

## MySQL

```sql
SELECT
    INSTR(sentence, 'IMPECCABLE') AS first_pos
FROM phrases
```

## PostgreSQL

```sql
SELECT
    POSITION('IMPECCABLE' IN sentence) AS first_pos
FROM phrases

---add full syntax
```

## SQL Server

```sql
SELECT
    CHARINDEX('IMPECCABLE', sentence) AS first_pos,
    CHARINDEX('IMPECCABLE', sentence, 32) AS second_pos
FROM phrases
```

## BigQuery

```sql
```

## Redshift

```sql
```

## Python

```python
```

## Tableau

```text
```
