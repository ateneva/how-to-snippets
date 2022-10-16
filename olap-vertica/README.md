
# VERTICA functions and syntax

<!-- vscode-markdown-toc -->
* 1. [DATETIME functions](#DATETIMEfunctions)
  * 1.1. [COMMON FUNCTIONS](#COMMONFUNCTIONS)
  * 1.2. [CONVERT string to date](#CONVERTstringtodate)
  * 1.3. [EXTRACT TIME from  DATE](#EXTRACTTIMEfromDATE)
  * 1.4. [TIMESTAMPADD: add backward and forward date periods](#TIMESTAMPADD:addbackwardandforwarddateperiods)
    * 1.4.1. [DATE_SUB: add backwward date periods](#DATE_SUB:addbackwwarddateperiods)
  * 1.5. [DATEDIFF: calculate the difference between twp days](#DATEDIFF:calculatethedifferencebetweentwpdays)
  * 1.6. [DATE_TRUNC: calculate to the first date of the specified period](#DATE_TRUNC:calculatetothefirstdateofthespecifiedperiod)
  * 1.7. [LAST_DAY: calculate to the last date of the specified period](#LAST_DAY:calculatetothelastdateofthespecifiedperiod)
  * 1.8. [NEXT_DAY](#NEXT_DAY)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

<!-- markdownlint-disable MD033 -->

## 1. <a name='DATETIMEfunctions'></a>DATETIME functions

### 1.1. <a name='COMMONFUNCTIONS'></a>COMMON FUNCTIONS

```sql
SELECT
    NOW(),                                 ---find current timestamp
    DATE(NOW()),                           ---find today's date
    YEAR(Now()),                           ---find today's year
    QUARTER(NOW()),                        ---find today's quarter
    MONTH(NOW()),                          ---find today's month
    DAY(NOW()),                            ---find today's day

    DAYOFYEAR(NOW()) as DayOfYear,         ---find day of the year
    DAYOFWEEK(NOW()) as WeekdayUS,         ---find day of the week (number from 1 to 7, week starts on Sunday)
    DAYOFWEEK_ISO(NOW()) as WeekdayEU,     ---find day of the week (number from 1 to 7, week starts on Monday)

    WEEK(NOW())     as WeekNumUS,          ---week number, US standard
    WEEK_ISO(NOW()) as WeekNumEU           ---week numbeer, ISO standard
```

### 1.2. <a name='CONVERTstringtodate'></a>CONVERT string to date

```sql
SELECT
    '2017-03-31'                          as text_field,
    TO_DATE('2017-03-31', 'YYYY-MM-DD')   as date_field
```

### 1.3. <a name='EXTRACTTIMEfromDATE'></a>EXTRACT TIME from  DATE

```sql
    SELECT
    CURRENT_DATE()                      as today,
    CURRENT_TIME()                      as time_now,
    CURRENT_TIMESTAMP                   as today_date_and_time,        
    NOW(),
    DATE_PART('century', Now())         as century,                 
    DATE_PART('decade', Now())          as decade,                  
    DATE_PART('doy', Now())             as day_of_year,               
    DATE_PART('doq', Now())             as day_of_quarter,            
    DATE_PART('dow', Now())             as day_of_week,               
    DATE_PART('isoyear', Now())         as iso_year,                 
    DATE_PART('isoweek', Now())         as iso_week,                 
    DATE_PART('isodow', Now())          as day_of_iso_week,            
    DATE_PART('year', Now())            as current_year,             
    DATE_PART('quarter', Now())         as current_quarter,          
    DATE_PART('month', Now())           as current_month,            
    DATE_PART('day', Now())             as current_day,              
    DATE_PART('hour', Now())            as current_hour              
```

### 1.4. <a name='TIMESTAMPADD:addbackwardandforwarddateperiods'></a>TIMESTAMPADD: add backward and forward date periods

```sql
SELECT
    TIMESTAMPADD('year',  -1, Now())    as one_year_ago,
    TIMESTAMPADD('month', -1, Now())    as one_month_ago,
    TIMESTAMPADD('week', -1, Now())     as one_week_ago,
    TIMESTAMPADD('day', -1, Now())      as one_day_ago,
    TIMESTAMPADD('hour', -1, Now())     as one_hour_ago,

    TIMESTAMPADD('year', 1, Now())      as one_year_from_now,
    TIMESTAMPADD('month', 1, Now())     as month_from_now,
    TIMESTAMPADD('week', 1, Now())      as one_week_from_now,
    TIMESTAMPADD('day', 1, Now())       as one_day_from_now,
    TIMESTAMPADD('hour', 1, Now())      as one_hour_from_now
```

#### 1.4.1. <a name='DATE_SUB:addbackwwarddateperiods'></a>DATE_SUB: add backwward date periods

### 1.5. <a name='DATEDIFF:calculatethedifferencebetweentwpdays'></a>DATEDIFF: calculate the difference between twp days

```sql
SELECT
    DATEDIFF('year',    '1988-06-21', NOW()) as years_between_dates,
    DATEDIFF('quarter', '1988-06-21', NOW()) as quarters_between_dates,
    DATEDIFF('month',   '1988-06-21', NOW()) as months_between_dates,
    DATEDIFF('day',     '1988-06-21', NOW()) as days_between_dates,
    DATEDIFF('hour',    '1988-06-21', NOW()) as hours_between_dates,
    DATEDIFF('minute',  '1988-06-21', NOW()) as minutes_between_dates,
    DATEDIFF('second',  '1988-06-21', NOW()) as seconds_between_dates
```

### 1.6. <a name='DATE_TRUNC:calculatetothefirstdateofthespecifiedperiod'></a>DATE_TRUNC: calculate to the first date of the specified period

```sql
SELECT
    DATE(DATE_TRUNC('week', Now()))  as first_day_of_current_week,
    DATE(DATE_TRUNC('month', Now())) as first_day_of_current_month,
    DATE(DATE_TRUNC('year', Now()))  as first_day_of_current_year
```

### 1.7. <a name='LAST_DAY:calculatetothelastdateofthespecifiedperiod'></a>LAST_DAY: calculate to the last date of the specified period

```sql
SELECT
    NOW()                          as today
    LAST_DAY(NOW())                as last_day_of_current_month,
    LAST_DAY(ADD_MONTHS(NOW(),-1)) as last_day_of_previous_month,
    LAST_DAY(ADD_MONTHS(NOW(), 1)) as last_day_of_next_month
```

### 1.8. <a name='NEXT_DAY'></a>NEXT_DAY

```sql
SELECT
    NOW()                          as today,
    NEXT_DAY(NOW(), 'Monday')      as next_monday,
    NEXT_DAY(NOW(), 'Tuesday')     as next_tuesday,
    NEXT_DAY(NOW(), 'Wednesday')   as next_wednesday,
    NEXT_DAY(NOW(), 'Thursday')    as next_thursday,
    NEXT_DAY(NOW(), 'Friday')      as next_friday,
    NEXT_DAY(NOW(), 'Saturday')    as next_saturday,
    NEXT_DAY(NOW(), 'Sunday')      as next_sunday
```
