**Overview**
------------

You must complete a series of tasks within the allocated time period. Instead of following step-by-step instructions, you'll be given a scenario and a set of tasks - you figure out how to complete it on your own! An automated scoring system (shown on this page) will provide feedback on whether you have completed your tasks correctly.

To score 100% you must complete all tasks within the time period!

When you take a Challenge Lab, you will not be taught Google Cloud concepts. To build the solution to the challenge presented, use skills learned from the labs in the quest this challenge lab is part of. You will be expected to extend your learned skills; you will be expected to change broken queries.

This lab is recommended for students who have enrolled in the [Insights from Data with BigQuery](https://google.qwiklabs.com/quests/123) quest. Are you ready for the challenge?

**Scenario**
------------

You're part of a public health organization which is tasked with identifying answers to queries related to the Covid-19 pandemic. Obtaining the right answers will help the organization in planning and focusing healthcare efforts and awareness programs appropriately.

The dataset and table that will be used for this analysis will be : `bigquery-public-data.covid19_open_data.covid19_open_data`. This repository contains country-level datasets of daily time-series data related to COVID-19 globally. It includes data relating to demographics, economy, epidemiology, geography, health, hospitalizations, mobility, government response, and weather.



---

**Setup and Requirements**
--------------------------

#### **Before you click the Start Lab button**

Read these instructions. Labs are timed and you cannot pause them. The timer, which starts when you click **Start Lab**, shows how long Google Cloud resources will be made available to you.

This Qwiklabs hands-on lab lets you do the lab activities yourself in a real cloud environment, not in a simulation or demo environment. It does so by giving you new, temporary credentials that you use to sign in and access Google Cloud for the duration of the lab.

#### **What you need**

To complete this lab, you need:

*   Access to a standard internet browser (Chrome browser recommended).
*   Time to complete the lab.

**Note:** If you already have your own personal Google Cloud account or project, do not use it for this lab.

**Note:** If you are using a Pixelbook, open an Incognito window to run this lab.

#### **How to start your lab and sign in to the Google Cloud Console**

1.  Click the **Start Lab** button. If you need to pay for the lab, a pop-up opens for you to select your payment method. On the left is a panel populated with the temporary credentials that you must use for this lab.
2.  ![](https://cdn.qwiklabs.com/%2FtHp4GI5VSDyTtdqi3qDFtevuY014F88%2BFow%2FadnRgE%3D)
3.  Copy the username, and then click **Open Google Console**. The lab spins up resources, and then opens another tab that shows the **Sign in** page.
4.  ![](https://cdn.qwiklabs.com/VkUIAFY2xX3zoHgmWqYKccRLwFrR4BfARLd5ojmlbhs%3D)
5.  **_Tip:_** Open the tabs in separate windows, side-by-side.
6.  If you see the **Choose an account** page, click **Use Another Account**. ![](https://cdn.qwiklabs.com/eQ6xPnPn13GjiJP3RWlHWwiMjhooHxTNvzfg1AL2WPw%3D)
7.  In the **Sign in** page, paste the username that you copied from the Connection Details panel. Then copy and paste the password.
8.  **_Important:_** You must use the credentials from the Connection Details panel. Do not use your Qwiklabs credentials. If you have your own Google Cloud account, do not use it for this lab (avoids incurring charges).
9.  Click through the subsequent pages:
    *   Accept the terms and conditions.
    *   Do not add recovery options or two-factor authentication (because this is a temporary account).
    *   Do not sign up for free trials.

After a few moments, the Cloud Console opens in this tab.

**Note:** You can view the menu with a list of Google Cloud Products and Services by clicking the **Navigation menu** at the top-left. ![](https://cdn.qwiklabs.com/9vT7xPlxoNP%2FPsK0J8j0ZPFB4HnnpaIJVCDByaBrSHg%3D)

✅ **Query 1: Total Confirmed Cases**
------------------------------------

Build a query that will answer "What was the total count of confirmed cases on Apr 15, 2020?" The query needs to return a single row containing the sum of confirmed cases across all countries. The name of the column should be **total\_cases\_worldwide**.

Columns to reference:

*   cumulative\_confirmed
*   date

Click _Check my progress_ to verify the objective.



```sql
SELECT
SUM (cumulative_confirmed) AS total_cases_worldwide
FROM `bigquery-public-data.covid19_open_data.covid19_open_data`
WHERE date = '2020-04-15'
```



Total Confirmed Cases



![](https://t4668229.p.clickup-attachments.com/t4668229/feef0bc5-112b-455c-a789-4f10c5541e5d/image.png)

Check my progress

![](https://t4668229.p.clickup-attachments.com/t4668229/c53613a2-cfb9-43f6-9071-d9aaf43b6d36/image.png)





**Query 2: Worst Affected Areas**
---------------------------------

Build a query for answering "How many states in the US had more than 100 deaths on Apr 10, 2020?" The query needs to list the output in the field **count\_of\_states**. **Hint:** Don't include NULL values.

Columns to reference:

*   country\_name
*   subregion1\_name (for state information)
*   cumulative\_deceased

Click _Check my progress_ to verify the objective.



```sql
SELECT
country_name,
--cumulative_deceased,
COUNT(DISTINCT subregion1_name) AS count_of_states,
--SUM (cumulative_deceased) AS deaths
FROM `bigquery-public-data.covid19_open_data.covid19_open_data`
WHERE 1=1
    AND country_name = 'United States of America'
    AND date = '2020-04-10'
    AND cumulative_deceased > 100

GROUP BY
country_name

--HAVING SUM (cumulative_deceased) > 100

ORDER BY 1 DESC
```



```sql
SELECT
--date,
--subregion1_name,
--SUM(cumulative_deceased) ,
COUNT(DISTINCT subregion1_name) AS count_of_states
FROM `bigquery-public-data.covid19_open_data.covid19_open_data`
WHERE country_name = 'United States of America'
    AND date = '2020-04-10'
    AND subregion1_name IS NOT NULL

--GROUP BY 1,2
HAVING SUM(cumulative_deceased) > 100
```



Worst Affected Areas

Check my progress







**Query 3: Identifying Hotspots**
---------------------------------

Build a query that will answer "List all the states in the United States of America that had more than 1000 confirmed cases on Apr 10, 2020?" The query needs to return the State Name and the corresponding confirmed cases arranged in descending order. Name of the fields to return **state** and **total\_confirmed\_cases**.

Columns to reference:

*   country\_code
*   subregion1\_name (for state information)
*   cumulative\_confirmed

Click _Check my progress_ to verify the objective.



```sql
SELECT
subregion1_name AS state,
SUM(cumulative_confirmed) AS total_confirmed_cases
FROM `bigquery-public-data.covid19_open_data.covid19_open_data`
WHERE 1=1
    AND country_name = 'United States of America'
    AND date = '2020-04-10'
    AND cumulative_confirmed > 1000
    AND subregion1_name IS NOT NULL

GROUP BY 1
ORDER BY  total_confirmed_cases DESC
```



```sql
SELECT
subregion1_name AS state,
SUM(cumulative_confirmed) AS total_confirmed_cases
FROM `bigquery-public-data.covid19_open_data.covid19_open_data`
WHERE 1=1
    AND country_name = 'United States of America'
    AND date = '2020-04-10'
    --AND cumulative_confirmed > 1000
    AND subregion1_name IS NOT NULL

GROUP BY 1
HAVING SUM(cumulative_confirmed) > 1000
ORDER BY  total_confirmed_cases DESC
```



Identifying Hotspots

Check my progress



✅ **Query 4: Fatality Ratio**
-----------------------------

Build a query that will answer "What was the case-fatality ratio in Italy for the month of April 2020?" Case-fatality ratio here is defined as (total deaths / total confirmed cases) \* 100. Write a query to return the ratio for the month of April 2020 and containing the following fields in the output: **total\_confirmed\_cases**, **total\_deaths**, **case\_fatality\_ratio**.

Columns to reference:

*   country\_name
*   cumulative\_confirmed
*   cumulative\_deceased

Click _Check my progress_ to verify the objective.



```sql
SELECT
SUM(cumulative_confirmed) AS total_confirmed_cases,
SUM(cumulative_deceased) AS total_deaths,
SUM(cumulative_deceased) / SUM(cumulative_confirmed) * 100 AS case_fatality_ratio
FROM `bigquery-public-data.covid19_open_data.covid19_open_data`
WHERE 1=1
    AND date BETWEEN '2020-04-01' AND '2020-04-30'
    AND country_name = 'Italy'
```



Fatality Ratio

Check my progress

![](https://t4668229.p.clickup-attachments.com/t4668229/4130eb72-5251-4bc4-bfe8-65c41fab0c5b/image.png)



✅ **Query 5: Identifying specific day**
---------------------------------------

Build a query that will answer: "On what day did the total number of deaths cross 10000 in Italy?" The query should return the date in the format **yyyy-mm-dd**.

Columns to reference:

*   country\_name
*   cumulative\_deceased

Click _Check my progress_ to verify the objective.

```sql
SELECT
date

FROM `bigquery-public-data.covid19_open_data.covid19_open_data`
WHERE 1=1
    AND country_name = 'Italy'
    AND cumulative_deceased > 10000

ORDER BY 1 ASC
```



Identifying Hotspots

Check my progress



![](https://t4668229.p.clickup-attachments.com/t4668229/281f167b-2242-4e52-a9b6-a0e9482990a5/image.png)



**Query 6: Finding days with zero net new cases**
-------------------------------------------------

The following query is written to identify the number of days in India between 21 Feb 2020 and 15 March 2020 when there were zero increases in the number of confirmed cases. However it is not executing properly. You need to update the query to complete it and obtain the result:

```sql
WITH india_cases_by_date AS (
  SELECT
    date,
    SUM(cumulative_confirmed) AS cases
  FROM
    `bigquery-public-data.covid19_open_data.covid19_open_data`
  WHERE
    country_name="India"
    AND date between '2020-02-21' and '2020-03-15'
  GROUP BY
    date
  ORDER BY
    date ASC
 )
, india_previous_day_comparison AS
(SELECT
  date,
  cases,
  LAG(cases) OVER(ORDER BY date) AS previous_day,
  cases - LAG(cases) OVER(ORDER BY date) AS net_new_cases
FROM india_cases_by_date
)
```

Click _Check my progress_ to verify the objective.







Finding days with zero net new cases

```sql
WITH india_cases_by_date AS (
  SELECT
    date,
    SUM(cumulative_confirmed) AS cases
  FROM
    `bigquery-public-data.covid19_open_data.covid19_open_data`
  WHERE
    country_name="India"
    AND date between '2020-02-21' and '2020-03-15'
  GROUP BY
    date
  ORDER BY
    date ASC
 )

, daily_comparison AS (
    SELECT
    date,
    cases,
    LAG(cases) OVER(ORDER BY date) AS previous_day,
    cases - LAG(cases) OVER(ORDER BY date) AS net_new_cases
    FROM india_cases_by_date

    ORDER BY date
)

SELECT COUNT(*) AS days
FROM daily_comparison
WHERE net_new_cases = 0
```



Check my progress



**Query 7: Doubling rate**
--------------------------

Using the previous query as a template, write a query to find out the dates on which the confirmed cases increased by more than 10% compared to the previous day (indicating doubling rate of ~ 7 days) in the US between the dates March 22, 2020 and April 20, 2020. The query needs to return the list of dates, the confirmed cases on that day, the confirmed cases the previous day, and the percentage increase in cases between the days. Use the following names for the returned fields: **Date**, **Confirmed\_Cases\_On\_Day**, **Confirmed\_Cases\_Previous\_Day** and **Percentage\_Increase\_In\_Cases**.

Click _Check my progress_ to verify the objective.



```sql
WITH india_cases_by_date AS (
  SELECT
    date,
    SUM(cumulative_confirmed) AS cases
  FROM
    `bigquery-public-data.covid19_open_data.covid19_open_data`
  WHERE
    country_name="United States of America"
    AND date between '2020-03-22' and '2020-04-20'
  GROUP BY
    date
  ORDER BY
    date ASC
 )

, daily_comparison AS (
    SELECT
    date  AS Date,
    cases AS Confirmed_Cases_On_Day,
    LAG(cases) OVER(ORDER BY date) AS Confirmed_Cases_Previous_Day,
    (cases - LAG(cases) OVER(ORDER BY date)) /LAG(cases) OVER(ORDER BY date) * 100 AS Percentage_Increase_In_Cases
    FROM india_cases_by_date
)

SELECT *
FROM daily_comparison
WHERE Percentage_Increase_In_Cases >= 10
ORDER BY date
```



Doubling rate

Check my progress



**Query 8: Recovery rate**
--------------------------

Build a query to list the recovery rates of countries arranged in descending order (limit to 10) upto the date May 10, 2020. Restrict the query to only those countries having more than 50K confirmed cases. The query needs to return the following fields: **country**, **recovered\_cases**, **confirmed\_cases**, **recovery\_rate**.

Columns to reference:

*   country\_name
*   cumulative\_confirmed
*   cumulative\_recovered

Click _Check my progress_ to verify the objective.



```sql
SELECT
country_name,
SUM(cumulative_recovered) AS recovered_cases,
SUM(cumulative_confirmed) AS confirmed_cases,
SUM(cumulative_recovered) / SUM(cumulative_confirmed) * 100 AS recovery_rate
FROM `bigquery-public-data.covid19_open_data.covid19_open_data`
WHERE 1=1
    AND date <= '2020-05-10'
    AND subregion1_name IS NOT NULL

GROUP BY 1
HAVING SUM(cumulative_confirmed) > 50000
ORDER BY recovery_rate DESC

LIMIT 10
```



Recovery rate

Check my progress



**Query 9: CDGR - Cumulative Daily Growth Rate**
------------------------------------------------

The following query is trying to calculate the CDGR on May 10, 2020(Cumulative Daily Growth Rate) for France since the day the first case was reported. The first case was reported on Jan 24, 2020. The CDGR is calculated as:

`((last_day_cases/first_day_cases)^1/days_diff)-1)`

Where :

*   `last_day_cases` is the number of confirmed cases on May 10, 2020
*   `first_day_cases` is the number of confirmed cases on Feb 02, 2020
*   `days_diff` is the number of days between Feb 02 - May 10, 2020

The query isn’t executing properly. Can you fix the error to make the query execute successfully?

```sql
WITH
  france_cases AS (
  SELECT
    date,
    SUM(cumulative_confirmed) AS total_cases
  FROM
    `bigquery-public-data.covid19_open_data.covid19_open_data`
  WHERE
    country_name="France"
    AND date IN ('2020-01-24',
      '2020-05-10')
  GROUP BY
    date
  ORDER BY
    date)
, summary as (
SELECT
  total_cases AS first_day_cases,
  LEAD(total_cases) AS last_day_cases,
  DATE_DIFF(LEAD(date) OVER(ORDER BY date),date, day) AS days_diff
FROM
  france_cases
LIMIT 1
)
select first_day_cases, last_day_cases, days_diff, SQRT((last_day_cases/first_day_cases),(1/days_diff))-1 as cdgr
from summary
```

**Note:** Refer to the following [page](https://cloud.google.com/bigquery/docs/reference/standard-sql/functions-and-operators) to learn more about the SQL function referenced `LEAD()`.

Click _Check my progress_ to verify the objective.



```sql
WITH
  france_cases AS (
    SELECT
        date,
        SUM(IF(date = '2020-02-02', cumulative_confirmed, 0)) AS first_day_cases,
        SUM(IF(date = '2020-05-10', cumulative_confirmed, 0)) AS last_day_cases,
        DATE_DIFF('2020-05-10', '2020-02-02', day) AS days_diff,
        SUM(cumulative_confirmed) AS total_cases
    FROM
        `bigquery-public-data.covid19_open_data.covid19_open_data`
    WHERE
        country_name="France"
        AND date IN ('2020-02-02','2020-05-10')
    GROUP BY
        date
    ORDER BY
        date
    )


, summary as (
    SELECT
    SUM(first_day_cases) AS first_day_cases,
    SUM(last_day_cases) AS last_day_cases,
    MIN(days_diff) AS days_diff

    FROM
    france_cases
)



SELECT
first_day_cases,
last_day_cases,
days_diff,
--SQRT(last_day_cases/first_day_cases),1/days_diff)-1 as cdgr,
--((last_day_cases/first_day_cases)^1/days_diff)-1) AS cdgr

--last_day_cases/first_day_cases,
POW(last_day_cases/first_day_cases,1/days_diff) - 1 AS cdgr

FROM summary
```



CDGR - Cumulative Daily Growth Rate

Check my progress



**Create a Datastudio report**
------------------------------

Create a Datastudio report that plots the following for the United States:

*   Number of Confirmed Cases
*   Number of Deaths
*   Date range : 2020-03-15 to 2020-04-30

Click _Check my progress_ to verify the objective.



Create a Datastudio report

Check my progress



**Hint:** Use the below image as a reference while building the report and make sure your report matches it.

![](https://cdn.qwiklabs.com/JHIWj6ObPVnrYKeTANbhaWLBtwvMUWOR5a5beYdhYaU%3D)



```sql
SELECT
date,
SUM(cumulative_deceased) AS country_deaths,
SUM(cumulative_confirmed) AS country_cases
FROM `bigquery-public-data.covid19_open_data.covid19_open_data`
WHERE 1=1
    AND country_name = 'United States of America'
    AND date BETWEEN '2020-03-15' AND '2020-04-30'

GROUP BY 1
```

![](https://t4668229.p.clickup-attachments.com/t4668229/98befe3b-1f50-4f8c-9126-1f01078b5d8f/image.png)
-------------------------------------------------------------------------------------------------------



---

**Congratulations!**
====================

In this lab you used BigQuery to query the public Covid dataset (`bigquery-public-data.covid19_open_data.covid19_open_data`) to answer important questions related to the Covid-19 pandemic. You also created a Datastudio report for one of the query outputs to visualize the cases and deaths trend.

![](https://cdn.qwiklabs.com/2jHPENpYEfqE1og5Wg59yUM6AOLskKEQZ7hYK%2FkQFpw%3D)
