
# How do I find the end of a quarter?

<!-- vscode-markdown-toc -->
* 1. [Vertica](#Vertica)
* 2. [PostgreSQL](#PostgreSQL)
* 3. [MySQL](#MySQL)
* 4. [SQL Server: Convert](#SQLServer:Convert)
* 5. [SQL Server: Cast](#SQLServer:Cast)
* 6. [BigQuery](#BigQuery)
* 7. [Redshift](#Redshift)
* 8. [Python](#Python)
* 9. [Tableau](#Tableau)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

<!-- markdownlint-disable MD033 -->
## 1. <a name='Vertica'></a>Vertica

```sql
SELECT
    TO_DATE(CONCAT(YEAR(NOW()),'-03-31'), 'YYYY-MM-DD') AS end_of_cal_q1,
    TO_DATE(CONCAT(YEAR(NOW()),'-06-30'), 'YYYY-MM-DD') AS end_of_cal_q2,
    TO_DATE(CONCAT(YEAR(NOW()),'-09-30'), 'YYYY-MM-DD') AS end_of_cal_q3,
    TO_DATE(CONCAT(YEAR(NOW()),'-12-31'), 'YYYY-MM-DD') AS end_of_cal_q4,

    TO_DATE(CONCAT(YEAR(NOW()),'-01-31'), 'YYYY-MM-DD') AS end_of_fq1,
    TO_DATE(CONCAT(YEAR(NOW()),'-04-30'), 'YYYY-MM-DD') AS end_of_fq2,
    TO_DATE(CONCAT(YEAR(NOW()),'-07-31'), 'YYYY-MM-DD') AS end_of_fq3,
    TO_DATE(CONCAT(YEAR(NOW()),'-10-31'), 'YYYY-MM-DD') AS end_of_fq4
```

## 2. <a name='PostgreSQL'></a>PostgreSQL

```sql
SELECT
    TO_DATE(DATE_PART('YEAR', CURRENT_DATE) || '-03-31', 'YYYY-MM-DD') AS end_of_cal_q1,
    TO_DATE(DATE_PART('YEAR', CURRENT_DATE) || '-06-30', 'YYYY-MM-DD') AS end_of_cal_q2,
    TO_DATE(DATE_PART('YEAR', CURRENT_DATE) || '-09-30', 'YYYY-MM-DD') AS end_of_cal_q3,
    TO_DATE(DATE_PART('YEAR', CURRENT_DATE) || '-12-31', 'YYYY-MM-DD') AS end_of_cal_q4,

    TO_DATE(DATE_PART('YEAR', CURRENT_DATE) || '-01-31', 'YYYY-MM-DD') AS end_of_fq1,
    TO_DATE(DATE_PART('YEAR', CURRENT_DATE) || '-04-30', 'YYYY-MM-DD') AS end_of_fq2,
    TO_DATE(DATE_PART('YEAR', CURRENT_DATE) || '-07-31', 'YYYY-MM-DD') AS end_of_fq3,
    TO_DATE(DATE_PART('YEAR', CURRENT_DATE) || '-10-31', 'YYYY-MM-DD') AS end_of_fq4
```

## 3. <a name='MySQL'></a>MySQL

```sql
SELECT
    STR_TO_DATE(CONCAT(YEAR(NOW()),'-03-31'), '%Y-%M-%D') AS end_of_cal_q1,
    STR_TO_DATE(CONCAT(YEAR(NOW()),'-06-30'), '%Y-%M-%D') AS end_of_cal_q2, 
    STR_TO_DATE(CONCAT(YEAR(NOW()),'-09-30'), '%Y-%M-%D') AS end_of_cal_q3,
    STR_TO_DATE(CONCAT(YEAR(NOW()),'-12-31'), '%Y-%M-%D') AS end_of_cal_q4, 

    STR_TO_DATE(CONCAT(YEAR(NOW()),'-01-31'), '%Y-%M-%D') AS end_of_fq1,
    STR_TO_DATE(CONCAT(YEAR(NOW()),'-04-30'), '%Y-%M-%D') AS end_of_fq2,
    STR_TO_DATE(CONCAT(YEAR(NOW()),'-07-31'), '%Y-%M-%D') AS end_of_fq3,
    STR_TO_DATE(CONCAT(YEAR(NOW()),'-10-31'), '%Y-%M-%D') AS end_of_fq4
```

## 4. <a name='SQLServer:Convert'></a>SQL Server: Convert

```sql
SELECT
    CONVERT(DATE, CONCAT(YEAR(GETDATE()),'-03-31')) AS end_of_cal_q1,
    CONVERT(DATE, CONCAT(YEAR(GETDATE()),'-06-30')) AS end_of_cal_q2,
    CONVERT(DATE, CONCAT(YEAR(GETDATE()),'-09-30')) AS end_of_cal_q3,
    CONVERT(DATE, CONCAT(YEAR(GETDATE()),'-12-31')) AS end_of_cal_q4,

    CONVERT(DATE, CONCAT(YEAR(GETDATE()),'-01-31')) AS end_of_fq1,
    CONVERT(DATE, CONCAT(YEAR(GETDATE()),'-04-30')) AS end_of_fq2,
    CONVERT(DATE, CONCAT(YEAR(GETDATE()),'-07-31')) AS end_of_fq3,
    CONVERT(DATE, CONCAT(YEAR(GETDATE()),'-10-31')) AS end_of_fq4
```

## 5. <a name='SQLServer:Cast'></a>SQL Server: Cast

```sql
SELECT
    CAST(CONCAT(YEAR(GETDATE()),'-03-31') AS DATE) AS end_of_cal_q1,
    CAST(CONCAT(YEAR(GETDATE()),'-06-30') AS DATE) AS end_of_cal_q2,
    CAST(CONCAT(YEAR(GETDATE()),'-09-30') AS DATE) AS end_of_cal_q3,
    CAST(CONCAT(YEAR(GETDATE()),'-12-31') AS DATE) AS end_of_cal_q4,

    CAST(CONCAT(YEAR(GETDATE()),'-01-31') AS DATE) AS end_of_fq1,
    CAST(CONCAT(YEAR(GETDATE()),'-04-30') AS DATE) AS end_of_fq2,
    CAST(CONCAT(YEAR(GETDATE()),'-07-31') AS DATE) AS end_of_fq3,
    CAST(CONCAT(YEAR(GETDATE()),'-10-31') AS DATE) AS end_of_fq4
```

## 6. <a name='BigQuery'></a>BigQuery

```sql
```

## 7. <a name='Redshift'></a>Redshift

```sql
```

## 8. <a name='Python'></a>Python

```python
```

## 9. <a name='Tableau'></a>Tableau

```text
```
