
+ `CAST(string as DATE)`                     -- convert string to date
+ `GETDATE, GETUTCDATE, DAY, MONTH, YEAR`
+ `DATEPART(part, date/timestamp)`
+ `DATEFROMPARTS ( year, month, day )`       -- creates a date from from year, month, date
+ `DATEADD(part, interval, date)`            -- adds a period (forward or backward) to the specified date
+ `DATEDIFF(part, earlier_date, later_date)` -- finds the difference between two dates
+ `EOMONTH(date)`  							      -- returns the last day of the specified date
+ `ISDATE(expression)`                       -- checks if expressions is a date


### CAST (string as DATE)
```sql
SELECT
   '2017-03-31'                          as TextField,
   CONVERT(date, '2017-03-31')           as DateField1,
   CAST('2017-03-31' AS  DATE)           as DateField2
```

### COMMON FUNCTIONS
```sql
SELECT
   GETDATE()              as Now,
   YEAR(GETDATE())        as ThisYear,
   MONTH(GETDATE())       as ThisMonth,
   DAY(GETDATE())         as Today
```
```text
Now                 |ThisYear |ThisMonth |Today |
--------------------|---------|----------|------|
2017-10-26 16:21:57 |2017     |10        |26    |
```

### DATEPART
```sql
SELECT
   CURRENT_TIMESTAMP                   as TodayDateAndTime,
   DATEPART(yyyy, CURRENT_TIMESTAMP)   as CurrentYear,             ----find current year
   DATEPART(qq, CURRENT_TIMESTAMP)     as CurrentQuarter,          ----find current quarter
   DATEPART(mm, CURRENT_TIMESTAMP)     as CurrentMonth,            ----find current month
   DATEPART(wk, CURRENT_TIMESTAMP)     as Week,                    ----find current week number (count as of 1st January),
   DATEPART(isowk, CURRENT_TIMESTAMP)  as ISOWeek,                 ----find current week number (count as of 1st full week)
   DATEPART(dd, CURRENT_TIMESTAMP)     as CurrentDay,              ----find current month
   DATEPART(dy, CURRENT_TIMESTAMP)     as DayOfYear,               ----find day of current year
   DATEPART(dw, CURRENT_TIMESTAMP)     as DayOfWeek,               ----find day of current week (Sun-Sat)
   DATEPART(hh, CURRENT_TIMESTAMP)     as Hour                     ----find the current hour
```
```text
TodayDateAndTime    |CurrentYear |CurrentQuarter |CurrentMonth |Week |ISOWeek |CurrentDay |DayOfYear |DayOfWeek |Hour |
--------------------|------------|---------------|-------------|-----|--------|-----------|----------|----------|-----|
2017-10-13 13:44:07 |2017        |4              |10           |43   |43      |13         |296       |2         |13   |
```


### DATEADD
```sql
SELECT
   DATEADD(YEAR,    -1, GETDATE())   as OneYearAgo,
   DATEADD(MONTH,   -1, GETDATE())   as OneMonthAgo,
   DATEADD(WEEK,    -1, GETDATE())   as OneWeekAgo,
   DATEADD(DAY,     -1, GETDATE())   as OneDayAgo,
   DATEADD(WEEKDAY, -1, GETDATE())   as OneWeekdayAgo,
   DATEADD(HOUR,    -1, GETDATE())   as OneHourAgo
```

```text
OneYearAgo          |OneMonthAgo         |OneWeekAgo          |OneDayAgo           |OneWeekdayAgo       |OneHourAgo          |
--------------------|--------------------|--------------------|--------------------|--------------------|--------------------|
2016-10-10 13:03:26 |2017-09-10 13:03:26 |2017-10-03 13:03:26 |2017-10-09 13:03:26 |2017-10-09 13:03:26 |2017-10-10 12:03:26 |
```


### DATEDIFF
```sql
SELECT
   DATEDIFF(YEAR,    '1988-06-21', GETDATE()) as YearsBetweenDates,
   DATEDIFF(QUARTER, '1988-06-21', GETDATE()) as QuartersBetweenDates,
   DATEDIFF(MONTH,   '1988-06-21', GETDATE()) as MonthsBetweenDates,
   DATEDIFF(DAY,     '1988-06-21', GETDATE()) as DaysBetweenDates,
   DATEDIFF(HOUR,    '1988-06-21', GETDATE()) as HoursBetweenDates,
   DATEDIFF(MINUTE,  '1988-06-21', GETDATE()) as MinutesBetweenDates,
   DATEDIFF(SECOND,  '1988-06-21', GETDATE()) as SecondsBetweenDates
```
```text
DaysBetween |YearsBetweenDates |QuartersBetweenDates |MonthsBetweenDates |DaysBetweenDates |HoursBetweenDates |MinutesBetweenDates |SecondsBetweenDates |
------------|------------------|---------------------|-------------------|-----------------|------------------|--------------------|--------------------|
10764       |29                |117                  |353                |10764            |258357            |15501421            |930085304
```

### EOMONTH
```sql
SELECT
   CONVERT(date,GETDATE()) as Today,
   EOMONTH(GETDATE(),-1)   as LastDayPreviousMonth,
   EOMONTH(GETDATE(),+0)   as LastDayThisMonth,
   EOMONTH(GETDATE(),+1)   as LastDayNextMonth
```
```text
Today      |LastDayPreviousMonth |LastDayThisMonth |LastDayNextMonth |
-----------|---------------------|-----------------|-----------------|
2017-11-18 |2017-10-31           |2017-11-30       |2017-12-31       |
```