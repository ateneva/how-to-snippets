
# MySQL  FUNCTIONS

## **DATETIME FUNCTIONS**

* **STR_TO_DATE**
```sql
SELECT
'2017-03-31'                          as TextField,
STR_TO_DATE('2017-03-31', '%Y-%m-%d') as DateField
```

* **STANDARD DATE FUNCTIONS**

```sql
SELECT
    NOW(),
    DATE(CURRENT_DATE())        as Today,
    YEAR(CURRENT_DATE())        as ThisYear,
    QUARTER(CURRENT_DATE())     as ThisQuarter,
    MONTH(CURRENT_DATE())       as ThisMonth,
    DAY(CURRENT_DATE())         as ThisDay,
    
    DAYOFYEAR(CURRENT_DATE())   as DayOfYear,
    DAYOFMONTH(CURRENT_DATE())  as DayOfMonth,
    
    #1 = Sunday, 2 = Monday, …, 7 = Saturday)
    DAYOFWEEK(CURRENT_DATE())   as DayofWeek, 
    
    #0 = Monday, 1 = Tuesday, … 6 = Sunday  
    WEEKDAY(CURRENT_DATE())     as WeekdayNum,  
    
    WEEKOFYEAR(CURRENT_DATE())	as WeekNumUS,
    WEEK(CURRENT_DATE())		as WeekNumUS
```

```text
Now()               |Today      |ThisYear |ThisQuarter |ThisMonth |ThisDay |
--------------------|-----------|---------|------------|----------|--------|
2017-10-26 17:03:43 |2017-10-26 |2017     |4           |10        |26      |


DayOfYear |DayOfMonth |DayofWeek |WeekdayNum |WeekNumUS |WeekNumUS |
----------|-----------|----------|-----------|----------|----------|
299       |26         |5         |3          |43        |43        |
```



* ### **EXTRACT**

```sql
SELECT
    CURRENT_TIMESTAMP                   	 as MyLocalDateAndTime,
    EXTRACT(YEAR FROM CURRENT_TIMESTAMP)     as CurrentYear,            
    EXTRACT(QUARTER FROM CURRENT_TIMESTAMP)  as CurrentQuarter,
    EXTRACT(month FROM CURRENT_TIMESTAMP)    as CurrentMonth,
    EXTRACT(week FROM CURRENT_TIMESTAMP)     as CurrentWeek,
    EXTRACT(day FROM CURRENT_TIMESTAMP)      as CurrentDay,
    EXTRACT(hour FROM CURRENT_TIMESTAMP)     as CurrentHour
```

```text
MyLocalDateAndTime  |CurrentYear |CurrentQuarter |CurrentMonth |CurrentWeek |CurrentDay |CurrentHour |
--------------------|------------|---------------|-------------|------------|-----------|------------|
2017-10-13 13:44:51 |2017        |4              |10           |43          |13         |13          |
```


* ### **DATE_ADD() / DATE_SUB()** 

```sql
SELECT
    DATE_ADD(NOW(), INTERVAL 1 YEAR)    as OneYearFromNOW,
    DATE_ADD(NOW(), INTERVAL 1 MONTH)   as MonthFromNOW,
    DATE_ADD(NOW(), INTERVAL 1 WEEK)    as OneWeekFromNOW,
    DATE_ADD(NOW(), INTERVAL 1 DAY)     as OneDayFromNOW,
    DATE_ADD(NOW(), INTERVAL 1 HOUR)    as OneHourFromNOW
```

```text
OneYearFromNOW      |MonthFromNOW        |OneWeekFromNOW      |OneDayFromNOW       |OneHourFromNOW      |
--------------------|--------------------|--------------------|--------------------|--------------------|
2018-10-10 13:18:56 |2017-11-10 13:18:56 |2017-10-17 13:18:56 |2017-10-11 13:18:56 |2017-10-10 14:18:56 |

```

```sql
SELECT
    DATE_ADD(NOW(), INTERVAL -1 YEAR)    as OneYearAgo,
    DATE_ADD(NOW(), INTERVAL -1 MONTH)   as OneMonthAgo,
    DATE_ADD(NOW(), INTERVAL -1 WEEK)    as OneWeekAgo,
    DATE_ADD(NOW(), INTERVAL -1 DAY)     as OneDayAgo,
    DATE_ADD(NOW(), INTERVAL -1 HOUR)    as OneHourAgo
```

 or

```sql
SELECT
    DATE_SUB(NOW(), INTERVAL 1 YEAR)    as OneYearAgo,
    DATE_SUB(NOW(), INTERVAL 1 MONTH)   as OneMonthAgo,
    DATE_SUB(NOW(), INTERVAL 1 WEEK)    as OneWeekAgo,
    DATE_SUB(NOW(), INTERVAL 1 DAY)     as OneDayAgo,
    DATE_SUB(NOW(), INTERVAL 1 HOUR)    as OneHourAgo
```

```text
OneYearAgo          |OneMonthAgo         |OneWeekAgo          |OneDayAgo           |OneHourAgo          |
--------------------|--------------------|--------------------|--------------------|--------------------|
2016-10-10 13:11:12 |2017-09-10 13:11:12 |2017-10-03 13:11:12 |2017-10-09 13:11:12 |2017-10-10 12:11:12 |
```


* ### **PERIOD_ADD / PERIOD_DIF**

```sql
# fixed input month
SELECT
    NOW(),
    PERIOD_ADD(201801, 3) as 3MonthFromYM,
    PERIOD_ADD(201801,-3) as 3MonthAgo,

# get current year month
    CONCAT(YEAR(NOW()),  
        CASE
            WHEN MONTH(NOW()) < 10 THEN CONCAT(0, MONTH(NOW()))
            ELSE  MONTH(NOW())
        END) as ThisYM,


# dynamic input month
    PERIOD_ADD(CONCAT(YEAR(NOW()),  
                    CASE
                        WHEN MONTH(NOW()) < 10 THEN CONCAT(0, MONTH(NOW()))
                        ELSE MONTH(NOW())
                    END), 5) as 5MonthsFromNow
```

```text
now()               |3MonthFromYM |3MonthAgo |ThisYM |5MonthsFromNow |
--------------------|-------------|----------|-------|---------------|
2017-10-18 16:17:29 |201804       |201710    |201710 |201803         |
```


 * ### **DATEDIFF**

```sql
SELECT
    DATEDIFF(NOW(), '1988-06-21') as DaysBetween,
    DATEDIFF(YEAR,    '1988-06-21', NOW()) as YearsBetweenDates,
    DATEDIFF(QUARTER, '1988-06-21', NOW()) as QuartersBetweenDates,
    DATEDIFF(MONTH,   '1988-06-21', NOW()) as MonthsBetweenDates,
    DATEDIFF(DAY,     '1988-06-21', NOW()) as DaysBetweenDates,
    DATEDIFF(HOUR,    '1988-06-21', NOW()) as HoursBetweenDates,
    DATEDIFF(MINUTE,  '1988-06-21', NOW()) as MinutesBetweenDates,
    DATEDIFF(SECOND,  '1988-06-21', NOW()) as SecondsBetweenDates
```

```text
DaysBetween |YearsBetweenDates |QuartersBetweenDates |MonthsBetweenDates |DaysBetweenDates |
------------|------------------|---------------------|-------------------|-----------------|
10764       |29                |117                  |353                |10764            |
```


```text
|HoursBetweenDates |MinutesBetweenDates |SecondsBetweenDates |
------------------|--------------------|--------------------|
|258357            |15501421            |930085304

```

* ### **LAST DAY** 

```sql
SELECT
    DATE(NOW())                   as Today,
    LAST_DAY(ADDDATE(NOW(), -31)) as LastDayPreviousMonth,
    LAST_DAY(NOW())               as LastDayThisMonth,
    LAST_DAY(ADDDATE(Now(), +31)) as LastDayNextMonth
```

```text
Today      |LastDayPreviousMonth |LastDayThisMonth |LastDayNextMonth |
-----------|---------------------|-----------------|-----------------|
2017-11-18 |2017-10-31           |2017-11-30       |2017-12-31       |
text
