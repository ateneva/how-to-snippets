
# How do I find the end of a quarter?

## Vertica

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

## PostgreSQL

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

## MySQL

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

## SQL Server: Convert

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

## SQL Server: Cast

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
