
# DAG backfilling 

## option 1: **catchup = True**

```python
"""
Code that goes along with the Airflow tutorial located at:
https://github.com/apache/airflow/blob/master/airflow/example_dags/tutorial.py
"""
from airflow.models.dag import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta


default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email': ['airflow@example.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5)
}

dag = DAG(
    'tutorial',
    default_args=default_args,
    start_date=datetime(2015, 12, 1),
    description='A simple tutorial DAG',
    schedule_interval='@daily',
    catchup=False)
```

In the example above, if the DAG is picked up by the scheduler daemon on 2016-01-02 at 6 AM, (or from the command line),
a single DAG Run will be created, with an execution_date of 2016-01-01, 
and the next one will be created just after midnight on the morning of 2016-01-03 with an execution date of 2016-01-02.

**If the dag.catchup value had been True instead**, the scheduler would have **created a DAG Run for each completed 
interval between 2015-12-01 and 2016-01-02** (but not yet one for 2016-01-02, as that interval hasn’t completed)
and the scheduler will execute them sequentially.

**Catchup is also triggered when you turn off a DAG for a specified period and then re-enable it.**

![screenshots/img.png](img.png)
![screenshots/img_1.png](img_1.png)

### an alternative way of passing dag parameters

```python
with DAG(
    'tutorial',
    default_args=default_args,
    description='A simple tutorial DAG',
    schedule_interval=timedelta(days=1),
    start_date=days_ago(2),
    tags=['example'],
) as dag:
```


## option 2: **backfill CLI command**

```bash
airflow dags backfill \
    --start-date START_DATE \
    --end-date END_DATE \
    dag_id
```


```bash
airflow backfill -s <START_DATE> -e <END_DATE> --rerun_failed_tasks -B <DAG_NAME>
```
Note here -B means we want DAG Runs to happen in backwards. Latest date first then the older dates.

## airflow pre-defined variables 
https://airflow.apache.org/docs/apache-airflow/1.10.4/macros.html


## setting task_dependencies
```python
# Dependencies with lists
t0 >> t1 >> [t2, t3]

# Dependencies with tuples
t0 >> t1 >> (t2, t3)


```
* https://www.astronomer.io/guides/managing-dependencies
* https://godatadriven.com/blog/the-zen-of-python-and-apache-airflow/


# References
* https://airflow.apache.org/docs/apache-airflow/stable/dag-run.html
* https://airflow.readthedocs.io/en/1.10.8/scheduler.html
* https://medium.com/nerd-for-tech/airflow-catchup-backfill-demystified-355def1b6f92
* https://www.youtube.com/watch?v=s_28dAy9it8
* https://stackoverflow.com/questions/51617236/airflow-backfills-and-new-dag-runs
* https://www.startdataengineering.com/post/how-to-backfill-sql-query-using-apache-airflow/

* https://godatadriven.com/blog/the-zen-of-python-and-apache-airflow/

## airflow pre-defined variables 
https://airflow.apache.org/docs/apache-airflow/1.10.4/macros.html

