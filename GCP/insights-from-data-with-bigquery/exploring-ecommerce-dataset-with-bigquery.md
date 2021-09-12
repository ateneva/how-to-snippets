

1.  BigQuery public datasets are not displayed by default in the BigQuery web UI. To open the public datasets project, open [https://console.cloud.google.com/bigquery?project=data-to-insights&page=ecommerce](https://console.cloud.google.com/bigquery?project=data-to-insights&page=ecommerce) in a new browser window.
2.  In the left pane, in the Explorer section, hover over on **data-to-insights** and click on **Click to pin** icon.

![](https://cdn.qwiklabs.com/58kSiNQXhhpS7to6rnl%2BSHLy5pPwj0OdfRNGfn4O%2B%2BY%3D)

1.  Close this browser window.
2.  Return to and refresh the first BigQuery browser window to refresh the BigQuery web UI.

The `data-to-insights` project is listed in the Explorer section.





**Explore ecommerce data and identify duplicate records**
---------------------------------------------------------

**Scenario**: Your data analyst team exported the Google Analytics logs for an ecommerce website into BigQuery and created a new table of all the raw ecommerce visitor session data.

Explore the `all_sessions_raw` table data:

1.  Click the **Expand node** icon near **data-to-insights** to expand the project.
2.  Expand **ecommerce**.
3.  Click **all\_sessions\_raw**.

In the right pane, a section opens that provides 3 views of the table data:

*   Schema tab: Field name, Type, Mode, and Description; the logical constraints used to organize the data
*   Details tab: Table metadata
*   Preview tab: Table preview
*   Click the **Details** tab to view the table metadata.

![](https://cdn.qwiklabs.com/zgN%2F5UKN%2FeHS0zwuVer48al3SX2xoJdysBhVWbNpC48%3D)

Questions:



![](https://t4668229.p.clickup-attachments.com/t4668229/e9dbed1e-177b-4bf3-a1c8-233ed15658a6/image.png)



### Identify duplicate rows

Seeing a sample amount of data may give you greater intuition for what is included in the dataset. To preview sample rows from the table without using SQL, click the **preview** tab.

Scan and scroll through the rows. There is no singular field that uniquely identifies a row, so you need advanced logic to identify duplicate rows.

The query you'll use (below) uses the SQL `GROUP BY` function on every field and counts (`COUNT`) where there are rows that have the same values across every field.

*   If every field is unique, the `COUNT` returns 1 as there are no other groupings of rows with the exact same value for all fields.
*   If there are multiple rows with the same values for all fields, these rows are grouped together and the `COUNT` will be greater than 1.

The last part of the query is an aggregation filter using `HAVING` to only show the results that have a `COUNT` of duplicates greater than 1. Therefore, the number of records that have duplicates will be the same as the number of rows in the resulting table.



Copy and paste the following query into the query **EDITOR**, then **RUN** query to find which records are duplicated across all columns.

```sql
#standardSQL
SELECT COUNT(*) as num_duplicate_rows, *
FROM
`data-to-insights.ecommerce.all_sessions_raw`
GROUP BY
fullVisitorId, channelGrouping, time, country, city, totalTransactionRevenue, transactions, timeOnSite, pageviews, sessionQualityDim, date, visitId, type, productRefundAmount, productQuantity, productPrice, productRevenue, productSKU, v2ProductName, v2ProductCategory, productVariant, currencyCode, itemQuantity, itemRevenue, transactionRevenue, transactionId, pageTitle, searchKeyword, pagePathLevel1, eCommerceAction_type, eCommerceAction_step, eCommerceAction_option
HAVING num_duplicate_rows > 1;
```



![](https://t4668229.p.clickup-attachments.com/t4668229/76d479b8-a1ec-47f1-95d0-5b07f2235a57/image.png)



### 👉 Analyze the new `all_sessions` table

In this section you use a deduplicated table called `all_sessions`.

**Scenario:** Your data analyst team has provided you with this query, and your schema experts have identified the key fields that must be unique for each record per your [schema](https://support.google.com/analytics/answer/3437719?hl=en).



Run the query to confirm that no duplicates exist, this time in the `all_sessions` table:

```sql
#standardSQL
# schema: https://support.google.com/analytics/answer/3437719?hl=en
SELECT
fullVisitorId, # the unique visitor ID
visitId, # a visitor can have multiple visits
date, # session date stored as string YYYYMMDD
time, # time of the individual site hit  (can be 0 to many per visitor session)
v2ProductName, # not unique since a product can have variants like Color
productSKU, # unique for each product
type, # a visitor can visit Pages and/or can trigger Events (even at the same time)
eCommerceAction_type, # maps to ‘add to cart', ‘completed checkout'
eCommerceAction_step,
eCommerceAction_option,
transactionRevenue, # revenue of the order
transactionId, # unique identifier for revenue bearing transaction
COUNT(*) as row_count
FROM
`data-to-insights.ecommerce.all_sessions`
GROUP BY 1,2,3 ,4, 5, 6, 7, 8, 9, 10,11,12
HAVING row_count > 1 # find duplicates
```



The query returns zero records.

Note: In SQL, you can GROUP BY or ORDER BY the index of the column like using "GROUP BY 1" instead of "GROUP BY fullVisitorId"



---

👉 **Write basic SQL on ecommerce data**
----------------------------------------

In this section, you query for insights on the ecommerce dataset.

###   

### Write a query that shows total unique visitors

Your query determines the total views by counting `product_views` and the number of unique visitors by counting `fullVisitorID`.

1.  Click **\+ Compose New Query**.
2.  Write this query in the editor:

```sql
#standardSQL
SELECT
COUNT(*) AS product_views,
COUNT(DISTINCT fullVisitorId) AS unique_visitors
FROM `data-to-insights.ecommerce.all_sessions`;
```

1.  To ensure that your syntax is correct, click the real-time query validator icon.
2.  Click **Run**. Read the results to view the number of unique visitors.

**Results**

![](https://cdn.qwiklabs.com/b9ovF5bGPVLOoKS%2BnA%2FrEgafl9kpnMwY6TysHCDm4S4%3D)

Now write a query that shows total unique visitors(`fullVisitorID`) by the referring site (`channelGrouping`):

```sql
#standardSQL
SELECT
COUNT(DISTINCT fullVisitorId) AS unique_visitors,
channelGrouping
FROM `data-to-insights.ecommerce.all_sessions`
GROUP BY channelGrouping
ORDER BY channelGrouping DESC;
```

**Results**

![](https://cdn.qwiklabs.com/5yLYag64%2F5mEVHBVMo2dExnIBdJm6CZaX%2Bt6IpBOiZ8%3D)

Write a query to list all the unique product names (`v2ProductName`) alphabetically:

```sql
#standardSQL
SELECT
(v2ProductName) AS ProductName
FROM `data-to-insights.ecommerce.all_sessions`
GROUP BY ProductName
ORDER BY ProductName
```

Tip: In SQL, the ORDER BY clauses defaults to Ascending (ASC) A-->Z. If you want the reverse, try ORDER BY field\_name DESC







**Results**

![](https://cdn.qwiklabs.com/a9r%2BBTU44UmfC%2BqIFPlvtV8txzfwjy%2Fbw%2Ft%2Bt1a9rtA%3D)

This query returns a total of 633 products (rows).









Write a query to list the five products with the most views (`product_views`) from all visitors (include people who have viewed the same product more than once). Your query counts number of times a product (`v2ProductName`) was viewed (`product_views`), puts the list in descending order, and lists the top 5 entries:

Tip: In Google Analytics, a visitor can "view" a product during the following interaction types: 'page', 'screenview', 'event', 'transaction', 'item', 'social', 'exception', 'timing'. For our purposes, simply filter for only type = 'PAGE'.

```sql
#standardSQL
SELECT
COUNT(*) AS product_views,
(v2ProductName) AS ProductName
FROM `data-to-insights.ecommerce.all_sessions`
WHERE type = 'PAGE'
GROUP BY v2ProductName
ORDER BY product_views DESC
LIMIT 5;
```



**Results**

![](https://cdn.qwiklabs.com/Dp5bJkC1CaWW15SKsX%2BasfL9o%2BZdwJyqRp%2Fmmz9UZCM%3D)



Bonus: Now refine the query to no longer double-count product views for visitors who have viewed a product many times. Each distinct product view should only count once per visitor.

```sql
WITH unique_product_views_by_person AS (
-- find each unique product viewed by each visitor
SELECT
fullVisitorId,
(v2ProductName) AS ProductName
FROM `data-to-insights.ecommerce.all_sessions`
WHERE type = 'PAGE'
GROUP BY fullVisitorId, v2ProductName )
-- aggregate the top viewed products and sort them
SELECT
COUNT(*) AS unique_view_count,
ProductName
FROM unique_product_views_by_person
GROUP BY ProductName
ORDER BY unique_view_count DESC
LIMIT 5
```



Tip: You can use the SQL `WITH` clause to help break apart a complex query into multiple steps. Here we first create a query that finds each unique product per visitor and counts them once. Then the second query performs the aggregation across all visitors and products.

**Results**

![](https://cdn.qwiklabs.com/dCnyVqvi2oJW3NEkyn7WlMFH0ms1AqMhyqYPzScFrhI%3D)



Next, expand your previous query to include the total number of distinct products ordered and the total number of total units ordered (`productQuantity`):

```sql
#standardSQL
SELECT
COUNT(*) AS product_views,
COUNT(productQuantity) AS orders,
SUM(productQuantity) AS quantity_product_ordered,
v2ProductName
FROM `data-to-insights.ecommerce.all_sessions`
WHERE type = 'PAGE'
GROUP BY v2ProductName
ORDER BY product_views DESC
LIMIT 5;
```

**Results**

![](https://cdn.qwiklabs.com/W%2F67Ixjhx2pRKqCouMLAHX8SopFWTH385fyL3wnNQYQ%3D)





Expand the query to include the average amount of product per order (total number of units ordered/total number of orders, or `SUM(productQuantity)`/`COUNT(productQuantity)`).



```sql
#standardSQL
SELECT
COUNT(*) AS product_views,
COUNT(productQuantity) AS orders,
SUM(productQuantity) AS quantity_product_ordered,
SUM(productQuantity) / COUNT(productQuantity) AS avg_per_order,
(v2ProductName) AS ProductName
FROM `data-to-insights.ecommerce.all_sessions`
WHERE type = 'PAGE'
GROUP BY v2ProductName
ORDER BY product_views DESC
LIMIT 5;
```

**Results**

![](https://cdn.qwiklabs.com/ejtIxUgah3U1CgfZc8wXctd6wAHJIA4N%2FkS5n9OHg9g%3D)



**Congratulations!**
--------------------

This concludes exploring the data-to-insights ecommerce dataset! You used BigQuery to view and query the data to gain meaningful insight on various aspects of product marketing.

![](https://cdn.qwiklabs.com/y9QXRRi9yHi5aXcol6Raj4ZMQPSp2MvvNljLavOWJAY%3D) ![](https://cdn.qwiklabs.com/4ONtHbbEjhk1Kg0YoTflkUukkw2pn6r3rUVU6ES1TF4%3D)
