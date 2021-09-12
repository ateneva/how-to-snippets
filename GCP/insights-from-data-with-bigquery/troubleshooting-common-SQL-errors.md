👉 **Find the total number of customers who went through checkout**
-------------------------------------------------------------------

Your goal in this section is to construct a query that gives you the number of unique visitors who successfully went through the checkout process for your website. The data is in the rev\_transactions table which your data analyst team has provided. They have also given you example queries to help you get started in your analysis but you're not sure they're written correctly.

### Troubleshoot queries that contain query validator, alias, and comma errors

Look at the below query and answer the following question:

```sql
#standardSQL
SELECT  FROM `data-to-inghts.ecommerce.rev_transactions`
LIMIT 1000
```





What's wrong with the previous query to view 1000 items?

![](https://t4668229.p.clickup-attachments.com/t4668229/47d6b95f-eb03-490f-af74-6c23bf7e7fba/image.png)





What about this updated query?

```sql
#standardSQL
SELECT * FROM [data-to-insights:ecommerce.rev_transactions]
LIMIT 1000
```

![](https://t4668229.p.clickup-attachments.com/t4668229/9652813e-06c3-4d09-90a9-c39af6064e38/image.png)





What about this query that uses Standard SQL?

```sql
#standardSQL
SELECT FROM `data-to-insights.ecommerce.rev_transactions`
```



![](https://t4668229.p.clickup-attachments.com/t4668229/b4f12012-8cf8-4003-8a63-a245a76156b7/image.png)



What about now? This query has a column.

```sql
#standardSQL
SELECT
fullVisitorId
FROM `data-to-insights.ecommerce.rev_transactions`
```



![](https://t4668229.p.clickup-attachments.com/t4668229/067d7fb2-bc5d-4622-b105-3ccc8d3e9d9a/image.png)





What about now? The following query has a page title.

```sql
#standardSQL
SELECT fullVisitorId hits_page_pageTitle
FROM `data-to-insights.ecommerce.rev_transactions` LIMIT 1000
```



How many columns will the previous query return?



![](https://t4668229.p.clickup-attachments.com/t4668229/d71d34dc-7dfe-46ab-9789-d3bc2d4fbe3f/image.png)



What about now? The missing comma has been corrected.

```sql
#standardSQL
SELECT
  fullVisitorId
  , hits_page_pageTitle
FROM `data-to-insights.ecommerce.rev_transactions`
LIMIT 1000
```

Answer: This returns results, but are you sure visitors aren't counted twice? Also, returning only one row answers the question of how many unique visitors reached checkout. In the next section you find a way to aggregate your results.

###   

### 👉 Troubleshoot queries that contain logic errors, GROUP BY statements, and wildcard filters

Aggregate the following query to answer the question: How many unique visitors reached checkout?

```sql
#standardSQL
SELECT
  fullVisitorId
  , hits_page_pageTitle
FROM `data-to-insights.ecommerce.rev_transactions` LIMIT 1000
```



What about this? An aggregation function, `COUNT()`, was added.

```sql
#standardSQL
SELECT
COUNT(fullVisitorId) AS visitor_count
, hits_page_pageTitle
FROM `data-to-insights.ecommerce.rev_transactions`
```



![](https://t4668229.p.clickup-attachments.com/t4668229/fb3775f9-4fe1-4a03-b344-b5b2178dd5a0/image.png)





In this next query, `GROUP BY` and `DISTINCT` statements were added.

```sql
#standardSQL
SELECT
COUNT(DISTINCT fullVisitorId) AS visitor_count
, hits_page_pageTitle
FROM `data-to-insights.ecommerce.rev_transactions`
GROUP BY hits_page_pageTitle
```

**Results** ![](https://cdn.qwiklabs.com/FzJZtAjvjDEY1U4dFGx5KLbaBpTBgOoMuoL4RbGuKlo%3D)

Great! The results are good, but they look strange. Filter to just "Checkout Confirmation" in the results.

```sql
#standardSQL
SELECT
COUNT(DISTINCT fullVisitorId) AS visitor_count
, hits_page_pageTitle
FROM `data-to-insights.ecommerce.rev_transactions`
WHERE hits_page_pageTitle = "Checkout Confirmation"
GROUP BY hits_page_pageTitle
```

Click _Check my progress_ to verify the objective.





👉 **List the cities with the most transactions with your ecommerce site**
--------------------------------------------------------------------------

### Troubleshoot ordering, calculated fields, and filtering after aggregating errors

Complete the partially written query:

```sql
SELECT
geoNetwork_city,
totals_transactions,
COUNT( DISTINCT fullVisitorId) AS distinct_visitors
FROM
`data-to-insights.ecommerce.rev_transactions`
GROUP BY
```

**Possible solution**

```sql
#standardSQL
SELECT
geoNetwork_city,
SUM(totals_transactions) AS totals_transactions,
COUNT( DISTINCT fullVisitorId) AS distinct_visitors
FROM
`data-to-insights.ecommerce.rev_transactions`
GROUP BY geoNetwork_city
```

Update your previous query to order the top cities first.





Which city had the most distinct visitors? Ignore the value: 'not available in this demo dataset'



![](https://t4668229.p.clickup-attachments.com/t4668229/6add79fd-fcfe-47ec-adb8-18826d94480e/image.png)



**Possible solution**

```sql
#standardSQL
SELECT
geoNetwork_city,
SUM(totals_transactions) AS totals_transactions,
COUNT( DISTINCT fullVisitorId) AS distinct_visitors
FROM
`data-to-insights.ecommerce.rev_transactions`
GROUP BY geoNetwork_city
ORDER BY distinct_visitors DESC
```



Update your query and create a new calculated field to return the average number of products per order by city.

**Possible solution**

```sql
#standardSQL
SELECT
geoNetwork_city,
SUM(totals_transactions) AS total_products_ordered,
COUNT( DISTINCT fullVisitorId) AS distinct_visitors,
SUM(totals_transactions) / COUNT( DISTINCT fullVisitorId) AS avg_products_ordered
FROM
`data-to-insights.ecommerce.rev_transactions`
GROUP BY geoNetwork_city
ORDER BY avg_products_ordered DESC
```

**Results**

![](https://cdn.qwiklabs.com/zP3Or2c9FCp15knqC%2FSGDnypux2I7P9s9jIwBeUa2Bg%3D)

Filter your aggregated results to only return cities with more than 20 avg\_products\_ordered.



What's wrong with the following query?

```sql
#standardSQL
SELECT
geoNetwork_city,
SUM(totals_transactions) AS total_products_ordered,
COUNT( DISTINCT fullVisitorId) AS distinct_visitors,
SUM(totals_transactions) / COUNT( DISTINCT fullVisitorId) AS avg_products_ordered
FROM
`data-to-insights.ecommerce.rev_transactions`
WHERE avg_products_ordered > 20
GROUP BY geoNetwork_city
ORDER BY avg_products_ordered DESC
```





What is wrong with the previous query?



![](https://t4668229.p.clickup-attachments.com/t4668229/0c68c95f-0ca2-489a-821b-50f8861435a3/image.png)



**Possible solution**

```sql
#standardSQL
SELECT
geoNetwork_city,
SUM(totals_transactions) AS total_products_ordered,
COUNT( DISTINCT fullVisitorId) AS distinct_visitors,
SUM(totals_transactions) / COUNT( DISTINCT fullVisitorId) AS avg_products_ordered
FROM
`data-to-insights.ecommerce.rev_transactions`
GROUP BY geoNetwork_city
HAVING avg_products_ordered > 20
ORDER BY avg_products_ordered DESC
```

Click _Check my progress_ to verify the objective.



List the cities with the most transactions with your ecommerce site

Check my progress



```sql
#standardSQL
SELECT
geoNetwork_city,
--SUM(totals_transactions) AS total_products_ordered,
--COUNT( DISTINCT fullVisitorId) AS distinct_visitors,
SUM(totals_transactions) / COUNT( DISTINCT fullVisitorId) AS avg_products_ordered
FROM
`data-to-insights.ecommerce.rev_transactions`
GROUP BY geoNetwork_city
ORDER BY avg_products_ordered DESC
```



![](https://t4668229.p.clickup-attachments.com/t4668229/18d68b6f-dd30-483a-87db-082e00bf9761/image.png)



👉 **Find the total number of products in each product category**
-----------------------------------------------------------------

### Find the top selling products by filtering with NULL values

What's wrong with the following query? How can you fix it?

```sql
#standardSQL
SELECT hits_product_v2ProductName, hits_product_v2ProductCategory
FROM `data-to-insights.ecommerce.rev_transactions`
GROUP BY 1,2
```



What is wrong with the previous query?



![](https://t4668229.p.clickup-attachments.com/t4668229/8b9f5e6e-d3f0-4b02-a757-0fa38abb77e1/image.png)





What is wrong with the following query?

```sql
#standardSQL
SELECT
COUNT(hits_product_v2ProductName) as number_of_products,
hits_product_v2ProductCategory
FROM `data-to-insights.ecommerce.rev_transactions`
WHERE hits_product_v2ProductName IS NOT NULL
GROUP BY hits_product_v2ProductCategory
ORDER BY number_of_products DESC
```



What is wrong with the previous query which lists products?

![](https://t4668229.p.clickup-attachments.com/t4668229/d0b1603b-a324-4782-9b24-54c917d1e7c0/image.png)



Update the previous query to only count distinct products in each product category.

**Possible solution**

```sql
#standardSQL
SELECT
COUNT(DISTINCT hits_product_v2ProductName) as number_of_products,
hits_product_v2ProductCategory
FROM `data-to-insights.ecommerce.rev_transactions`
WHERE hits_product_v2ProductName IS NOT NULL
GROUP BY hits_product_v2ProductCategory
ORDER BY number_of_products DESC
LIMIT 5
```





Which category has the most distinct number of products offered?

![](https://t4668229.p.clickup-attachments.com/t4668229/776456b4-86d6-4304-a91b-f923b2191115/image.png)




⚠️ Notes:

*   (not set) could indicate the product has no category
*   ${productitem.product.origCatName} is front-end code to render the category which may indicate the Google Analytics tracking script is firing before the page is fully-rendered

Click _Check my progress_ to verify the objective.



Find the total number of products in each product category

Check my progress



**Congratulations!**
--------------------

You troubleshot and fixed broken queries in BigQuery standard SQL. Remember to use the Query Validator for incorrect query syntax but also to be critical of your query results even if your query executes successfully.

![](https://cdn.qwiklabs.com/4ONtHbbEjhk1Kg0YoTflkUukkw2pn6r3rUVU6ES1TF4%3D)
