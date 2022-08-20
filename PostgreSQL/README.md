
# PostgreSQL Functions

## DATETIME functions

+ convert string to date
+ add intervals to a date
+ `DATE_PART(interval, timestamp)`
+ `EXTRACT(interval FROM timestamp)`
+ `DATE_TRUNC(interval, date/timestamp)`
+ find the difference between two timestamps


### PostgreSQL: convert text to date 
```sql
SELECT
    '2017-03-31'                          as TextField,
    TO_DATE('2017-03-31', 'YYYY-MM-DD')   as Datefield
```

### PostgreSQL: DATE additions

```sql
SELECT
    NOW() - INTERVAL '1 year'    as OneYearAgo,
    NOW() - INTERVAL '1 month'   as OneMonthAgo,
    NOW() - INTERVAL '1 week'    as OneWeekAgo,
    NOW() - INTERVAL '1 day'     as OneDayAgo,
    NOW() - INTERVAL '1 hour'    as OneHourAgo
```

```text
oneyearago          |onemonthago         |oneweekago          |onedayago           |onehourago          |
--------------------|--------------------|--------------------|--------------------|--------------------|
2016-10-10 13:05:48 |2017-09-10 13:05:48 |2017-10-03 13:05:48 |2017-10-09 13:05:48 |2017-10-10 12:05:48 |
```

or

```sql
SELECT
    NOW() + INTERVAL '1 year'    as OneYearFromNow,
    NOW() + INTERVAL '1 month'   as OneMonthFromNow,
    NOW() + INTERVAL '1 week'    as OneWeekFromNow,
    NOW() + INTERVAL '1 day'     as OneDayFromNow,
    NOW() + INTERVAL '1 hour'    as OneHourFromNow
```

```text
oneyearfromnow      |onemonthfromnow     |oneweekfromnow      |onedayfromnow       |onehourfromnow      |
--------------------|--------------------|--------------------|--------------------|--------------------|
2018-10-10 13:06:26 |2017-11-10 13:06:26 |2017-10-17 13:06:26 |2017-10-11 13:06:26 |2017-10-10 14:06:26 |
```



### PostgreSQL: DATE_PART
```sql
SELECT
    CURRENT_TIMESTAMP,

    ----find current century
    DATE_PART('century', CURRENT_TIMESTAMP)         as Century,                 
    DATE_PART('decade', CURRENT_TIMESTAMP)          as Decade,
    DATE_PART('doy', CURRENT_TIMESTAMP)             as DayOfYear,

    ----find day of current week (0 to 6)
    DATE_PART('dow', CURRENT_TIMESTAMP)             as DayOfWeek,
    DATE_PART('isoyear', CURRENT_TIMESTAMP)         as ISOYear,
    DATE_PART('year', CURRENT_TIMESTAMP)            as CurrentYear,
    DATE_PART('quarter', CURRENT_TIMESTAMP)         as CurrentQuarter,
    DATE_PART('month', CURRENT_TIMESTAMP)           as CurrentMonth,
    DATE_PART('day', CURRENT_TIMESTAMP)             as CurrentDay,
    DATE_PART('hour', CURRENT_TIMESTAMP)            as CurrentHour
```

```text
now                 |century |decade |dayofyear |dayofweek |isoyear |currentyear |currentquarter |currentmonth |currentday |currenthour |
--------------------|--------|-------|----------|----------|--------|------------|---------------|-------------|-----------|------------|
2017-10-13 13:45:32 |21      |201    |296       |1         |2017    |2017        |4              |10           |13         |13          |
```

### PostgreSQL: EXTRACT
```sql
SELECT
    CURRENT_TIMESTAMP,
    EXTRACT(century FROM CURRENT_TIMESTAMP)         as Century,
    EXTRACT(decade FROM CURRENT_TIMESTAMP)          as Decade,
    EXTRACT(doy FROM CURRENT_TIMESTAMP)             as DayOfYear,
    EXTRACT(dow FROM CURRENT_TIMESTAMP)             as DayOfWeek,
    EXTRACT(isoyear FROM CURRENT_TIMESTAMP)         as ISOYear,
    EXTRACT(year FROM CURRENT_TIMESTAMP)            as CurrentYear,
    EXTRACT(quarter FROM CURRENT_TIMESTAMP)         as CurrentQuarter,
    EXTRACT(month FROM CURRENT_TIMESTAMP)           as CurrentMonth,
    EXTRACT(day FROM CURRENT_TIMESTAMP)             as CurrentDay,
    EXTRACT(hour FROM CURRENT_TIMESTAMP)            as CurrentHour
```

```text
now                 |century |decade |dayofyear |dayofweek |isoyear |currentyear |currentquarter |currentmonth |currentday |currenthour |
--------------------|--------|-------|----------|----------|--------|------------|---------------|-------------|-----------|------------|
2017-10-13 13:45:32 |21      |201    |296       |1         |2017    |2017        |4              |10           |13         |13          |
```


### PostgreSQL: find the first day of

```sql
SELECT
    DATE(DATE_TRUNC('week', Now()))  as FirstDayOfCurrentWeek,
    DATE(DATE_TRUNC('month', Now())) as FirstDayofCurrentMonth,
    DATE(DATE_TRUNC('year', Now()))  as FirstDayOfCurrentYear
```

```text
firstdayofcurrentweek |firstdayofcurrentmonth |firstdayofcurrentyear |
----------------------|-----------------------|----------------------|
2017-11-06            |2017-11-01             |2017-01-01            |
```


### PostgreSQL: find the last day of

```sql
SELECT
    DATE(NOW()) as Today,
    DATE(DATE_TRUNC('month', Now() + interval '0 month') - interval '1 day')  as LastDayPreviousMonth,
    DATE(DATE_TRUNC('month', Now() + interval '1 month') - interval '1 day')  as LastDayThisMonth,
    DATE(DATE_TRUNC('month', Now() + interval '2 month') - interval '1 day')  as LastDayNextMonth
```

```text
today      |lastdaypreviousmonth |lastdaythismonth |lastdaynextmonth |
-----------|---------------------|-----------------|-----------------|
2017-11-18 |2017-10-31           |2017-11-30       |2017-12-31       |
```


### PostgreSQL: find exact period between two dates
```sql
SELECT
    age(Now(), '1988-06-21') as YearsBetweenDates
```
```
yearsbetweendates                                      |
-------------------------------------------------------|
29 years 5 mons 19 days 21 hours 0 mins 39.466046 secs |
```