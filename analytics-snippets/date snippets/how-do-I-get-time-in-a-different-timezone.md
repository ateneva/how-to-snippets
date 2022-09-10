# How do I convert a timestamp to another timezone?

<!-- vscode-markdown-toc -->
* 1. [Vertica](#Vertica)
* 2. [PostgreSQL](#PostgreSQL)
* 3. [MySQL](#MySQL)
* 4. [BigQuery](#BigQuery)
* 5. [Redshift](#Redshift)
* 6. [Python](#Python)
* 7. [Tableau](#Tableau)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

##  1. <a name='Vertica'></a>Vertica
```sql
SELECT
NOW() AT TIME ZONE 'Pacific/Auckland NZ'          AS NZT,   -- + 12.00 Welington, New Zealand
NOW() AT TIME ZONE 'Australia/Brisbane'           AS AEST,  -- Australa Eastern Standard Time = Brisbane, Sydney, Melbourne, Canberra
NOW() AT TIME ZONE 'Australia/Adelaide'           AS CAST,  -- Central Australia Standard Time = Adelaide
NOW() AT TIME ZONE 'Asia/Tokyo Japan'             AS JST,   -- Japan Standard Time = Tokyo, Seoul
NOW() AT TIME ZONE 'Australia/Perth'              AS AWST,  -- Australia Western Standard Time = Perth

NOW() AT TIME ZONE 'Europe/Sofia'                 AS EET,   -- Sofia, Athens, Vilnius, Bucharest
NOW() AT TIME ZONE 'Europe/Amsterdam'             AS CET,   -- Amsterdam, Paris, Berlin, Madrid, Rome
NOW() AT TIME ZONE 'Europe/London'                AS GMT,   -- London, Dublin

NOW() AT TIME ZONE 'America/New_York'             AS EST,   -- Toronto, New York, Boston, Rio De Janeiro
NOW() AT TIME ZONE 'America/Chicago'              AS CST,   -- Winnipeg, Chicago, Houston, Kansas, New Orleans
NOW() AT TIME ZONE 'America/Denver'               AS MST,   -- Edmonton, Calgary, Denver, Phoenix
NOW() AT TIME ZONE 'America/Los_Angeles'          AS PST    -- Vancouver, Los Angeles
```

##  2. <a name='PostgreSQL'></a>PostgreSQL
```sql
select
NOW() AT TIME ZONE 'NZT'                          AS NZT,   -- + 12.00 Welington, New Zealand
NOW() AT TIME ZONE 'AEST'                         AS AEST,  -- Australa Eastern Standard Time = Brisbane, Sydney, Melbourne, Canberra
NOW() AT TIME ZONE 'CAST'                         AS cast,  -- Central Australia Standard Time = Adelaide
NOW() AT TIME ZONE 'JST'                          AS JST,   -- Japan Standard Time = Tokyo, Seoul
NOW() AT TIME ZONE 'AWST'                         AS AWST,  -- Australia Western Standard Time = Perth

NOW() AT TIME ZONE 'EET'                          AS EET,   -- Sofia, Athens, Vilnius, Bucharest
NOW() AT TIME ZONE 'CET'                          AS CET,   -- Amsterdam, Paris, Berlin, Madrid, Rome
NOW() AT TIME ZONE 'GMT'                          AS GMT,   -- London, Dublin

NOW() AT TIME ZONE 'EST'                          AS EST,   -- Toronto, New York, Boston, Rio De Janeiro
NOW() AT TIME ZONE 'CST'                          AS CST,   -- Winnipeg, Chicago, Houston, Kansas, New Orleans
NOW() AT TIME ZONE 'MST'                          AS MST,   -- Edmonton, Calgary, Denver, Phoenix
NOW() AT TIME ZONE 'PST'                          AS PST    -- Vancouver, Los Angeles
```


##  3. <a name='MySQL'></a>MySQL
```sql
select
CONVERT_TZ(NOW(), 'CET', 'Pacific/Auckland')      AS NZT,   -- + 12.00 Welington, New Zealand
CONVERT_TZ(NOW(), 'CET', 'Australia/Brisbane')    AS AEST,  -- Australa Eastern Standard Time = Brisbane, Sydney, Melbourne, Canberra
CONVERT_TZ(NOW(), 'CET', 'Australia/Adelaide')    AS cast,  -- Central Australia Standard Time = Adelaide
CONVERT_TZ(NOW(), 'CET', 'Asia/Tokyo')            AS JST,   -- Japan Standard Time = Tokyo, Seoul
CONVERT_TZ(NOW(), 'CET', 'Australia/Perth')       AS AWST,  -- Australia Western Standard Time = Perth

CONVERT_TZ(NOW(), 'CET', 'EET')                   AS EET,   -- Sofia, Athens, Vilnius, Bucharest
CONVERT_TZ(NOW(), 'CET', 'CET')                   AS CET,   -- Amsterdam, Paris, Berlin, Madrid, Rome
CONVERT_TZ(NOW(), 'CET', 'GMT')                   AS GMT,   -- London, Dublin

CONVERT_TZ(NOW(), 'CET', 'EST')                   AS EST,   -- Toronto, New York, Boston, Rio De Janeiro
CONVERT_TZ(NOW(), 'CET', 'America/Chicago')       AS CST,   -- Winnipeg, Chicago, Houston, Kansas, New Orleans
CONVERT_TZ(NOW(), 'CET', 'MST')                   AS MST,   -- Edmonton, Calgary, Denver, Phoenix
CONVERT_TZ(NOW(), 'CET', 'America/Los_Angeles')   AS PST    -- Vancouver, Los Angeles
```

##  4. <a name='BigQuery'></a>BigQueryy
 ```sql
 ```

##  5. <a name='Redshift'></a>Redshift
```sql
```

##  6. <a name='Python'></a>Pythonn
 ```python
 ```

##  7. <a name='Tableau'></a>Tableauu
 ```
 ```