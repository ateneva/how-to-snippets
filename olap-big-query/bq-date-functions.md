
# BigQuery DATE FUNCTIONS

+ `CURRENT_DATE([time_zone])`
+ `DATE(year, month, day)`

## PARSE_DATE: convert string to date

+ `PARSE_DATE(format_string, date_string)`
+ `FORMAT_DATE(format_string, date)`

```sql
SELECT
  CURRENT_DATE() AS NOW,
  PARSE_DATE("%Y/%m/%d", "2012/12/21") AS THEDATE,
  FORMAT_DATE("%Y-%b-%d", PARSE_DATE("%Y/%m/%d", "2012/12/21")) AS THEDATE_FORMATTED
```

```json
[
  {
    "NOW": "2020-11-08",
    "THEDATE": "2012-12-21",
    "THEDATE_FORMATTED": "2012-Dec-21"
  }
]
```

### convert TO/FROM UNIX

+ `UNIX_DATE(date_expression)`
+ `DATE_FROM_UNIX_DATE(INT64_expression)`

```sql
SELECT
  CURRENT_DATE()   AS NOW,
  DATE(2012,12,21) AS THE_DATE,
  UNIX_DATE(CURRENT_DATE())      AS UNIX_CURRENT_DATE,
  DATE_FROM_UNIX_DATE(18574)     AS FROM_UNIX
```

```json
[
  {
    "NOW": "2020-11-08",
    "THE_DATE": "2012-12-21",
    "UNIX_CURRENT_DATE": "18574",
    "FROM_UNIX": "2020-11-08"
  }
]
```

### `EXTRACT(part FROM date_expression)`

+ applicable to both dates and timestamps

```sql
SELECT
  CURRENT_DATE() AS NOW,
  EXTRACT(YEAR FROM CURRENT_DATE())        AS CurrentYear,
  EXTRACT(QUARTER FROM CURRENT_DATE())     AS CurrentQuarter,
  EXTRACT(MONTH FROM CURRENT_DATE())       AS CurrentMonth,
  EXTRACT(WEEK FROM CURRENT_DATE())        AS CurrentWeek,     --starts by default on Sunday, but argument can be passed
  EXTRACT(ISOWEEK FROM CURRENT_DATE())     AS CurrentIsoWeek,  --starts on Monday
  EXTRACT(DAY FROM CURRENT_DATE())         AS CurrentDay,
  EXTRACT(DAYOFYEAR FROM CURRENT_DATE())   AS CurrentDayOfYear,
  EXTRACT(DAYOFWEEK FROM CURRENT_DATE())   AS CurrentDayOfWeek
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
    "CurrentDayOfWeek": 1
  }
]
```

### `DATE_ADD`: add backward and forward date periods

+ only applicable to dates
+ `DATE_ADD(date_expression, INTERVAL INT64_expr date_part)`

```sql
SELECT
  CURRENT_DATE() AS NOW,
  DATE_ADD(CURRENT_DATE(), INTERVAL -1 YEAR)    AS OneYearAgo,
  DATE_ADD(CURRENT_DATE(), INTERVAL -1 QUARTER) AS OneQuareterAgo,
  DATE_ADD(CURRENT_DATE(), INTERVAL -1 MONTH)   AS OneMonthAgo,
  DATE_ADD(CURRENT_DATE(), INTERVAL -1 WEEK)    AS OneWeekAgo,
  DATE_ADD(CURRENT_DATE(), INTERVAL -1 DAY)     AS OneDayAgo,

  DATE_ADD(CURRENT_DATE(), INTERVAL 1 YEAR)     AS OneYearFromNOW,
  DATE_ADD(CURRENT_DATE(), INTERVAL 1 QUARTER)  AS OneQuarterFromNow,
  DATE_ADD(CURRENT_DATE(), INTERVAL 1 MONTH)    AS MonthFromNOW,
  DATE_ADD(CURRENT_DATE(), INTERVAL 1 WEEK)     AS OneWeekFromNOW,
  DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY)      AS OneDayFromNOW
```

```json
[
  {
    "NOW": "2020-11-08",
    "OneYearAgo": "2019-11-08",
    "OneQuareterAgo": "2020-08-08",
    "OneMonthAgo": "2020-10-08",
    "OneWeekAgo": "2020-11-01",
    "OneDayAgo": "2020-11-07",
    "OneYearFromNOW": "2021-11-08",
    "OneQuarterFromNow": "2021-02-08",
    "MonthFromNOW": "2020-12-08",
    "OneWeekFromNOW": "2020-11-15",
    "OneDayFromNOW": "2020-11-09"
  }
]
```

### `DATE_SUB`: add backward date periods

+ only applicable to dates
+ `DATE_SUB(date_expression, INTERVAL INT64_expr date_part)`

```sql
SELECT
  CURRENT_DATE() AS NOW,
  DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR)       AS OneYearAgo,
  DATE_SUB(CURRENT_DATE(), INTERVAL 1 QUARTER)    AS OneQuarterAgo,
  DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)      AS OneMonthAgo,
  DATE_SUB(CURRENT_DATE(), INTERVAL 1 WEEK)       AS OneWeekAgo,
  DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)        AS OneDayAgo,

  DATE_SUB(CURRENT_DATE(), INTERVAL -1 YEAR)      AS OneYearFromNOW,
  DATE_SUB(CURRENT_DATE(), INTERVAL -1 QUARTER)   AS OneQuarterFromNOW,
  DATE_SUB(CURRENT_DATE(), INTERVAL -1 MONTH)     AS OneMonthFromNOW,
  DATE_SUB(CURRENT_DATE(), INTERVAL -1 WEEK)      AS OneWeekFromNOW,
  DATE_SUB(CURRENT_DATE(), INTERVAL -1 DAY)       AS OneDayFromNOW
```

```json
[
  {
    "NOW": "2020-11-08",
    "OneYearAgo": "2019-11-08",
    "OneQuarterAgo": "2020-08-08",
    "OneMonthAgo": "2020-10-08",
    "OneWeekAgo": "2020-11-01",
    "OneDayAgo": "2020-11-07",
    "OneYearFromNOW": "2021-11-08",
    "OneQuarterFromNow": "2021-02-08",
    "MonthFromNOW": "2020-12-08",
    "OneWeekFromNOW": "2020-11-15",
    "OneDayFromNOW": "2020-11-09"
  }
]
```

### `DATE_DIFF`: calculate the difference between two days

+ only applicable to dates

+ `DATE_DIFF(later_date, earlier_date, date_part)` ---postiive difference
+ `DATE_DIFF(earlier_date, later_date, date_part)` ---negative difference

```sql
SELECT
  CURRENT_DATE() AS NOW,
  DATE_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), YEAR )          AS YearsBetweenDates,
  DATE_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), QUARTER)        AS QuartersBetweenDates,
  DATE_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), MONTH)          AS MonthsBetweenDates,
  DATE_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), ISOWEEK)        AS IsoWeeksBetweenDates,
  DATE_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), WEEK)           AS WeeksBetweenDates,
  DATE_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), WEEK(FRIDAY))   AS DefinedWeeksBetweenDates,
  DATE_DIFF(CURRENT_DATE(), CAST('2019-01-21' AS DATE), DAY)            AS DaysBetweenDates,

  DATE_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), YEAR )          AS YearsBetweenDates,
  DATE_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), QUARTER)        AS QuartersBetweenDates,
  DATE_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), MONTH)          AS MonthsBetweenDates,
  DATE_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), ISOWEEK)        AS IsoWeeksBetweenDates,
  DATE_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), WEEK)           AS WeeksBetweenDates,
  DATE_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), WEEK(FRIDAY))   AS DefinedWeeksBetweenDates,
  DATE_DIFF(CAST('2019-01-21' AS DATE), CURRENT_DATE(), DAY)            AS DaysBetweenDates
```

```json
[
  {
    "NOW": "2020-11-08",
    "YearsBetweenDates": 1,
    "QuartersBetweenDates": 7,
    "MonthsBetweenDates": 22,
    "IsoWeeksBetweenDates": 93,
    "WeeksBetweenDates": 94,
    "DefinedWeeksBetweenDates": 94,
    "DaysBetweenDates": 657,

    "YearsBetweenDates_1": -1,
    "QuartersBetweenDates_1": -7,
    "MonthsBetweenDates_1": -22,
    "IsoWeeksBetweenDates_1": -93,
    "WeeksBetweenDates_1": -94,
    "DefinedWeeksBetweenDates_1": -94,
    "DaysBetweenDates_1": -657
  }
]
```

### `DATE_TRUNC`: calculate to the first date of the specified period

+ only applicable to dates

+ `DATE_TRUNC(date_expression, date_part)`

```sql
SELECT
  CURRENT_DATE() AS NOW,
  DATE_TRUNC(CURRENT_DATE(), WEEK)           AS FirstDayOfCurrentWeek,
  DATE_TRUNC(CURRENT_DATE(), WEEK(FRIDAY))   AS FirstDayOfDefinedCurrentWeek,
  DATE_TRUNC(CURRENT_DATE(), ISOWEEK)        AS FirstDayOfCurrentISOWeek,
  DATE_TRUNC(CURRENT_DATE(), MONTH)          AS FirstDayofCurrentMonth,
  DATE_TRUNC(CURRENT_DATE(), QUARTER)        AS FirstDayofCurrentQuarter,
  DATE_TRUNC(CURRENT_DATE(), YEAR)           AS FirstDayOfCurrentYear,
  DATE_TRUNC(CURRENT_DATE(), ISOYEAR)        AS FirstDayOfCurrentISOYear
```

```json
[
  {
    "NOW": "2020-11-08",
    "FirstDayOfCurrentWeek": "2020-11-08",
    "FirstDayOfDefinedCurrentWeek": "2020-11-06",
    "FirstDayOfCurrentISOWeek": "2020-11-02",
    "FirstDayofCurrentMonth": "2020-11-01",
    "FirstDayofCurrentQuarter": "2020-10-01",
    "FirstDayOfCurrentYear": "2020-01-01",
    "FirstDayOfCurrentISOYear": "2019-12-30"
  }
]
```

### `LAST_DAY`: calculate to the last date of the specified period

+ applicable to both dates and timestamps

```sql
SELECT
  CURRENT_DATE() AS NOW,
  LAST_DAY(CURRENT_DATE(), WEEK)            AS LastDayOfCurrentWeek,
  LAST_DAY(CURRENT_DATE(), WEEK(FRIDAY))    AS LastDayOfCurrentDefinedWeek,
  LAST_DAY(CURRENT_DATE(), ISOWEEK)         AS LastDayOfCurrentISOWeek,
  LAST_DAY(CURRENT_DATE(), MONTH)           AS LastDayofCurrentMonth,
  LAST_DAY(CURRENT_DATE(), QUARTER)         AS LastDayofCurrentQuarter,
  LAST_DAY(CURRENT_DATE(), YEAR)            AS LastDayOfCurrentYear,
  LAST_DAY(CURRENT_DATE(), ISOYEAR)         AS LastDayOfCurrentISOYear

--or

SELECT
  CURRENT_DATETIME() AS NOW,
  LAST_DAY(CURRENT_DATETIME(), WEEK)            AS LastDayOfCurrentWeek,
  LAST_DAY(CURRENT_DATETIME(), WEEK(FRIDAY))    AS LastDayOfCurrentDefinedWeek,
  LAST_DAY(CURRENT_DATETIME(), ISOWEEK)         AS LastDayOfCurrentISOWeek,
  LAST_DAY(CURRENT_DATETIME(), MONTH)           AS LastDayofCurrentMonth,
  LAST_DAY(CURRENT_DATETIME(), QUARTER)         AS LastDayofCurrentQuarter,
  LAST_DAY(CURRENT_DATETIME(), YEAR)            AS LastDayOfCurrentYear,
  LAST_DAY(CURRENT_DATETIME(), ISOYEAR)         AS LastDayOfCurrentISOYear
```

```json
[
  {
    "NOW": "2020-11-08",
    "LastDayOfCurrentWeek": "2020-11-14",
    "LastDayOfCurrentDefinedWeek": "2020-11-12",
    "LastDayOfCurrentISOWeek": "2020-11-08",
    "LastDayofCurrentMonth": "2020-11-30",
    "LastDayofCurrentQuarter": "2020-12-31",
    "LastDayOfCurrentYear": "2020-12-31",
    "LastDayOfCurrentISOYear": "2021-01-03"
  }
]
```
