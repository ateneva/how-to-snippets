
# Setting up MySQL DB

## check pre-requisites
* python3 is installed
* pip is installed

```bash
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
```

## create virtual environment
```bash
pip install virtualenv
virtualenv --version

# create project folder
cd Documents
mkdir mysql_setup

# create virtual environement
cd mysql_setup
virtualenv env_mysql -p python3

# activate virtual environment
source env_mysql/bin/activate
```

## install MySQL database with brew
```bash
brew install mysql

export PATH=$PATH:/usr/local/mysql/bin
mysql --version

# start the mysql server 
mysql.server start

# access MySQL environment
mysql -u root -p
mysql> CREATE DATABASE airflow CHARACTER SET utf8 COLLATE utf8_unicode_ci;
mysql> GRANT ALL PRIVILEGES ON airflow.* To 'root'@'localhost';
mysql> FLUSH PRIVILEGES;
```

* https://flaviocopes.com/mysql-how-to-install/
* https://stackoverflow.com/questions/22436028/cant-connect-to-local-mysql-server-through-socket-tmp-mysql-sock-2


## CREATE TABLE on the installed database

```sql
CREATE TABLE movies(
    title VARCHAR(50) NOT NULL,
    genre VARCHAR(30) NOT NULL,
    director VARCHAR(60) NOT NULL,
    release_year INT NOT NULL,
    PRIMARY KEY(title)`
);
```

## INSERT values
```sql
INSERT INTO movies
VALUES ("Joker", "psychological thriller", "Todd Phillips", 2019);
```

## CHECK DATABASES and TABLES
```bash
MySQL -u root -p
SHOW DATABASES;
SHOW TABLES from database;
quit

# OR
USE database;
SHOW TABLES LIKE pattern;
SHOW TABLES;
quit
```

## MODIFY column type 

```sql
ALTER TABLE table_name    
MODIFY column_name datatype;  
```

## SHOW users
```bash
MySQL -u root -p
desc mysql.user;
select user from mysql.user;
```
https://alvinalexander.com/blog/post/mysql/show-users-i-ve-created-in-mysql-database/

## set up MySQL connection through python
```bash
pip install mysqlclient
pip install mysql-connector-python
pip install pymysql
pip install sqlalchemy
```
* [check examples](https://github.com/ateneva/how-to-snippets/blob/e083e939d6600248ef853f5c63db2caf9c0f6471/MySQL/load-data-to-mysql-db-with-python.md)



# Install MySQL database with Docker image

* pull latest image
```bash
docker pull mysql
docker pull mysql/mysql-server:latest
```

* verify the image exists on your machien
```bash
docker image ls -a
--or 
sudo docker images
```

* deploy and start the container
```bash
docker run --name=mysql -d mysql/mysql-server:latest
```

* verify the container is running
```bash
docker container ls -a
---or 
docker ps
```

* https://hevodata.com/learn/docker-mysql/

# MySQL Functions

## DATETIME:

* ### convert a string to a date
```sql
STR_TO_DATE(date, date_format)
```

* ### return the current date

```sql
CURDATE(), CURRENT_DATE(), CURRENT_DATE, UTC_DATE()
```

* ### return the day, month , quarter, year from the passed argument

```sql
DAY(), MONTH(), WEEK(), QUARTER(), YEAR()
```

* ### return the number index of the argument
```sql
DAYOFMONTH(), DAYOFWEEK(), DAYOFYEAR(), WEEKOFYEAR()
```

* ### return the name of the weekday or month
```sql
DAYNAME(), MONTHNAME()
```

* ### return the year and week
```sql
YEARWEEK()
```

* ### extract the date part of a date or datetime
```sql
DATE(date or timestamp)
```

* ### create a date from the year and day of year
```sql
MAKEDATE(year, dayofyear)
```

* ### extract part of a date
```sql
EXTRACT(PART FROM DATE/TIMESTAMP)
```

* ### add datetime values (INTERVALs) to a date value
```sql
DATE_ADD(DATE/TIMESTAMP, INTERVAL, PART)		
```	

* ### subtract a datetime value (INTERVAL) from a date
```sql
DATE_SUB(DATE/TIMESTAMP, INTERVAL, PART)
```

* ### add dates to a date value
```sql
ADDDATE(DATE, argument)
```

* ### subtract a date value from a date
```sql
SUBDATE(DATE, argument)
```

* ### add a period to a year-month
```sql
PERIOD_ADD()
```

* ### return the number of months between periods
```sql
PERIOD_DIFF()
```

* ### subtract two dates
```sql
DATEDIFF(PART, DATE, DATE)
```

* ### format date as specified
```sql
DATE_FORMAT()
```

* ### return a date format string
```sql
GET_FORMAT()
```

* ### return the last day of the month for the argument
```sql
LAST_DAY(DATE)
```

* ### convert a day number to a date
```sql
FROM_DAYS()
```

* ### format Unix timestamp as a date
```sql
FROM_UNIXTIME()
```


# References
* https://pip.pypa.io/en/stable/installing/
* https://medium.com/employbl/how-to-install-mysql-on-mac-osx-5b266cfab3b6
* https://phoenixnap.com/kb/how-to-create-a-table-in-mysql
* https://phoenixnap.com/kb/mysql-commands-cheat-sheet
* https://linuxize.com/post/show-tables-in-mysql-database/
* https://dev.mysql.com/doc/refman/8.0/en/char.html
