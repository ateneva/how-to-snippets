
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
virtualenv env_mysql -p python 3

# activate virtual environment
source env_mysql/bin/activate
```

## install MySQL database
```bash
export PATH=$PATH:/usr/local/mysql/bin
mysql --version

# access MySQL environment
MySQL -u root -p
mysql> CREATE DATABASE airflow CHARACTER SET utf8 COLLATE utf8_unicode_ci;
mysql> GRANT ALL PRIVILEGES ON airflow.* To 'root'@'localhost';
mysql> FLUSH PRIVILEGES;
```

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

## set up MySQL connection through python
```bash
pip install mysqlclient
pip install mysql-connector-python
pip install pymysql
pip install sqlalchemy
```


# References 
* https://pip.pypa.io/en/stable/installing/
* https://medium.com/employbl/how-to-install-mysql-on-mac-osx-5b266cfab3b6
* https://phoenixnap.com/kb/how-to-create-a-table-in-mysql
* https://phoenixnap.com/kb/mysql-commands-cheat-sheet
* https://linuxize.com/post/show-tables-in-mysql-database/
* https://dev.mysql.com/doc/refman/8.0/en/char.html

