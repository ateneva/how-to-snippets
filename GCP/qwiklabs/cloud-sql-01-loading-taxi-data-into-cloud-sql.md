## Overview
In this lab, you will learn how to import data from CSV text files into Cloud SQL and then carry out some basic data analysis using simple queries.

The dataset used in this lab is collected by the NYC Taxi and Limousine Commission and includes trip records from all trips completed in Yellow and Green taxis in NYC from 2009 to present, and all trips in for-hire vehicles (FHV) from 2015 to present. Records include fields capturing pick-up and drop-off dates/times, pick-up and drop-off locations, trip distances, itemized fares, rate types, payment types, and driver-reported passenger counts.

This dataset can be used to demonstrate a wide range of data science concepts and techniques and will be used in several of the labs in the Data Engineering curriculum.

https://googlepluralsight.qwiklabs.com/focuses/22344260?parent=lti_session

## Objectives: 
* Create Cloud SQL instance

* Create a Cloud SQL database

* Import text data into Cloud SQL

* Check the data for integrity


### Activate Cloud Shell
Cloud Shell is a virtual machine that is loaded with development tools. It offers a persistent 5GB home directory and runs on the Google Cloud. Cloud Shell provides command-line access to your Google Cloud resources.
In the Cloud Console, in the top right toolbar, click the Activate Cloud Shell button.

```bash
# list active credentails and project name
gcloud auth list
gcloud config list project
```

### Preparing your Environment

Create environment variables that will be used later in the lab for your project ID and the storage bucket that will contain your data:

```bash
export PROJECT_ID=$(gcloud info --format='value(config.project)')
export BUCKET=${PROJECT_ID}-ml
```

### Activate Cloud Shell
Cloud Shell is a virtual machine that is loaded with development tools. It offers a persistent 5GB home directory and runs on the Google Cloud. Cloud Shell provides command-line access to your Google Cloud resources.
In the Cloud Console, in the top right toolbar, click the Activate Cloud Shell button.

```bash
# list active credentails and project name
gcloud auth list
gcloud config list project
```

### Preparing your Environment

Create environment variables that will be used later in the lab for your project ID and the storage bucket that will contain your data:

```bash
export PROJECT_ID=$(gcloud info --format='value(config.project)')
export BUCKET=${PROJECT_ID}-ml
```

### Create a Cloud SQL instance

Enter the following commands to create a Cloud SQL instance and set a root password

```bash
gcloud sql instances create taxi \
        --tier=db-n1-standard-1 --activation-policy=ALWAYS
    
gcloud sql users set-password root --host % --instance taxi \
     --password Passw0rd
```


Now create an environment variable with the IP address of the Cloud Shell and whitelist the Cloud Shell instance for management access to your SQL instance.

```bash
export ADDRESS=$(wget -qO - http://ipecho.net/plain)/32
gcloud sql instances patch taxi --authorized-networks $ADDRESS
```

Get the IP address of your Cloud SQL instance by running and store it in a variable

```bash
MYSQLIP=$(gcloud sql instances describe \
taxi --format="value(ipAddresses.ipAddress)")
    
echo $MYSQLIP
```

Create the taxi trips table by logging into the `mysql` command line interface.

```bash
mysql --host=$MYSQLIP --user=root \
      --password --verbose
```
 
```sql
CREATE DATABASE IF NOT EXISTS bts;
USE bts;

DROP TABLE IF EXISTS trips;
CREATE TABLE trips
(
  vendor_id           VARCHAR(16),
  pickup_datetime     DATETIME,
  dropoff_datetime    DATETIME,
  passenger_count     INT,
  trip_distance       FLOAT,
  rate_code           VARCHAR(16),
  store_and_fwd_flag  VARCHAR(16),
  payment_type        VARCHAR(16),
  fare_amount         FLOAT,
  extra               FLOAT,
  mta_tax             FLOAT,
  tip_amount          FLOAT,
  tolls_amount        FLOAT,
  imp_surcharge       FLOAT,
  total_amount        FLOAT,
  pickup_location_id  VARCHAR(16),
  dropoff_location_id VARCHAR(16)
);
```

In the `mysql` command line interface check the import by entering the following commands and exit the mysql interactive console

```bash
describe trips;
select distinct(pickup_location_id) from trips;
exit
```


### Add data to Cloud SQL instance

Now you'll copy the New York City taxi trips CSV files stored on Cloud Storage locally. To keep resource usage low, you'll only be working with a subset of the data (~20,000 rows).

Run the following in the command line:

```bash
gsutil cp gs://cloud-training/OCBL013/nyc_tlc_yellow_trips_2018_subset_1.csv trips.csv-1
gsutil cp gs://cloud-training/OCBL013/nyc_tlc_yellow_trips_2018_subset_2.csv trips.csv-2
```


Import the CSV file data into Cloud SQL using `mysql`:

```bash
mysqlimport --local --host=$MYSQLIP --user=root --password \
--ignore-lines=1 --fields-terminated-by=',' bts trips.csv-*
```

Connect to the `mysql` interactive console:

```bash
mysql --host=$MYSQLIP --user=root  --password
```

Checking for data integrity

Whenever data is imported from a source it's always important to check for data integrity. Roughly, this means making sure the data meets your expectations.
In the `mysql` interactive console select the database:

```sql
USE BTS;
SELECT DISTINCT(pickup_location_id) 
FROM trips;

SELECT
  MAX(trip_distance),
  MIN(trip_distance)
FROM
  trips;


SELECT COUNT(*) 
FROM trips 
WHERE trip_distance = 0;


SELECT COUNT(*) 
FROM trips 
WHERE fare_amount < 0;


SELECT
  payment_type,
  COUNT(*)
FROM
  trips
GROUP BY
  payment_type;
```