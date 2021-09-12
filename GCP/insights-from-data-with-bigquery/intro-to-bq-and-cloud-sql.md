**Working with Cloud SQL**
--------------------------

### Exporting queries as CSV files

[Cloud SQL](https://cloud.google.com/sql/) is a fully-managed database service that makes it easy to set up, maintain, manage, and administer your relational PostgreSQL and MySQL databases in the cloud. There are two formats of data accepted by Cloud SQL: dump files (.sql) or CSV files (.csv). You will learn how to export subsets of the `cycle_hire` table into CSV files and upload them to Cloud Storage as an intermediate location.



Back in the BigQuery Console, this should have been the last command that you ran:

```sql
SELECT
  start_station_name,
  COUNT(*) AS num
FROM `bigquery-public-data.london_bicycles.cycle_hire`
GROUP BY start_station_name
ORDER BY num DESC;
```



In the Query Results section click **SAVE RESULTS** > **CSV(local file)** > **SAVE**. This initiates a download, which saves this query as a CSV file. Note the location and the name of this downloaded file—you will need it soon.



Clear the query EDITOR, then copy and run the following in the query editor:

```sql
SELECT
  end_station_name,
  COUNT(*) AS num
FROM `bigquery-public-data.london_bicycles.cycle_hire`
GROUP BY end_station_name
ORDER BY num DESC;
```



This will return a table that contains the number of bikeshare rides that finish in each ending station and is organized numerically from highest to lowest number of rides. You should receive the following output:

![](https://cdn.qwiklabs.com/mAesoVBfXplwi1b5bh1nIRILSAi7%2FBbebkAhpzb2CZ4%3D)

In the Query Results section click **SAVE RESULTS** > **CSV(local file)** > **SAVE**. This initiates a download, which saves this query as a CSV file. Note the location and the name of this downloaded file—you will need it in the following section.

### Upload CSV files to Cloud Storage

Go to the Cloud Console where you'll create a storage bucket where you can upload the files you just created.

Select **Navigation menu** > **Cloud Storage** > **Browser**, and then click **CREATE BUCKET**.

**Note**: If prompted, Click **LEAVE** for Unsaved work.

Enter a unique name for your bucket, keep all other settings as default, and click **Create**:

![](https://cdn.qwiklabs.com/MJaLpJcY4bF7yM0I4XC%2BlzCe3F32kXqqayPLGZ5vK4Q%3D)

###   

You should now be in the Cloud Console looking at your newly created Cloud Storage Bucket.

Click **UPLOAD FILES** and select the CSV that contains `start_station_name` data. Then click **Open**. Repeat this for the `end_station_name` data.

Rename your `start_station_name` file by clicking on the three dots next to on the far side of the file and click **rename**. Rename the file to `start_station_data.csv`.

Rename your `end_station_name` file by clicking on the three dots next to on the far side of the file and click **rename**. Rename the file to `end_station_data.csv`.



Your bucket should now resemble the following:

![](https://cdn.qwiklabs.com/O0gGDUAw3%2BKFgvwpeQvYtmRFgfAlChH09mZMXpztL%2FM%3D)

###   

### Create a Cloud SQL instance

In the console, select **Navigation menu** > **SQL**.

Click **CREATE INSTANCE**.

From here, you will be prompted to choose a database engine. Select **MySQL**.

Now enter in a name for your instance (like "qwiklabs-demo") and enter a secure password in the **Password** field (remember it!), then click **CREATE INSTANCE**:

![](https://cdn.qwiklabs.com/jEQp9s17PAnAroCuUnmNo1ag945miqt%2BwTa%2FrsjoQ50%3D)

It might take a few minutes for the instance to be created. Once it is, you will see a green checkmark next to the instance name.

Click on the Cloud SQL instance. You should now be on a page that resembles the following:

![](https://cdn.qwiklabs.com/prYd56hM7k4hZgCBy7WAIxZsvTpgq8E3zbMWEURRn1s%3D)

###   



* * *





**New Queries in Cloud SQL**
----------------------------

### CREATE keyword (databases and tables)

Now that you have a Cloud SQL instance up and running, create a database inside of it using the Cloud Shell Command Line.

###   

### Activate Cloud Shell

Cloud Shell is a virtual machine that is loaded with development tools. It offers a persistent 5GB home directory and runs on the Google Cloud. Cloud Shell provides command-line access to your Google Cloud resources.

In the Cloud Console, in the top right toolbar, click the **Activate Cloud Shell** button.

![](https://cdn.qwiklabs.com/vdY5e%2Fan9ZGXw5a%2FZMb1agpXhRGozsOadHURcR8thAQ%3D)

Click **Continue**.

![](https://cdn.qwiklabs.com/lr3PBRjWIrJ%2BMQnE8kCkOnRQQVgJnWSg4UWk16f0s%2FA%3D)

It takes a few moments to provision and connect to the environment. When you are connected, you are already authenticated, and the project is set to your _PROJECT\_ID_. For example:

![](https://cdn.qwiklabs.com/hmMK0W41Txk%2B20bQyuDP9g60vCdBajIS%2B52iI2f4bYk%3D)

`gcloud` is the command-line tool for Google Cloud. It comes pre-installed on Cloud Shell and supports tab-completion.

You can list the active account name with this command:

```bash
gcloud auth list
```

(Output)

```plain
Credentialed accounts:- <myaccount>@<mydomain>.com (active)
```

(Example output)

```plain
Credentialed accounts:- google1623327_student@qwiklabs.net
```

You can list the project ID with this command:

```bash
gcloud config list project
```

(Output)

```plain
[core]
project = <project_ID>
```

(Example output)

```plain
[core]
project = qwiklabs-gcp-44776a13dea667a6
```



For full documentation of `gcloud` see the [gcloud command-line tool overview](https://cloud.google.com/sdk/gcloud).

Run the following command in Cloud Shell to connect to your SQL instance, replacing `qwiklabs-demo` if you used a different name for your instance:

```bash
gcloud sql connect  qwiklabs-demo --user=root
```



It may take a minute to connect to your instance.

When prompted, enter the root password you set for the instance.

You should now be on a similar output:

```plain
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 494
Server version: 5.7.14-google-log (Google)
Copyright (c) 2000, 2017, Oracle, MariaDB Corporation Ab and others.
Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
mysql>
```



A Cloud SQL instance comes with pre-configured databases, but you will create your own to store the London bikeshare data.

Run the following command at the MySQL server prompt to create a database called `bike`:

```sql
CREATE DATABASE bike;
```

You should receive the following output:

```sql
Query OK, 1 row affected (0.05 sec)
mysql>
```

###   

Make a table inside of the bike database by running the following command:

```sql
USE bike;
CREATE TABLE london1 (start_station_name VARCHAR(255), num INT);
```

This statement uses the `CREATE` keyword, but this time it uses the `TABLE` clause to specify that it wants to build a table instead of a database. The `USE` keyword specifies a database that you want to connect to. You now have a table named "london1" that contains two columns, "start\_station\_name" and "num". `VARCHAR(255)` specifies variable length string column that can hold up to 255 characters and `INT` is a column of type integer.

Create another table named "london2" by running the following command:

```sql
USE bike;
CREATE TABLE london2 (end_station_name VARCHAR(255), num INT);
```

Now confirm that your empty tables were created. Run the following commands at the MySQL server prompt:

```sql
SELECT * FROM london1;
SELECT * FROM london2;
```

You should receive the following output for both commands:

```plain
Empty set (0.04 sec)
```

It says "empty set" because you haven't loaded in any data yet.

###   

### Upload CSV files to tables

Return to the Cloud SQL console. You will now upload the `start_station_name` and `end_station_name` CSV files into your newly created london1 and london2 tables.

1.  In your Cloud SQL instance page, click **IMPORT**.
2.  In the Cloud Storage file field, click **Browse**, and then click the arrow opposite your bucket name, and then click `start_station_data.csv`. Click **Select**.
3.  Select **CSV** as File format.
4.  Select the `bike` database and type in "london1" as your table.
5.  Click **Import**:

![](https://cdn.qwiklabs.com/AaxOLtNbNVQMH%2FVq5HSidESNehsWIPab9UHg9oNFrOo%3D)

Do the same for the other CSV file.

1.  In your Cloud SQL instance page, click **IMPORT**.
2.  In the Cloud Storage file field, click **Browse**, and then click the arrow opposite your bucket name, and then click `end_station_data.csv` Click **Select**.
3.  Select **CSV** as File format.
4.  Select the bike database and type in "london2" as your table.
5.  Click **Import**:

You should now have both CSV files uploaded to tables in the `bike` database.

Return to your Cloud Shell session and run the following command at the MySQL server prompt to inspect the contents of london1:

```sql
SELECT * FROM london1;
```

You should receive 881 lines of output, one more each unique station name. Your output be formatted like this:

![](https://cdn.qwiklabs.com/gHiOlNC7sj3nJvU6dgHAVtU4bzDaVWvK6MBEaKRwLH8%3D)

Run the following command to make sure that london2 has been populated:

```sql
SELECT * FROM london2;
```

You should receive 883 lines of output, one more each unique station name. Your output be formatted like this:

![](https://cdn.qwiklabs.com/mUE0WbdWa8RP6L4nH%2BJIOBd3M6TBJB3Yi7%2FQje8zcZM%3D)

### DELETE keyword

Here are a couple more SQL keywords that help us with data management. The first is the `DELETE` keyword.

Run the following commands in your MySQL session to delete the first row of the london1 and london2:

```sql
DELETE FROM london1 WHERE num=0;
DELETE FROM london2 WHERE num=0;
```

You should receive the following output after running both commands:

```plain
Query OK, 1 row affected (0.04 sec)
```

The rows deleted were the column headers from the CSV files. The `DELETE` keyword will not remove the first row of the file per se, but all _rows_ of the table where the column name (in this case "num") contains a specified value (in this case "0"). If you run the `SELECT * FROM london1;` and `SELECT * FROM london2;` queries and scroll to the top of the table, you will see that those rows no longer exist.

###   

### 👉 INSERT INTO keyword

You can also insert values into tables with the `INSERT INTO` keyword. Run the following command to insert a new row into london1, which sets `start_station_name` to "test destination" and `num` to "1":

```sql
INSERT INTO london1 (start_station_name, num) VALUES ("test destination", 1);
```



The `INSERT INTO` keyword requires a table (london1) and will create a new row with columns specified by the terms in the first parenthesis (in this case "start\_station\_name" and "num"). Whatever comes after the "VALUES" clause will be inserted as values in the new row.

You should receive the following output:

```plain
Query OK, 1 row affected (0.05 sec)
```

If you run the query `SELECT * FROM london1;` you will see an additional row added at the bottom of the "london1" table:

![](https://cdn.qwiklabs.com/eYhqa3ycQ83rA1PDALG5rffOmKQ5OkLYuduwGhjejK4%3D)

### 👉 UNION keyword

The last SQL keyword that you'll learn about is `UNION`. This keyword combines the output of two or more `SELECT` queries into a result-set. You use `UNION` to combine subsets of the "london1" and "london2" tables.

The following chained query pulls specific data from both tables and combine them with the `UNION` operator.

Run the following command at the MySQL server prompt:

```sql
SELECT
  start_station_name AS top_stations,
  num
FROM london1
WHERE num>100000

UNION

SELECT
  end_station_name,
  num
FROM london2
WHERE num>100000
ORDER BY top_stations DESC;
```

The first `SELECT` query selects the two columns from the "london1" table and creates an alias for "start\_station\_name", which gets set to "top\_stations". It uses the `WHERE` keyword to only pull rideshare station names where over 100,000 bikes start their journey.

The second `SELECT` query selects the two columns from the "london2" table and uses the `WHERE` keyword to only pull rideshare station names where over 100,000 bikes end their journey.

The `UNION` keyword in between combines the output of these queries by assimilating the "london2" data with "london1". Since "london1" is being unioned with "london2", the column values that take precedent are "top\_stations" and "num".

`ORDER BY` will order the final, unioned table by the "top\_stations" column value alphabetically and in descending order.

You should receive the following output:

![](https://cdn.qwiklabs.com/WbDqTqRleeMoM8my3TAgh5JVLVY7NnGbs3cTxwBojSw%3D)

As you see, 13/14 stations share the top spots for rideshare starting and ending points. With some basic SQL keywords you were able to query a sizable dataset, which returned data points and answers to specific questions.

**Congratulations!**
--------------------

In this lab you learned the fundamentals of SQL and how you can apply keywords and run queries in BigQuery and CloudSQL. You were taught the core concepts behind projects, databases, and tables. You practiced with keywords that manipulated and edited data. You learned how to load datasets into BigQuery and you practiced running queries on tables. You learned how to create instances in Cloud SQL and practiced transferring subsets of data into tables contained in databases. You chained and ran queries in Cloud SQL to arrive at some interesting conclusions about London bikesharing starting and ending stations.

![](https://cdn.qwiklabs.com/YD5HilNuEG%2F0LAxaCSVHvJ065yZtYjD1cPzkCfJbeGg%3D) ![](https://cdn.qwiklabs.com/FNp7RZH%2B7DDSpeAsPcs8J402amNSyvJplHN5Iqrqog4%3D) ![](https://cdn.qwiklabs.com/8FD2GFrCgTpBETONBnDgeL4v5uMrLJS%2BL%2BJhMQIvLZg%3D) ![](https://cdn.qwiklabs.com/4ONtHbbEjhk1Kg0YoTflkUukkw2pn6r3rUVU6ES1TF4%3D) ![](https://cdn.qwiklabs.com/jAnA2n029sN72whRZDiRuCPhN%2BJ1HBGQ8ERZBekLCMw%3D) ![](https://cdn.qwiklabs.com/jVIZEu1uWCkufNtCmqyElRifK5o%2FNRrtt5Vo9iZxHz8%3D) ![](https://cdn.qwiklabs.com/k6pvbBWPvVh7GY6bkPUN1Y9ay1oDpsQvCzti9wNp5IE%3D) ![](https://cdn.qwiklabs.com/QjxHVY6XX%2FnGmhZHwBcXqEDm3uwb8lvKfG712tRrnpo%3D)
