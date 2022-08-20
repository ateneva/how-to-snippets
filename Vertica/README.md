

### COMMON FUNCTIONS
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


### CONVERT string to date
```sql
SELECT
    '2017-03-31'                          as TextField,
    TO_DATE('2017-03-31', 'YYYY-MM-DD')   as Datefield
```

### EXTRACT TIME from  DATE
```sql
    SELECT
    CURRENT_DATE()                      as Today,
    CURRENT_TIME()                      as TimeNow,
    CURRENT_TIMESTAMP                   as TodayDateAndTime,        ----find current timestamp
    NOW(),
    DATE_PART('century', Now())         as Century,                 ----find current century
    DATE_PART('decade', Now())          as Decade,                  ----find current decade
    DATE_PART('doy', Now())             as DayOfYear,               ----find day of current year
    DATE_PART('doq', Now())             as DayofQuarter,            ----find day of current quarter
    DATE_PART('dow', Now())             as DayOfWeek,               ----find day of current week (0 to 6)
    DATE_PART('isoyear', Now())         as ISOYear,                 ----find current year
    DATE_PART('isoweek', Now())         as ISOWeek,                 ----find current week number
    DATE_PART('isodow', Now())          as DayOfISOWeek,            ----find day of current week (1 to 7)
    DATE_PART('year', Now())            as CurrentYear,             ----find current year
    DATE_PART('quarter', Now())         as CurrentQuarter,          ----find current quarter
    DATE_PART('month', Now())           as CurrentMonth,            ----find current month
    DATE_PART('day', Now())             as CurrentDay,              ----find current day
    DATE_PART('hour', Now())            as CurrentHour              ----find current hour
```


### TIMESTAMPADD: add backward and forward date periods
```sql
SELECT
    TIMESTAMPADD('year',  -1, Now())    as OneYearAgo,
    TIMESTAMPADD('month', -1, Now())    as OneMonthAgo,
    TIMESTAMPADD('week', -1, Now())     as OneWeekAgo,
    TIMESTAMPADD('day', -1, Now())      as OneDayAgo,
    TIMESTAMPADD('hour', -1, Now())     as OneHourAgo,

    TIMESTAMPADD('year', 1, Now())      as OneYearFromNow,
    TIMESTAMPADD('month', 1, Now())     as MonthFromNow,
    TIMESTAMPADD('week', 1, Now())      as OneWeekFromNow,
    TIMESTAMPADD('day', 1, Now())       as OneDayFromNow,
    TIMESTAMPADD('hour', 1, Now())      as OneHourFromNow
```


```text
OneYearAgo          |OneMonthAgo         |OneWeekAgo          |OneDayAgo           |OneHourAgo          |
--------------------|--------------------|--------------------|--------------------|--------------------|
2016-10-10 13:11:12 |2017-09-10 13:11:12 |2017-10-03 13:11:12 |2017-10-09 13:11:12 |2017-10-10 12:11:12 |



OneYearFromNow      |MonthFromNow        |OneWeekFromNow      |OneDayFromNow       |OneHourFromNow      |
--------------------|--------------------|--------------------|--------------------|--------------------|
2018-10-10 13:18:56 |2017-11-10 13:18:56 |2017-10-17 13:18:56 |2017-10-11 13:18:56 |2017-10-10 14:18:56 |
```

#### DATE_SUB: add backwward date periods


### DATEDIFF: calculate the difference between twp days
```sql
SELECT
    DATEDIFF('year',    '1988-06-21', NOW()) as YearsBetweenDates,
    DATEDIFF('quarter', '1988-06-21', NOW()) as QuartersBetweenDates,
    DATEDIFF('month',   '1988-06-21', NOW()) as MonthsBetweenDates,
    DATEDIFF('day',     '1988-06-21', NOW()) as DaysBetweenDates,
    DATEDIFF('hour',    '1988-06-21', NOW()) as HoursBetweenDates,
    DATEDIFF('minute',  '1988-06-21', NOW()) as MinutesBetweenDates,
    DATEDIFF('second',  '1988-06-21', NOW()) as SecondsBetweenDates
```
```text
YearsBetweenDates |QuartersBetweenDates |MonthsBetweenDates |DaysBetweenDates |HoursBetweenDates |MinutesBetweenDates |SecondsBetweenDates |
------------------|---------------------|-------------------|-----------------|------------------|--------------------|--------------------|
29                |117                  |353                |10764            |258357            |15501421            |930085304           |
```


### DATE_TRUNC: calculate to the first date of the specified period
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


### LAST_DAY: calculate to the last date of the specified period
```sql
SELECT
    NOW()                          as Today
    LAST_DAY(NOW())                as LastDayofCurrentMonth,
    LAST_DAY(ADD_MONTHS(NOW(),-1)) as LastDayofPreviousMonth,
    LAST_DAY(ADD_MONTHS(NOW(), 1)) as LastDayofNextMonth
```

```text
Today      |LastDayPreviousMonth |LastDayThisMonth |LastDayNextMonth |
-----------|---------------------|-----------------|-----------------|
2017-11-18 |2017-10-31           |2017-11-30       |2017-12-31       |
```


### NEXT_DAY
```sql
SELECT
    NOW()                          as Today,
    NEXT_DAY(NOW(), 'Monday')      as NextMonday,       --returns the date of next Monday
    NEXT_DAY(NOW(), 'Tuesday')     as NextTuesday,      --returns the date of next Tuesday
    NEXT_DAY(NOW(), 'Wednesday')   as NextWednesday,    --returns the date of next Wednesday
    NEXT_DAY(NOW(), 'Thursday')    as NextThursday,     --returns the date of next Thursday
    NEXT_DAY(NOW(), 'Friday')      as NextFriday,       --returns the date of next Friday
    NEXT_DAY(NOW(), 'Saturday')    as NextSaturday,     --returns the date of next Saturday
    NEXT_DAY(NOW(), 'Sunday')      as NextSunday        --returns the date of next Sunday
```
```text
Today      |NextMonday |NextTuesday |NextWednesday |NextThursday |NextFriday |NextSaturday |NextSunday |
-----------|-----------|------------|--------------|-------------|-----------|-------------|-----------|
2017-11-23 |2017-11-27 |2017-11-28  |2017-11-29    |2017-11-30   |2017-11-24 |2017-11-25   |2017-11-26 |
```
