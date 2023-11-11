
# Intro
<!-- TOC -->

- [SETUP PostgreSQL Server](#setup-postgresql-server)
- [Loading DVD-rental sample database](#loading-dvd-rental-sample-database)
    - [Creating the table structure](#creating-the-table-structure)
    - [Loading the data](#loading-the-data)
- [PostgreSQL functions and syntax](#postgresql-functions-and-syntax)
    - [DATETIME functions](#datetime-functions)
        - [PostgreSQL: convert text to date](#postgresql-convert-text-to-date)
        - [PostgreSQL: add INTERVAL to a date](#postgresql-add-interval-to-a-date)
        - [PostgreSQL: DATE_PARTINTERVAL, timestamp](#postgresql-date_partinterval-timestamp)
        - [PostgreSQL: EXTRACTINTERVAL FROM timestamp](#postgresql-extractinterval-from-timestamp)
        - [PostgreSQL: find the first day of - DATE_TRUNCINTERVAL, date/timestamp](#postgresql-find-the-first-day-of---date_truncinterval-datetimestamp)
            - [PostgreSQL: find the last day of](#postgresql-find-the-last-day-of)
            - [PostgreSQL: find exact period between two dates](#postgresql-find-exact-period-between-two-dates)

<!-- /TOC -->

# SETUP PostgreSQL Server

- prepare a `yml` file that pulls up the latest docker image

```yml
version: '3.4'

services:
  postgres:
    image: postgres
    restart: always
    ports: 
      - "5432:5432"
    environment:
      POSTGRES_PASSWORD: rentals
      POSTGRES_USER: ateneva
      POSTGRES_DB: dvd
      PGDATA: /var/lib/dvd/data/pgdata
    volumes: 
      - ./dvd:/var/lib/dvd/data
```

- run the imavge in a container

```bash
docker-compose -f dvd-rental.yml up
```

# Loading DVD-rental sample database

## Creating the table structure

- run `how-to-snippets/postgresql/ddl-dvd-rental.sql`  to crate the table structure

## Loading the data

- navigate to postgres designated folder and make a sample directory

```bash
# navigate to postgres designated folder
cd Documents/postgress

# make sample directory there and navigate further 
mkdir sample_db && cd sample_db
```

- download the sample database from [here](https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip)

```bash
# download zip file 
wget https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip
```

- unzip it and unarchive the `tar` files

```bash
# unzip and create tar archive instead
unzip dvdrental.zip

# unarchive the newly created tar file
tar -xvf dvdrental.tar
```

- copy the unzipped data files to the postgresql db container

```bash
docker cp /Users/angelina.teneva/Documents/postgres/sample_db/. postgres_dvd_rental_1/:/home/
```

- run psql with the container

```bash
docker exec -ti postgres_dvd_rental_1 psql -U ateneva dvd
```

- execute the `COPY` commands from `how-to-snippets/postgresql/copy-dvd-rental.sql` in the following format

```bash
\COPY public.actor (actor_id, first_name, last_name, last_update) FROM 'home/3057.dat';
```

# PostgreSQL functions and syntax

## DATETIME functions

### PostgreSQL: convert text to date

```sql
SELECT
    '2017-03-31'                          AS text_field,
    TO_DATE('2017-03-31', 'YYYY-MM-DD')   AS date_field
```

### PostgreSQL: add `INTERVAL` to a date

```sql
SELECT
    NOW() - INTERVAL '1 year'    AS one_year_ago,
    NOW() - INTERVAL '1 month'   AS one_month_ago,
    NOW() - INTERVAL '1 week'    AS one_week_ago,
    NOW() - INTERVAL '1 day'     AS one_day_ago,
    NOW() - INTERVAL '1 hour'    AS one_hour_ago
```

or

```sql
SELECT
    NOW() + INTERVAL '1 year'    AS one_year_from_now,
    NOW() + INTERVAL '1 month'   AS one_month_from_now,
    NOW() + INTERVAL '1 week'    AS one_week_from_now,
    NOW() + INTERVAL '1 day'     AS one_day_from_now,
    NOW() + INTERVAL '1 hour'    AS one_hour_from_now
```

### PostgreSQL: `DATE_PART(INTERVAL, timestamp)`

```sql
SELECT
    CURRENT_TIMESTAMP,

    ----find current century
    DATE_PART('century', CURRENT_TIMESTAMP)         AS century,                 
    DATE_PART('decade', CURRENT_TIMESTAMP)          AS decade,
    DATE_PART('doy', CURRENT_TIMESTAMP)             AS day_of_year,

    ----find day of current week (0 to 6)
    DATE_PART('dow', CURRENT_TIMESTAMP)             AS day_of_week,
    DATE_PART('isoyear', CURRENT_TIMESTAMP)         AS iso_year,
    DATE_PART('year', CURRENT_TIMESTAMP)            AS current_year,
    DATE_PART('quarter', CURRENT_TIMESTAMP)         AS current_quarter,
    DATE_PART('month', CURRENT_TIMESTAMP)           AS current_month,
    DATE_PART('day', CURRENT_TIMESTAMP)             AS current_day,
    DATE_PART('hour', CURRENT_TIMESTAMP)            AS current_hour
```

### PostgreSQL: `EXTRACT(INTERVAL FROM timestamp)`

```sql
SELECT
    CURRENT_TIMESTAMP,
    EXTRACT(century FROM CURRENT_TIMESTAMP)         AS century,
    EXTRACT(decade FROM CURRENT_TIMESTAMP)          AS decade,
    EXTRACT(doy FROM CURRENT_TIMESTAMP)             AS day_of_year,
    EXTRACT(dow FROM CURRENT_TIMESTAMP)             AS day_of_week,
    EXTRACT(isoyear FROM CURRENT_TIMESTAMP)         AS iso_year,
    EXTRACT(year FROM CURRENT_TIMESTAMP)            AS current_year,
    EXTRACT(quarter FROM CURRENT_TIMESTAMP)         AS current_quarter,
    EXTRACT(month FROM CURRENT_TIMESTAMP)           AS current_month,
    EXTRACT(day FROM CURRENT_TIMESTAMP)             AS current_day,
    EXTRACT(hour FROM CURRENT_TIMESTAMP)            AS current_hour
```

### PostgreSQL: find the first day of - `DATE_TRUNC(INTERVAL, date/timestamp)`

```sql
SELECT
    DATE(DATE_TRUNC('week', NOW()))  AS first_day_of_current_week,
    DATE(DATE_TRUNC('month', NOW())) AS first_day_of_current_month,
    DATE(DATE_TRUNC('year', NOW()))  AS first_day_of_current_year
```

#### PostgreSQL: find the last day of

```sql
SELECT
    DATE(NOW()) AS Today,
    DATE(DATE_TRUNC('month', NOW() 
            + INTERVAL '0 month') - INTERVAL '1 day')  AS last_day_previous_month,
    
    DATE(DATE_TRUNC('month', NOW() 
            + INTERVAL '1 month') - INTERVAL '1 day')  AS last_day_this_month,
    
    DATE(DATE_TRUNC('month', NOW() 
            + INTERVAL '2 month') - INTERVAL '1 day')  AS last_day_next_month
```

#### PostgreSQL: find exact period between two dates

```sql
SELECT
    age(NOW(), '1988-06-21') AS years_between_dates
```

```text
yearsbetweendates                                      |
-------------------------------------------------------|
29 years 5 mons 19 days 21 hours 0 mins 39.466046 secs |
```
