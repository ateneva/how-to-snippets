# How do I calculate the remaining days until the end of a calendar quarter?

<!-- vscode-markdown-toc -->
* 1. [Vertica](#Vertica)
* 2. [SQL Server](#SQLServer)
* 3. [MySQL](#MySQL)
* 4. [PostgreSQL](#PostgreSQL)
* 5. [BigQuery](#BigQuery)
* 6. [Redshift](#Redshift)
* 7. [Python](#Python)
* 8. [Tableau](#Tableau)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->


##  1. <a name='Vertica'></a>Vertica
```sql
---calculate remaining days in calendar quarter
SELECT
	QUARTER(NOW()) AS current_calendar_quarter,
	CASE 
		WHEN QUARTER(NOW()) = 1 
			THEN DATEDIFF('DD', DATE(NOW()), 
					TO_DATE(CONCAT(YEAR(NOW()),'-03-31'), 'YYYY-MM-DD')) 
		
		WHEN QUARTER(NOW()) = 2 
			THEN DATEDIFF('DD', DATE(NOW()), 
					TO_DATE(CONCAT(YEAR(NOW()),'-06-30'), 'YYYY-MM-DD')) 
		
		WHEN QUARTER(NOW()) = 3 
			THEN DATEDIFF('DD', DATE(NOW()), 
					TO_DATE(CONCAT(YEAR(NOW()),'-09-30'), 'YYYY-MM-DD')) 
		
		WHEN QUARTER(NOW()) = 4 
			THEN DATEDIFF('DD', DATE(NOW()), 
					TO_DATE(CONCAT(YEAR(NOW()),'-12-31'), 'YYYY-MM-DD')) 
		
	END AS remaining_in_cal_quarter
```	
	
##  2. <a name='SQLServer'></a>SQL Server

```sql
SELECT
	DATEPART(QUARTER, GETDATE()) AS current_calendar_quarter
	CASE 
		WHEN DATEPART(QUARTER, GETDATE() ) = '1'
			THEN DATEDIFF(DAY, GETDATE(), 
					CONVERT(DATE, CONCAT(YEAR(GETDATE()),'-03-31')) ) 
			
		WHEN DATEPART(QUARTER, GETDATE() ) = '2'
			THEN DATEDIFF(DAY, GETDATE(), 
					CONVERT(DATE, CONCAT(YEAR(GETDATE()),'-06-30')) ) 

		WHEN DATEPART(QUARTER, GETDATE() ) = '3'	
			THEN DATEDIFF(DAY, GETDATE(), 
					CONVERT(DATE, CONCAT(YEAR(GETDATE()),'-09-30')) ) 

		WHEN DATEPART(QUARTER, GETDATE() ) = '4'		
			THEN DATEDIFF(DAY, GETDATE(), 
					CONVERT(DATE, CONCAT(YEAR(GETDATE()),'-12-31')) )
			
	END AS remaining_in_cal_quarter
```

##  3. <a name='MySQL'></a>MySQL

```sql
SELECT
	EXTRACT(QUARTER FROM NOW()) AS current_calendar_quarter,
	CASE 
		WHEN EXTRACT(QUARTER FROM NOW()) = '1'
			THEN TIMESTAMPDIFF(DAY, NOW(), 
					STR_TO_DATE(CONCAT(YEAR(NOW()),'-03-31'), '%Y-%M-%D'))
			
		WHEN EXTRACT(QUARTER FROM NOW()) = '2'
			THEN TIMESTAMPDIFF(DAY, NOW(), 
					STR_TO_DATE(CONCAT(YEAR(NOW()),'-06-30'), '%Y-%M-%D'))
			
		WHEN EXTRACT(QUARTER FROM NOW()) = '3'
			THEN TIMESTAMPDIFF(DAY, NOW(), 
					STR_TO_DATE(CONCAT(YEAR(NOW()),'-09-30'), '%Y-%M-%D'))
			
		WHEN EXTRACT(QUARTER FROM NOW()) = '4' 
			THEN TIMESTAMPDIFF(DAY, NOW(), 
					STR_TO_DATE(CONCAT(YEAR(NOW()),'-12-31'), '%Y-%M-%D'))
			
	END AS remaining_in_cal_quarter
```


##  4. <a name='PostgreSQL'></a>PostgreSQL

```sql
SELECT
DATE_PART('QUARTER', NOW()) AS current_calendar_quarter

CASE 
	WHEN DATE_PART('QUARTER', NOW()) = '1' 
		THEN DATE_PART('DAY', 
				TO_DATE(DATE_PART('YEAR', CURRENT_DATE) || '-03-31', 'YYYY-MM-DD') 
				- NOW() ) + 1
	
	WHEN DATE_PART('QUARTER', NOW()) = '2' 
		THEN DATE_PART('DAY', 
				TO_DATE(DATE_PART('YEAR', CURRENT_DATE) || '-06-30', 'YYYY-MM-DD') 
				- NOW() ) + 1 
		
	WHEN DATE_PART('QUARTER', NOW()) = '3' 
		THEN DATE_PART('DAY', 
				TO_DATE(DATE_PART('YEAR', CURRENT_DATE) || '-09-30', 'YYYY-MM-DD') 
				- NOW() ) + 1

	WHEN DATE_PART('QUARTER', NOW()) = '4' 	
		THEN DATE_PART('DAY', 
				TO_DATE(DATE_PART('YEAR', CURRENT_DATE) || '-12-31', 'YYYY-MM-DD') 
				- NOW() ) + 1
		
END AS remaining_in_cal_quarter
```


##  5. <a name='BigQuery'></a>BigQuery
```sql
```

##  6. <a name='Redshift'></a>Redshift
```sql
```


##  7. <a name='Python'></a>Python
```python
```

##  8. <a name='Tableau'></a>Tableau
```
```
