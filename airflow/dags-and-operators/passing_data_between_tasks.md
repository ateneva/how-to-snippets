
# Passing Data between tasks

## XCom
XCom (short for cross-communication) is a native feature within Airflow. 
`XComs` allow tasks to exchange task metadata or small amounts of data. 
They are defined by a `key`, `value`, and `timestamp`.

`XComs` can be “pushed”, meaning sent by a task, or “pulled”, meaning received by a task. 
When an XCom is pushed, it is stored in Airflow’s metadata database and made available to all other tasks. 

Any time a task returns a value **(e.g. if your Python callable for your PythonOperator has a return)**, 
that value will automatically be pushed to XCom. 

Tasks can also be configured to push XComs by calling the `xcom_push()` method. 

Similarly, `xcom_pull()` can be used in a task to receive an XCom.

```python
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime, timedelta

import requests
import json

url = 'https://covidtracking.com/api/v1/states/'
state = 'wa'

def get_testing_increase(state, ti):
    """
    Gets totalTestResultsIncrease field from Covid API for given state and returns value
    """
    res = requests.get(url+'{0}/current.json'.format(state))
    testing_increase = json.loads(res.text)['totalTestResultsIncrease']

    ti.xcom_push(key='testing_increase', value=testing_increase)

def analyze_testing_increases(state, ti):
    """
    Evaluates testing increase results
    """
    testing_increases=ti.xcom_pull(key='testing_increase', task_ids='get_testing_increase_data_{0}'.format(state))
    print('Testing increases for {0}:'.format(state), testing_increases)
    #run some analysis here

# Default settings applied to all tasks
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5)
}

with DAG('xcom_dag',
         start_date=datetime(2021, 1, 1),
         max_active_runs=2,
         schedule_interval=timedelta(minutes=30),
         default_args=default_args,
         catchup=False
         ) as dag:

    opr_get_covid_data = PythonOperator(
        task_id = 'get_testing_increase_data_{0}'.format(state),
        python_callable=get_testing_increase,
        op_kwargs={'state':state}
    )

    opr_analyze_testing_data = PythonOperator(
        task_id = 'analyze_data',
        python_callable=analyze_testing_increases,
				op_kwargs={'state':state}
    )

    opr_get_covid_data >> opr_analyze_testing_data
```



You can view your `XComs` in the Airflow UI by navigating to `Admin → XComs`

* The `key` is the identifier of your XCom. 
    No need to be unique and is used to get back the xcom from a given task.


* The `value` is … the value of your XCom. 
  * What you want to share. Keep in mind that your value must be serializable in JSON or pickable. 
  * Notice that serializing with pickle is disabled by default to avoid RCE exploits/security issues.  If you want to learn more about the differences between JSON/Pickle click here.
  

* The `timestamp` is the data at which the XCom was created.
  

* `The execution date`! This is important! 
  * That `execution date` corresponds to the` execution date` of the DagRun having generated the XCom. 
  * That’s how Airflow avoid fetching an `XCom` coming from another DAGRun.
    

* The `task id` of the task where the `XCom` was created.
 
 
* The `dag id` of the dag where the `XCom` was created.


* You can also use XComs in templates:

```sql
SELECT * FROM {{ task_instance.xcom_pull(task_ids='foo', key='table_name') }}
```


XCom cannot be used for passing large data sets between tasks. 
The limit for the size of the XCom is determined by which metadata database you are using:

```
Postgres: 1 Gb
SQLite: 2 Gb
MySQL: 64 Kb
```



## TaskFlow API 
Another way to implement this use case is to use the TaskFlow API that was released with Airflow 2.0. 
With the TaskFlow API, returned values are pushed to XCom as usual, 
but XCom values can be pulled simply by adding the key as an input to the function as shown below:

```python
from airflow.decorators import dag, task
from datetime import datetime

import requests
import json

url = 'https://covidtracking.com/api/v1/states/'
state = 'wa'

default_args = {
    'start_date': datetime(2021, 1, 1)
}

@dag('xcom_taskflow_dag', schedule_interval='@daily', default_args=default_args, catchup=False)
def taskflow():

    @task
    def get_testing_increase(state):
        """
        Gets totalTestResultsIncrease field from Covid API for given state and returns value
        """
        res = requests.get(url+'{0}/current.json'.format(state))
        return{'testing_increase': json.loads(res.text)['totalTestResultsIncrease']}

    @task
    def analyze_testing_increases(testing_increase: int):
        """
        Evaluates testing increase results
        """
        print('Testing increases for {0}:'.format(state), testing_increase)
        #run some analysis here

    analyze_testing_increases(get_testing_increase(state))

dag = taskflow()
```


## References
* https://www.astronomer.io/guides/airflow-passing-data-between-tasks/
* https://marclamberti.com/blog/airflow-xcom/#How_to_use_XCom_in_Airflow
* https://airflow.apache.org/docs/apache-airflow/stable/concepts/xcoms.html

* https://towardsdatascience.com/airflow-sharing-data-between-tasks-7bbaa27eeb1