
## Check pre-requisites
* python3 is installed
  `python3 --version`

* pip is installed
  `python3 -m pip --version`

* MySQL database is installed
** Tasks cannot be parallelized with the default SQLLite database

```
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
```

## Create virtual environment
```
pip install virtualenv
virtualenv --version

# create project folder
cd Documents
mkdir airflow_setup

# create virtual environement
cd airflow_setup
virtualenv env_airflow -p python 3

# activate virtual environment
source env_airflow/bin/activate
```

## Install Airflow
```
# install the basic packages
pip install apache-airflow
airflow version

# install extra packages
pip install 'apache-airflow[mysql]'
pip install celery==3.1.17

# create DAGS directory in the default airflow directory where the airflow.cfg file is generated
cd airflow
mkdir dags
ls
```


### 1. initialize database
```
airflow db init
```

### 2. create airflow user

```
airflow users create \
    --email EMAIL --firstname firstname \
    --lastname lastname --password password \
    --role Admin -username username

airflow users create \
    --email tenevaa21@gmail.com --firstname angelina \
    --lastname teneva --password ateneva2021 \
    --role Admin -username angelinat   
```

### 3. start webserver

```
airflow webserver -p 8080
```

### 4. start the scheduler

```
airflow scheduler
```

# Uninstalling Airflow
```
pip unistall apache-airflow
```

# References

* https://airflow.apache.org/docs/apache-airflow/stable/installation.html
* https://airflow.apache.org/docs/apache-airflow/stable/installation.html#airflow-extra-dependencies
* https://airflow.apache.org/docs/apache-airflow/1.10.12/installation.html#extra-packages
* https://airflow.apache.org/docs/apache-airflow/stable/howto/set-up-database.html#choosing-database-backend
* https://airflow.apache.org/docs/apache-airflow/1.10.10/howto/initialize-database.html
* https://airflow.apache.org/docs/apache-airflow/stable/start/local.html#:~:text=In%20order%20to%20install%20Airflow,to%20your%20pip%20install%20command.
* https://airflow.apache.org/docs/apache-airflow/1.10.12/howto/set-config.html
* https://www.qubole.com/tech-blog/how-to-install-apache-airflow-to-run-different-executors/
* https://www.youtube.com/watch?v=lKL7DMIfMyc
* https://airflow-tutorial.readthedocs.io/en/latest/first-airflow.html
* https://github.com/trallard/airflow-tutorial
* http://site.clairvoyantsoft.com/installing-and-configuring-apache-airflow/
* https://medium.com/softwaresanders/installing-and-configuring-apache-airflow-c1d2d9b57854
