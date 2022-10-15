
# BigQuery DATETIME FUNCTIONS
+ `CURRENT_DATETIME([timezone])`
+ `DATE(timestamp_expression[, timezone])`
+ `PARSE_DATETIME(format_string, string)`
+ `PARSE_TIMESTAMP(format_string, string[, time_zone])`

+ `EXTRACT(part FROM timestamp_expression [AT TIME ZONE tz_spec])`

+ `DATETIME_ADD(datetime_expression, INTERVAL INT64_expr part)`
+ `DATETIME_SUB(datetime_expression, INTERVAL INT64_expr part)`

+ `DATETIME_DIFF(datetime_expression, datetime_expression, part)`

+ `DATETIME_TRUNC(datetime_expression, part)`


### PARSE and FORMAT DATETIME
```sql
SELECT
  CURRENT_DATETIME()       AS NOW,
  CURRENT_DATETIME('GMT')  AS GMT,
  CURRENT_DATETIME('CET')  AS CET,
  CURRENT_DATETIME('EET')  AS EET,
  DATE(CURRENT_DATETIME()) AS DATE,
  DATE(CURRENT_DATETIME('NZ')) AS DATE_NZ,

  PARSE_DATETIME("%Y/%m/%d %H:%M:%S", "2012/12/21 21:59:13") AS THE_DATETIME,

  FORMAT_DATETIME("%Y-%b-%d %H:%M:%S", 
    PARSE_DATETIME("%Y/%m/%d %H:%M:%S", "2012/12/21 21:59:13")) AS THE_DATETIME_FORMATTED,
```
```json
[
  {
    "NOW": "2020-11-08T14:17:17.995198",
    "GMT": "2020-11-08T14:17:17.995198",
    "CET": "2020-11-08T15:17:17.995198",
    "EET": "2020-11-08T16:17:17.995198",
    "DATE": "2020-11-08",
    "DATE_NZ": "2020-11-09",
    "THE_DATETIME": "2012-12-21T21:59:13",
    "THE_DATETIME_FORMATTED": "2012-Dec-21 21:59:13"
  }
]
```

### EXTRACT TIME from  DATE--->applicable to both dates and datetimes
```sql
SELECT ---- also supports MILISECOND, MICROSECOND
  CURRENT_DATETIME() AS NOW,
  EXTRACT(YEAR FROM CURRENT_DATETIME())        AS CurrentYear,
  EXTRACT(QUARTER FROM CURRENT_DATETIME())     AS CurrentQuarter,
  EXTRACT(MONTH FROM CURRENT_DATETIME())       AS CurrentMonth,
  EXTRACT(WEEK FROM CURRENT_DATETIME())        AS CurrentWeek,     --starts by default on Sunday, but argument can be passed
  EXTRACT(ISOWEEK FROM CURRENT_DATETIME())     AS CurrentIsoWeek,  --starts on Monday
  EXTRACT(DAY FROM CURRENT_DATETIME())         AS CurrentDay,
  EXTRACT(DAYOFYEAR FROM CURRENT_DATETIME())   AS CurrentDayOfYear,
  EXTRACT(DAYOFWEEK FROM CURRENT_DATETIME())   AS CurrentDayOfWeek,
  EXTRACT(HOUR FROM CURRENT_DATETIME())        AS CurrentHour,
  EXTRACT(MINUTE FROM CURRENT_DATETIME())      AS CurrentMinute,
  EXTRACT(SECOND FROM CURRENT_DATETIME())      AS CurrentSecond
```
```json
[
  {
    "NOW": "2020-11-08",
    "CurrentYear": 2020,
    "CurrentQuarter": 4,
    "CurrentMonth": 11,
    "CurrentWeek": 45,
    "CurrentIsoWeek": 45,
    "CurrentDay": 8,
    "CurrentDayOfYear": 313,
    "CurrentDayOfWeek": 1,
    "CurrentHour": 8,
    "CurrentMinute": 31,
    "CurrentSecond": 14
  }
]
```

### DATETIME_ADD
```sql
SELECT  -- also supports MILISECOND, MICROSECOND
  CURRENT_DATETIME() AS NOW,
  DATETIME_ADD(CURRENT_DATETIME(), INTERVAL -1 YEAR)    AS OneYearAgo,
  DATETIME_ADD(CURRENT_DATETIME(), INTERVAL -1 QUARTER) AS OneQuareterAgo,
  DATETIME_ADD(CURRENT_DATETIME(), INTERVAL -1 MONTH)   AS OneMonthAgo,
  DATETIME_ADD(CURRENT_DATETIME(), INTERVAL -1 WEEK)    AS OneWeekAgo,
  DATETIME_ADD(CURRENT_DATETIME(), INTERVAL -1 DAY)     AS OneDayAgo,
  DATETIME_ADD(CURRENT_DATETIME(), INTERVAL -1 HOUR)    AS OneHourAgo,
  DATETIME_ADD(CURRENT_DATETIME(), INTERVAL -1 MINUTE)  AS OneMinuteAgo,
  DATETIME_ADD(CURRENT_DATETIME(), INTERVAL -1 SECOND)  AS OneSecondAgo,


  DATETIME_ADD(CURRENT_DATETIME(), INTERVAL 1 YEAR)     AS OneYearFromNOW,
  DATETIME_ADD(CURRENT_DATETIME(), INTERVAL 1 QUARTER)  AS OneQuarterFromNow,
  DATETIME_ADD(CURRENT_DATETIME(), INTERVAL 1 MONTH)    AS MonthFromNOW,
  DATETIME_ADD(CURRENT_DATETIME(), INTERVAL 1 WEEK)     AS OneWeekFromNOW,
  DATETIME_ADD(CURRENT_DATETIME(), INTERVAL 1 DAY)      AS OneDayFromNOW,
  DATETIME_ADD(CURRENT_DATETIME(), INTERVAL 1 HOUR)     AS OneHourFromNOW,
  DATETIME_ADD(CURRENT_DATETIME(), INTERVAL 1 MINUTE)   AS OneMinuteFromNOW,
  DATETIME_ADD(CURRENT_DATETIME(), INTERVAL 1 SECOND)   AS OneSecondFromNOW
```
```json
[
  {
    "NOW": "2020-11-08T10:37:26.754845",
    "OneYearAgo": "2019-11-08T10:37:26.754845",
    "OneQuareterAgo": "2020-08-08T10:37:26.754845",
    "OneMonthAgo": "2020-10-08T10:37:26.754845",
    "OneWeekAgo": "2020-11-01T10:37:26.754845",
    "OneDayAgo": "2020-11-07T10:37:26.754845",
    "OneHourAgo": "2020-11-08T09:37:26.754845",
    "OneMinuteAgo": "2020-11-08T10:36:26.754845",
    "OneSecondAgo": "2020-11-08T10:37:25.754845",
    "OneYearFromNOW": "2021-11-08T10:37:26.754845",
    "OneQuarterFromNow": "2021-02-08T10:37:26.754845",
    "MonthFromNOW": "2020-12-08T10:37:26.754845",
    "OneWeekFromNOW": "2020-11-15T10:37:26.754845",
    "OneDayFromNOW": "2020-11-09T10:37:26.754845",
    "OneHourFromNOW": "2020-11-08T11:37:26.754845",
    "OneMinuteFromNOW": "2020-11-08T10:38:26.754845",
    "OneSecondFromNOW": "2020-11-08T10:37:27.754845"
  }
]
```

### DATETIME_SUB()
```sql
SELECT -- also supports MILISECOND, MICROSECOND
  CURRENT_DATETIME() AS NOW,
  DATETIME_SUB(CURRENT_DATETIME(), INTERVAL -1 YEAR)    AS OneYearFromNow,
  DATETIME_SUB(CURRENT_DATETIME(), INTERVAL -1 QUARTER) AS OneQuareterFromNpw,
  DATETIME_SUB(CURRENT_DATETIME(), INTERVAL -1 MONTH)   AS OneMonthFromNow,
  DATETIME_SUB(CURRENT_DATETIME(), INTERVAL -1 WEEK)    AS OneWeekFromNow,
  DATETIME_SUB(CURRENT_DATETIME(), INTERVAL -1 DAY)     AS OneDayFromNow,
  DATETIME_SUB(CURRENT_DATETIME(), INTERVAL -1 HOUR)    AS OneHourFromNow,
  DATETIME_SUB(CURRENT_DATETIME(), INTERVAL -1 MINUTE)  AS OneMinuteFromNow,
  DATETIME_SUB(CURRENT_DATETIME(), INTERVAL -1 SECOND)  AS OneSecondFromNow,


  DATETIME_SUB(CURRENT_DATETIME(), INTERVAL 1 YEAR)     AS OneYearAgo,
  DATETIME_SUB(CURRENT_DATETIME(), INTERVAL 1 QUARTER)  AS OneQuarterAgo,
  DATETIME_SUB(CURRENT_DATETIME(), INTERVAL 1 MONTH)    AS OneMontAgo,
  DATETIME_SUB(CURRENT_DATETIME(), INTERVAL 1 WEEK)     AS OneWeekAgo,
  DATETIME_SUB(CURRENT_DATETIME(), INTERVAL 1 DAY)      AS OneDayAgo,
  DATETIME_SUB(CURRENT_DATETIME(), INTERVAL 1 HOUR)     AS OneHourAgo,
  DATETIME_SUB(CURRENT_DATETIME(), INTERVAL 1 MINUTE)   AS OneMinuteAgo,
  DATETIME_SUB(CURRENT_DATETIME(), INTERVAL 1 SECOND)   AS OneSecondAgo
```
```json
[
  {
    "NOW": "2020-11-08T11:22:25.550588",
    "OneYearFromNow": "2021-11-08T11:22:25.550588",
    "OneQuareterFromNpw": "2021-02-08T11:22:25.550588",
    "OneMonthFromNow": "2020-12-08T11:22:25.550588",
    "OneWeekFromNow": "2020-11-15T11:22:25.550588",
    "OneDayFromNow": "2020-11-09T11:22:25.550588",
    "OneHourFromNow": "2020-11-08T12:22:25.550588",
    "OneMinuteFromNow": "2020-11-08T11:23:25.550588",
    "OneSecondFromNow": "2020-11-08T11:22:26.550588",
    "OneYearAgo": "2019-11-08T11:22:25.550588",
    "OneQuarterAgo": "2020-08-08T11:22:25.550588",
    "OneMontAgo": "2020-10-08T11:22:25.550588",
    "OneWeekAgo": "2020-11-01T11:22:25.550588",
    "OneDayAgo": "2020-11-07T11:22:25.550588",
    "OneHourAgo": "2020-11-08T10:22:25.550588",
    "OneMinuteAgo": "2020-11-08T11:21:25.550588",
    "OneSecondAgo": "2020-11-08T11:22:24.550588"
  }
]
```

### DATETIME_DIFF(datetime_expression, datetime_expression, part)
```sql
SELECT
  CURRENT_DATE() AS NOW,
  DATETIME_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), YEAR )          AS YearsBetweenDatetimes,
  DATETIME_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), QUARTER)        AS QuartersBetweenDatetimes,
  DATETIME_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), MONTH)          AS MonthsBetweenDatetimes,
  DATETIME_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), ISOWEEK)        AS IsoWeeksBetweenDatetimes,
  DATETIME_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), WEEK)           AS WeeksBetweenDatetimes,
  DATETIME_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), WEEK(FRIDAY))   AS DefinedWeeksBetweenDatetimes,
  DATETIME_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), DAY)            AS DaysBetweenDatetimes,
  DATETIME_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), HOUR)           AS HoursBetweenDatetimes,
  DATETIME_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), MINUTE)         AS MinutesBetweenDatetimes,
  DATETIME_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), SECOND)         AS SecondsBetweenDatetimes,


  DATETIME_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), YEAR )          AS YearsBetweenDatetimes,
  DATETIME_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), QUARTER)        AS QuartersBetweenDatetimes,
  DATETIME_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), MONTH)          AS MonthsBetweenDatetimes,
  DATETIME_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), ISOWEEK)        AS IsoWeeksBetweenDatetimes,
  DATETIME_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), WEEK)           AS WeeksBetweenDatetimes,
  DATETIME_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), WEEK(FRIDAY))   AS DefinedWeeksBetweenDatetimes,
  DATETIME_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), DAY)            AS DaysBetweenDatetimes,
  DATETIME_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), HOUR)           AS HoursBetweenDatetimes,
  DATETIME_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), MINUTE)         AS MinutessBetweenDatetimes,
  DATETIME_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), SECOND)         AS SecondsBetweenDatetimes
```
```json
[
  {
    "NOW": "2020-11-08",
    "YearsBetweenDatetimes": 1,
    "QuartersBetweenDatetimes": 7,
    "MonthsBetweenDatetimes": 22,
    "IsoWeeksBetweenDatetimes": 93,
    "WeeksBetweenDatetimes": 94,
    "DefinedWeeksBetweenDatetimes": 94,
    "DaysBetweenDatetimes": 657,
    "HoursBetweenDatetimes": 15768,
    "MinutesBetweenDatetimes": 946080,
    "SecondsBetweenDatetimes": 56764800,
    "YearsBetweenDatetimes_1": -1,
    "QuartersBetweenDatetimes_1": -7,
    "MonthsBetweenDatetimes_1": -22,
    "IsoWeeksBetweenDatetimes_1": -93,
    "WeeksBetweenDatetimes_1": -94,
    "DefinedWeeksBetweenDatetimes_1": -94,
    "DaysBetweenDatetimes_1": -657,
    "HoursBetweenDatetimes_1": -15768,
    "MinutessBetweenDatetimes": -946080,
    "SecondsBetweenDatetimes_1": -56764800
  }
]
```

### DATETIME_TRUNC()
```sql
SELECT
  CURRENT_DATETIME() AS NOW,
  DATETIME_TRUNC(CURRENT_DATETIME(), SECOND)         AS StartOfCurrentSecond,
  DATETIME_TRUNC(CURRENT_DATETIME(), MINUTE)         AS StartOfCurrentMinute,
  DATETIME_TRUNC(CURRENT_DATETIME(), HOUR)           AS StartOfCurrentHour,
  DATETIME_TRUNC(CURRENT_DATETIME(), DAY)            AS StartofCurrentDay,
  DATETIME_TRUNC(CURRENT_DATETIME(), WEEK)           AS FirstDayOfCurrentWeek,
  DATETIME_TRUNC(CURRENT_DATETIME(), WEEK(FRIDAY))   AS FirstDayOfDefinedCurrentWeek,
  DATETIME_TRUNC(CURRENT_DATETIME(), ISOWEEK)        AS FirstDayOfCurrentISOWeek,
  DATETIME_TRUNC(CURRENT_DATETIME(), MONTH)          AS FirstDayofCurrentMonth,
  DATETIME_TRUNC(CURRENT_DATETIME(), QUARTER)        AS FirstDayofCurrentQuarter,
  DATETIME_TRUNC(CURRENT_DATETIME(), YEAR)           AS FirstDayOfCurrentYear,
  DATETIME_TRUNC(CURRENT_DATETIME(), ISOYEAR)        AS FirstDayOfCurrentISOYear
```
```json
[
  {
    "NOW": "2020-11-08T13:52:43.865759",
    "StartOfCurrentSecond": "2020-11-08T13:52:43",
    "StartOfCurrentMinute": "2020-11-08T13:52:00",
    "StartOfCurrentHour": "2020-11-08T13:00:00",
    "StartofCurrentDay": "2020-11-08T00:00:00",
    "FirstDayOfCurrentWeek": "2020-11-08T00:00:00",
    "FirstDayOfDefinedCurrentWeek": "2020-11-06T00:00:00",
    "FirstDayOfCurrentISOWeek": "2020-11-02T00:00:00",
    "FirstDayofCurrentMonth": "2020-11-01T00:00:00",
    "FirstDayofCurrentQuarter": "2020-10-01T00:00:00",
    "FirstDayOfCurrentYear": "2020-01-01T00:00:00",
    "FirstDayOfCurrentISOYear": "2019-12-30T00:00:00"
  }
]
```