# SQL SERVER functions and syntax

<!-- vscode-markdown-toc -->
* 1. [DATE AND TIME FUNCTIONS](#DATEANDTIMEFUNCTIONS)
  * 1.1. [CAST (string AS DATE)](#CASTstringASDATE)
  * 1.2. [COMMON FUNCTIONS](#COMMONFUNCTIONS)
  * 1.3. [DATEPART](#DATEPART)
  * 1.4. [DATEADD](#DATEADD)
  * 1.5. [DATEDIFF](#DATEDIFF)
  * 1.6. [EOMONTH](#EOMONTH)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

<!-- markdownlint-disable MD033 -->

## 1. <a name='DATEANDTIMEFUNCTIONS'></a>DATE AND TIME FUNCTIONS

* `CAST(string AS DATE)`
* `GETDATE, GETUTCDATE, DAY, MONTH, YEAR`
* `DATEPART`
* `DATEFROMPARTS`
* `DATEADD`
* `DATEDIFF`
* `EOMONTH`
* `ISDATE`

### 1.1. <a name='CASTstringASDATE'></a>CAST (string AS DATE)

```sql
SELECT
   '2017-03-31'                          AS TextField,
   CONVERT(date, '2017-03-31')           AS DateField1,
   CAST('2017-03-31' AS  DATE)           AS DateField2
```

### 1.2. <a name='COMMONFUNCTIONS'></a>COMMON FUNCTIONS

```sql
SELECT
   GETDATE()              AS Now,
   YEAR(GETDATE())        AS ThisYear,
   MONTH(GETDATE())       AS ThisMonth,
   DAY(GETDATE())         AS Today
```

### 1.3. <a name='DATEPART'></a>DATEPART

```sql
SELECT
   CURRENT_TIMESTAMP                   AS TodayDateAndTime,
   DATEPART(yyyy, CURRENT_TIMESTAMP)   AS CurrentYear,
   DATEPART(qq, CURRENT_TIMESTAMP)     AS CurrentQuarter,
   DATEPART(mm, CURRENT_TIMESTAMP)     AS CurrentMonth,
   DATEPART(wk, CURRENT_TIMESTAMP)     AS Week,
   DATEPART(isowk, CURRENT_TIMESTAMP)  AS ISOWeek,
   DATEPART(dd, CURRENT_TIMESTAMP)     AS CurrentDay,
   DATEPART(dy, CURRENT_TIMESTAMP)     AS DayOfYear,
   DATEPART(dw, CURRENT_TIMESTAMP)     AS DayOfWeek,
   DATEPART(hh, CURRENT_TIMESTAMP)     AS Hour
```

### 1.4. <a name='DATEADD'></a>DATEADD

```sql
SELECT
   DATEADD(YEAR,    -1, GETDATE())   AS OneYearAgo,
   DATEADD(MONTH,   -1, GETDATE())   AS OneMonthAgo,
   DATEADD(WEEK,    -1, GETDATE())   AS OneWeekAgo,
   DATEADD(DAY,     -1, GETDATE())   AS OneDayAgo,
   DATEADD(WEEKDAY, -1, GETDATE())   AS OneWeekdayAgo,
   DATEADD(HOUR,    -1, GETDATE())   AS OneHourAgo
```

### 1.5. <a name='DATEDIFF'></a>DATEDIFF

```sql
SELECT
   DATEDIFF(YEAR,    '1988-06-21', GETDATE()) AS YearsBetweenDates,
   DATEDIFF(QUARTER, '1988-06-21', GETDATE()) AS QuartersBetweenDates,
   DATEDIFF(MONTH,   '1988-06-21', GETDATE()) AS MonthsBetweenDates,
   DATEDIFF(DAY,     '1988-06-21', GETDATE()) AS DaysBetweenDates,
   DATEDIFF(HOUR,    '1988-06-21', GETDATE()) AS HoursBetweenDates,
   DATEDIFF(MINUTE,  '1988-06-21', GETDATE()) AS MinutesBetweenDates,
   DATEDIFF(SECOND,  '1988-06-21', GETDATE()) AS SecondsBetweenDates
```

### 1.6. <a name='EOMONTH'></a>EOMONTH

```sql
SELECT
   CONVERT(date,GETDATE()) AS Today,
   EOMONTH(GETDATE(),-1)   AS LAStDayPreviousMonth,
   EOMONTH(GETDATE(),+0)   AS LAStDayThisMonth,
   EOMONTH(GETDATE(),+1)   AS LAStDayNextMonth
```
