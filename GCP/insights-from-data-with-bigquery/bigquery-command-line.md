👉 **Examine a table**
----------------------

BigQuery offers a number of [sample tables](https://cloud.google.com/bigquery/public-data#sample_tables) that you can run queries against. In this lab, you'll run queries against the `shakespeare` table, which contains an entry for every word in every play.



To examine the schema of the Shakespeare table in the samples dataset, run:

```bash
bq show bigquery-public-data:samples.shakespeare
```

In this command you're doing the following:

*   `bq` to invoke the BigQuery command line tool
*   `show` is the action
*   then you're listing the name of the `project:public dataset.table` in BigQuery that you want to see.



Output:

```plain
   Last modified                  Schema                 Total Rows   Total Bytes   Expiration   Time Partitioning   Clustered Fields   Labels----------------- ------------------------------------ ------------ ------------- ------------ ------------------- ------------------ --------14 Mar 13:16:45   |- word: string (required)           164656       6432064|- word_count: integer (required)|- corpus: string (required)|- corpus_date: integer (required)content_copy
```



---

![](https://t4668229.p.clickup-attachments.com/t4668229/4b285c79-1e02-4ffb-9fa5-dc2bb23bd7cb/image.png)



👉 **Run the help command**
---------------------------

When you include a command name with the help commands, you get information about that specific command. For example, the following call to `bq help` retrieves information about the `query` command.

```bash
bq help query
```

To see a list of all of the commands `bq` uses, run just `bq help`.



---

👉 **Run a query**
------------------

Now you'll run a query to see how many times the substring "raisin" appears in Shakespeare's works.

To run a query, run the command `bq query "[SQL_STATEMENT]"`.

*   Escape any quotation marks inside the \[SQL\_STATEMENT\] with a \\ mark, or
*   Use a different quotation mark type than the surrounding marks ("versus").



Run the following standard SQL query in Cloud Shell to count the number of times that the substring "raisin" appears in all of Shakespeare's works:

```sql
bq query --use_legacy_sql=false \
'SELECT
   word,
   SUM(word_count) AS count
 FROM
   `bigquery-public-data`.samples.shakespeare
 WHERE
   word LIKE "%raisin%"
 GROUP BY
   word'
```

In this command:

*   `--use_legacy_sql=false` makes standard SQL the default query syntax



Output:

```plain
Waiting on job_e19 ... (0s) Current status: DONE
+---------------+-------+|     word      | count |+---------------+-------+| praising      |     8 || Praising      |     4 || raising       |     5 || dispraising   |     2 || dispraisingly |     1 || raisins       |     1 |content_copy
```

The table demonstrates that although the actual word **raisin** doesn't appear, the letters appear in order in several of Shakespeare's works.

####   

![](https://t4668229.p.clickup-attachments.com/t4668229/ae221df4-39a1-4e4a-81d0-2fde5fdfdf42/image.png)





If you search for a word that isn't in Shakespeare's works, no results are returned.

Run following search for "huzzah", returns no matches:

```sql
bq query --use_legacy_sql=false \
'SELECT
   word
 FROM
   `bigquery-public-data`.samples.shakespeare
 WHERE
   word = "huzzah"'
```

####   

![](https://t4668229.p.clickup-attachments.com/t4668229/42051e7b-ab55-4555-9d31-097d0df0b9e5/image.png)



👉 **Create a new table**
-------------------------

Now create your own table. Every table is stored inside a dataset. A _dataset_ is a group of resources, such as tables and views.

### **Create a new dataset**

Use the `bq ls` command to list any existing datasets in your project:

```bash
bq ls
```



You will be brought back to the command line since there aren't any datasets in your project yet.



Run `bq ls` and the `bigquery-public-data` Project ID to list the datasets in that specific project, followed by a colon (:).

```bash
bq ls bigquery-public-data:
```



Output:

```plain
           datasetId
 -----------------------------
  austin_311
  austin_bikeshare
  austin_crime
  austin_incidents
  austin_waste
  baseball
  bitcoin_blockchain
  bls
  census_bureau_construction
  census_bureau_international
  census_bureau_usa
  census_utility
  chicago_crime
  ...content_copy
```



![](https://t4668229.p.clickup-attachments.com/t4668229/272e4d6c-26c7-41bc-8db1-fc77d6c69fae/image.png)



Now create a dataset. A dataset name can be up to 1,024 characters long, and consist of A-Z, a-z, 0-9, and the underscore, but it cannot start with a number or underscore, or have spaces.



Use the `bq mk` command to create a new dataset named `babynames` in your Qwiklabs project:

```bash
bq mk babynames
```



Sample output:

```plain
Dataset 'qwiklabs-gcp-ba3466847fe3cec0:babynames' successfully created.content_copy
```



![](https://t4668229.p.clickup-attachments.com/t4668229/7e743190-64da-41de-bfed-db1c0d445ab0/image.png)



Run `bq ls` to confirm that the dataset now appears as part of your project:

```bash
bq ls
```

Sample output:

```plain
 datasetId
 -------------
 babynames
```

###   

![](https://t4668229.p.clickup-attachments.com/t4668229/2c210a42-d1a0-4095-8241-11eb365e4fad/image.png)



### 👉 **Upload the dataset**

Before you can build the table, you need to add the dataset to your project. The custom data file you'll use contains approximately 7 MB of data about popular baby names, provided by the US Social Security Administration.

Run this command to add the [baby names zip file](http://www.ssa.gov/OACT/babynames/names.zip) to your project, using the URL for the data file:

```bash
wget http://www.ssa.gov/OACT/babynames/names.zip
```

List the file:

```bash
ls
```



You can see the name of the file added to your project.

Now unzip the file:

```bash
unzip names.zip
```

That's a pretty big list of text files! List the files again:

```bash
ls
```



ℹ️ The `bq load` command creates or updates a table and loads data in a single step.

You will use the bq load command to load your source file into a new table called names2010 in the babynames dataset you just created. By default, this runs synchronously, and will take a few seconds to complete.



The `bq load` arguments you'll be running are:

```bash
datasetID: babynames
tableID: names2010
source: yob2010.txt
schema: name:string,gender:string,count:integer
```



Create your table:

```bash
bq load babynames.names2010 yob2010.txt name:string,gender:string,count:integer
```



Sample output:

```plain
Waiting on job_4f0c0878f6184119abfdae05f5194e65 ... (35s) Current status: DONEcontent_copy
```

![](https://t4668229.p.clickup-attachments.com/t4668229/79e652a4-68b2-45e1-ad14-95732e4d3a6e/image.png)



Run `bq ls` and `babynames` to confirm that the table now appears in your dataset:

```bash
bq ls babynames
```

Output:

```plain
  tableId    Type----------- -------
  names2010   TABLE
```



Run `bq show` and your `dataset.table` to see the schema:

```bash
bq show babynames.names2010
```



Output:

```plain
   Last modified         Schema         Total Rows   Total Bytes     Expiration      Time Partitioning   Clustered Fields   Labels----------------- ------------------- ------------ ------------- ----------------- ------------------- ------------------ --------13 Aug 14:37:34   |- name: string     34073        654482        12 Oct 14:37:34|- gender: string
                    |- count: integercontent_copy
```



![](https://t4668229.p.clickup-attachments.com/t4668229/5dc83556-cdd0-4018-9151-aa0b4542d433/image.png)



By default, when you load data, BigQuery expects UTF-8 encoded data. If you have data that is in ISO-8859-1 (or Latin-1) encoding and are having problems with your loaded data, you can tell BigQuery to treat your data as Latin-1 explicitly, using the `-E` flag. For more information, see [Character Encodings](https://cloud.google.com/bigquery/docs/loading-data).



---

👉 **Run queries**
------------------

Now you're ready to query the data and return some interesting results.

Run the following command to return the top 5 most popular girls names:

```bash
bq query "SELECT name,count FROM babynames.names2010 WHERE gender = 'F' ORDER BY count DESC LIMIT 5"
```



Output:

```plain
Waiting on job_58c0f5ca52764ef1902eba611b71c651 ... (0s) Current status: DONE
+----------+-------+|   name   | count |+----------+-------+| Isabella | 22913 || Sophia   | 20643 || Emma     | 17345 || Olivia   | 17028 || Ava      | 15433 |+----------+-------+content_copy
```



![](https://t4668229.p.clickup-attachments.com/t4668229/c6a8772c-0089-4263-9655-11ee3cf71afd/image.png)



Run the following command to see the top 5 most unusual boys names.

```bash
bq query "SELECT name,count FROM babynames.names2010 WHERE gender = 'M' ORDER BY count ASC LIMIT 5"
```

**Note**: The minimum count is 5 because the source data omits names with fewer than 5 occurrences.



Output:

```plain
Waiting on job_556ba2e5aad340a7b2818c3e3280b7a3 ... (1s) Current status: DONE
+----------+-------+|   name   | count |+----------+-------+| Aaqib    |     5 || Aaidan   |     5 || Aadhavan |     5 || Aarian   |     5 || Aamarion |     5 |+----------+-------+content_copy
```

####   

![](https://t4668229.p.clickup-attachments.com/t4668229/3f418839-923e-4848-8bb1-413b01f84fde/image.png)



**Test your Understanding**
---------------------------

Below are multiple choice questions to reinforce your understanding of this lab's concepts. Answer them to the best of your abilities.



![](https://t4668229.p.clickup-attachments.com/t4668229/805d377d-44ea-4515-b045-a2cd30c056b8/image.png)



![](https://t4668229.p.clickup-attachments.com/t4668229/e765d1b1-f24e-4c46-98d8-dc59123eaa15/image.png)



👉 **Clean up**
---------------

Run the `bq rm` command to remove the `babynames` dataset with the `-r` flag to delete all tables in the dataset.

```bash
bq rm -r babynames
```



**Congratulations!**
--------------------

Now you can use the command line with BigQuery to manipulate data.

![](https://cdn.qwiklabs.com/N%2BCij%2BCEclXk%2FeuQiZ0N56%2F%2BHXzYPSXML5URkE%2B%2Bp2A%3D) ![](https://cdn.qwiklabs.com/jAnA2n029sN72whRZDiRuCPhN%2BJ1HBGQ8ERZBekLCMw%3D) ![](https://cdn.qwiklabs.com/4ONtHbbEjhk1Kg0YoTflkUukkw2pn6r3rUVU6ES1TF4%3D) ![](https://cdn.qwiklabs.com/zTElq%2B6%2F9Fl9puC3rQKGKZfxrng9WeK0wGuVxwakC4U%3D)
