
# How do I calculate the remaining days until the end of a fiscal quarter?

## Vertica

```sql
---calculate remaining days in fiscal quarter
SELECT
    CASE 
        WHEN MONTH(NOW()) IN (11,12,1) THEN 'FQ1'
        WHEN MONTH(NOW()) IN (2,3,4) THEN 'FQ2'
        WHEN MONTH(NOW()) IN (5,6,7) THEN 'FQ3'
        WHEN MONTH(NOW()) IN (8,9,10) THEN 'FQ4'
    END AS current_fiscal_quarter,

    CASE 
        WHEN MONTH(NOW()) IN (11,12,1) 
        THEN DATEDIFF('DD', DATE(NOW()), 
                TO_DATE(CONCAT(YEAR(NOW()),'-01-31'), 'YYYY-MM-DD')) 
        
        WHEN MONTH(NOW()) IN (2,3,4) 
        THEN DATEDIFF('DD', DATE(NOW()), 
                TO_DATE(CONCAT(YEAR(NOW()),'-04-30'), 'YYYY-MM-DD')) 
        
        WHEN MONTH(NOW()) IN (5,6,7) 
        THEN DATEDIFF('DD', DATE(NOW()), 
                TO_DATE(CONCAT(YEAR(NOW()),'-07-31'), 'YYYY-MM-DD')) 
        
        WHEN MONTH(NOW()) IN (8,9,10) 
        THEN DATEDIFF('DD', DATE(NOW()), 
                TO_DATE(CONCAT(YEAR(NOW()),'-10-31'), 'YYYY-MM-DD')) 
    END AS remaining_days_in_quarter
```

## SQL Server

```sql
SELECT
    CASE 
        WHEN MONTH(GETDATE()) IN (11,12,1) THEN 'FQ1'
        WHEN MONTH(GETDATE()) IN (2,3,4) THEN 'FQ2'
        WHEN MONTH(GETDATE()) IN (5,6,7) THEN 'FQ3'
        WHEN MONTH(GETDATE()) IN (8,9,10) THEN 'FQ4'
    END AS current_fiscal_quarter,

    CASE 
        WHEN MONTH(GETDATE()) IN (11,12,1)
        THEN DATEDIFF(DAY, GETDATE(), 
                CONVERT(DATE, CONCAT(YEAR(GETDATE())+1,'-01-31')) ) 
        
        WHEN MONTH(GETDATE()) IN (2,3,4)
        THEN DATEDIFF(DAY, GETDATE(), 
                CONVERT(DATE, CONCAT(YEAR(GETDATE()),'-04-30')) ) 

        WHEN MONTH(GETDATE()) IN (5,6,7)
        THEN DATEDIFF(DAY, GETDATE(), 
                CONVERT(DATE, CONCAT(YEAR(GETDATE()),'-07-31')) ) 

        WHEN MONTH(GETDATE()) IN (8,9,10) 
        THEN DATEDIFF(DAY, GETDATE(), 
                CONVERT(DATE, CONCAT(YEAR(GETDATE()),'-10-31')) )
    END AS remaining_days_in_quarter
  
```

## MySQL

```sql
SELECT  
    CASE 
        WHEN MONTH(NOW()) IN (11,12,1) THEN 'FQ1'
        WHEN MONTH(NOW()) IN (2,3,4) THEN 'FQ2'
        WHEN MONTH(NOW()) IN (5,6,7) THEN 'FQ3'
        WHEN MONTH(NOW()) IN (8,9,10) THEN 'FQ4'
    END AS current_fiscal_quarter,

    CASE 
        WHEN MONTH(NOW()) IN (11,12,1)
        THEN TIMESTAMPDIFF(DAY, NOW(),
            STR_TO_DATE(CONCAT(YEAR(NOW())+1,'-01-31'), '%Y-%M-%D') ) 
        
        WHEN MONTH(NOW()) IN (2,3,4)
        THEN TIMESTAMPDIFF(DAY, NOW(), 
            STR_TO_DATE(CONCAT(YEAR(NOW()),'-04-30'), '%Y-%M-%D') ) 

        WHEN MONTH(NOW()) IN (5,6,7)
        THEN TIMESTAMPDIFF(DAY, NOW(), 
            STR_TO_DATE(CONCAT(YEAR(NOW()),'-07-31'), '%Y-%M-%D') ) 

        WHEN MONTH(NOW()) IN (8,9,10) 
        THEN TIMESTAMPDIFF(DAY, NOW(), 
            STR_TO_DATE(CONCAT(YEAR(NOW()),'-10-31'), '%Y-%M-%D') )
    
    END AS remaining_in_fis_quarter
 ```

## PostgreSQL

 ```sql
 SELECT
    CASE 
        WHEN DATE_PART('MONTH', NOW()) IN (11,12,1) THEN 'FQ1'
        WHEN DATE_PART('MONTH', NOW()) IN (2,3,4) THEN 'FQ2'
        WHEN DATE_PART('MONTH', NOW()) IN (5,6,7) THEN 'FQ3'
        WHEN DATE_PART('MONTH', NOW()) IN (8,9,10) THEN 'FQ4'
    END AS current_fiscal_quarter,

    CASE 
        WHEN DATE_PART('MONTH', NOW()) IN (11,12,1)
        THEN DATE_PART('DAY', 
            TO_DATE(DATE_PART('YEAR', CURRENT_DATE)+1 || '-01-31', 'YYYY-MM-DD') - NOW() ) + 1
        
        WHEN DATE_PART('MONTH', NOW()) IN (2,3,4)
        THEN DATE_PART('DAY', 
            TO_DATE(DATE_PART('YEAR', CURRENT_DATE) || '-04-30', 'YYYY-MM-DD') - NOW() ) + 1 
        
        WHEN DATE_PART('MONTH', NOW()) IN (5,6,7) 
        THEN DATE_PART('DAY', 
            TO_DATE(DATE_PART('YEAR', CURRENT_DATE) || '-07-31', 'YYYY-MM-DD') - NOW() ) + 1

        WHEN DATE_PART('MONTH', NOW()) IN (8,9,10) 
        THEN DATE_PART('DAY', 
            TO_DATE(DATE_PART('YEAR', CURRENT_DATE) || '-10-31', 'YYYY-MM-DD') - NOW() ) + 1
    END AS remaining_in_fis_quarter
```

## Bigquery

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
