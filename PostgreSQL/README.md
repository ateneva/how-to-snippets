
# PostgreSQL functions and syntax

<!-- vscode-markdown-toc -->
* 1. [DATETIME functions](#DATETIMEfunctions)
  * 1.1. [PostgreSQL: convert text to date](#PostgreSQL:converttexttodate)
  * 1.2. [PostgreSQL: DATE additions](#PostgreSQL:DATEadditions)
  * 1.3. [PostgreSQL: DATE_PART](#PostgreSQL:DATE_PART)
  * 1.4. [PostgreSQL: EXTRACTs](#PostgreSQL:EXTRACTs)
  * 1.5. [PostgreSQL: find the first day of](#PostgreSQL:findthefirstdayof)
  * 1.6. [PostgreSQL: find the lASt day of](#PostgreSQL:findthelAStdayof)
  * 1.7. [PostgreSQL: find exact period between two dates](#PostgreSQL:findexactperiodbetweentwodates)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

<!-- markdownlint-disable MD033 -->

## 1. <a name='DATETIMEfunctions'></a>DATETIME functions

* convert string to date
* add INTERVALs to a date
* `DATE_PART(INTERVAL, timestamp)`
* `EXTRACT(INTERVAL FROM timestamp)`
* `DATE_TRUNC(INTERVAL, date/timestamp)`
* find the difference between two timestamps

### 1.1. <a name='PostgreSQL:converttexttodate'></a>PostgreSQL: convert text to date

```sql
SELECT
    '2017-03-31'                          AS text_field,
    TO_DATE('2017-03-31', 'YYYY-MM-DD')   AS date_field
```

### 1.2. <a name='PostgreSQL:DATEadditions'></a>PostgreSQL: DATE additions

```sql
SELECT
    NOW() - INTERVAL '1 year'    AS one_year_ago,
    NOW() - INTERVAL '1 month'   AS one_month_ago,
    NOW() - INTERVAL '1 week'    AS one_week_ago,
    NOW() - INTERVAL '1 day'     AS one_day_ago,
    NOW() - INTERVAL '1 hour'    AS one_hour_ago
```

or

```sql
SELECT
    NOW() + INTERVAL '1 year'    AS one_year_from_now,
    NOW() + INTERVAL '1 month'   AS one_month_from_now,
    NOW() + INTERVAL '1 week'    AS one_week_from_now,
    NOW() + INTERVAL '1 day'     AS one_day_from_now,
    NOW() + INTERVAL '1 hour'    AS one_hour_from_now
```

### 1.3. <a name='PostgreSQL:DATE_PART'></a>PostgreSQL: DATE_PART

```sql
SELECT
    CURRENT_TIMESTAMP,

    ----find current century
    DATE_PART('century', CURRENT_TIMESTAMP)         AS century,                 
    DATE_PART('decade', CURRENT_TIMESTAMP)          AS decade,
    DATE_PART('doy', CURRENT_TIMESTAMP)             AS day_of_year,

    ----find day of current week (0 to 6)
    DATE_PART('dow', CURRENT_TIMESTAMP)             AS day_of_week,
    DATE_PART('isoyear', CURRENT_TIMESTAMP)         AS iso_year,
    DATE_PART('year', CURRENT_TIMESTAMP)            AS current_year,
    DATE_PART('quarter', CURRENT_TIMESTAMP)         AS current_quarter,
    DATE_PART('month', CURRENT_TIMESTAMP)           AS current_month,
    DATE_PART('day', CURRENT_TIMESTAMP)             AS current_day,
    DATE_PART('hour', CURRENT_TIMESTAMP)            AS current_hour
```

### 1.4. <a name='PostgreSQL:EXTRACTs'></a>PostgreSQL: EXTRACTs

```sql
SELECT
    CURRENT_TIMESTAMP,
    EXTRACT(century FROM CURRENT_TIMESTAMP)         AS century,
    EXTRACT(decade FROM CURRENT_TIMESTAMP)          AS decade,
    EXTRACT(doy FROM CURRENT_TIMESTAMP)             AS day_of_year,
    EXTRACT(dow FROM CURRENT_TIMESTAMP)             AS day_of_week,
    EXTRACT(isoyear FROM CURRENT_TIMESTAMP)         AS iso_year,
    EXTRACT(year FROM CURRENT_TIMESTAMP)            AS current_year,
    EXTRACT(quarter FROM CURRENT_TIMESTAMP)         AS current_quarter,
    EXTRACT(month FROM CURRENT_TIMESTAMP)           AS current_month,
    EXTRACT(day FROM CURRENT_TIMESTAMP)             AS current_day,
    EXTRACT(hour FROM CURRENT_TIMESTAMP)            AS current_hour
```

### 1.5. <a name='PostgreSQL:findthefirstdayof'></a>PostgreSQL: find the first day of

```sql
SELECT
    DATE(DATE_TRUNC('week', NOW()))  AS first_day_of_current_week,
    DATE(DATE_TRUNC('month', NOW())) AS first_day_of_current_month,
    DATE(DATE_TRUNC('year', NOW()))  AS first_day_of_current_year
```

### 1.6. <a name='PostgreSQL:findthelAStdayof'></a>PostgreSQL: find the lASt day of

```sql
SELECT
    DATE(NOW()) AS Today,
    DATE(DATE_TRUNC('month', NOW() 
            + INTERVAL '0 month') - INTERVAL '1 day')  AS last_day_previous_month,
    
    DATE(DATE_TRUNC('month', NOW() 
            + INTERVAL '1 month') - INTERVAL '1 day')  AS last_day_this_month,
    
    DATE(DATE_TRUNC('month', NOW() 
            + INTERVAL '2 month') - INTERVAL '1 day')  AS last_day_next_month
```

### 1.7. <a name='PostgreSQL:findexactperiodbetweentwodates'></a>PostgreSQL: find exact period between two dates

```sql
SELECT
    age(NOW(), '1988-06-21') AS years_between_dates
```

```text
yearsbetweendates                                      |
-------------------------------------------------------|
29 years 5 mons 19 days 21 hours 0 mins 39.466046 secs |
```
