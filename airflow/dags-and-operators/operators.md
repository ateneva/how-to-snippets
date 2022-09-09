
# Operators

## Python Operator

* `provide_context=True` passes along the context variables to be used inside the operator


* `op_kwargs={}` allows us to pass the specific function arguments that `python_callable` expects
```python
from datetime import datetime

from airflow import DAG
from airflow.operators.python_operator import PythonOperator

default_args = {"owner": "airflow", "start_date": datetime(2018, 10, 1)}
dag = DAG(dag_id="context_demo", default_args=default_args, schedule_interval="@daily")

# The PythonOperator with provide_context=True passes the Airflow context to the given callable
def _print_exec_date(**context):
    print(context["execution_date"])
    # Prints e.g. 2018-10-01T00:00:00+00:00

print_exec_date = PythonOperator(
    task_id="print_exec_date",
    python_callable=_print_exec_date,
    provide_context=True,
    dag=dag,
)
```

* https://airflow.apache.org/docs/apache-airflow/stable/howto/operator/python.html
* https://stackoverflow.com/questions/64202437/airflow-got-an-unexpected-keyword-argument-conf

```python
from airflow import DAG
from airflow.operators.python_operator import PythonOperator

task_call_api = PythonOperator(
    task_id='call_api',
    provide_context=True,
    python_callable=call_api,
    op_kwargs={
               'hook': hook,
               'header': header,
               'response_calls': response_calls,
               'date_range': date_range
               },
    dag=dag
)
```
* `python_callable` needs to have `**kwargs` as argument else `conf` error ensues

```python
from airflow.operators.python_operator import PythonOperator

def my_mult_function(number, **kwargs):
    return number*number

mult_task = PythonOperator(
    task_id = 'mult_task',
    provide_context=True,
    python_callable=my_mult_function,
    op_kwargs={'number': 5},
    dag = dag
)
```
* https://stackoverflow.com/questions/64202437/airflow-got-an-unexpected-keyword-argument-conf

```python
from airflow import DAG
from airflow.operators.python_operator import PythonOperator

task_load = PythonOperator(
    task_id='load',
    provide_context=True,
    python_callable=load_data,
    op_kwargs={'query': 'SELECT * FROM TABLE_IN'},
    dag=dag)
```

* https://godatadriven.com/blog/the-zen-of-python-and-apache-airflow/



## PythonBranchOperator

```python
import logging
from airflow import DAG
from airflow.operators.python_operator import BranchPythonOperator


def choose_run(**kwargs):
    """determine regular or parameterized run"""
    # pylint: disable=R1705
    if not kwargs['dag_run'].external_trigger:  # scheduled
        logging.info('scheduled run')
        return 'get_file_months'

    elif kwargs['dag_run'].external_trigger:
        logging.info(f"is triggered externally {kwargs['dag_run'].external_trigger}")

        if kwargs['dag_run'].conf.get('refresh') is not None:
            logging.info(f"Parameters passed {kwargs['dag_run'].conf.get('refresh')}")
            return 'parameter_run'  # manual parameter
        return 'get_file_months'    # manual no parameters


run_this = BranchPythonOperator(
    task_id='choose_run_type',
    provide_context=True,
    python_callable=choose_run,
    dag=dag
)

# tasls to choose from should be passed as a list
run_this >> [t_param_run, t_get_file_months]
```
* https://www.astronomer.io/guides/airflow-branch-operator/
* https://marclamberti.com/blog/airflow-branchpythonoperator/

## PostgresOperator

```python
from airflow.operators.postgres_operator import PostgresOperator

t_truncate_landing = PostgresOperator(
    task_id='truncate_landing',
    sql='sql/landing_google_reviews.sql',
    postgres_conn_id=AWS_REDSHIFT_CONNECTION,
    trigger_rule='none_failed',
    dag=dag
)
```


## BashOperator

```python
from airflow.operators.bash_operator import BashOperator

run_this = BashOperator(
    task_id='run_after_loop',
    bash_command='echo 1',
)
```
* https://airflow.apache.org/docs/apache-airflow/stable/howto/operator/bash.html
* https://marclamberti.com/blog/airflow-bashoperator/

## ShortCircuit Operator
* skips all downstream tasks if a condition evaluates to False

```python
def _check_date(execution_date, **context):
    return execution_date > (datetime.datetime.now() - relativedelta(weeks=1))

check_date = ShortCircuitOperator(
    task_id="check_if_min_date",
    python_callable=_check_date,
    provide_context=True,
    dag=dag,
)

task1 = DummyOperator(task_id="task1", dag=dag)
task2 = DummyOperator(task_id="task2", dag=dag)

check_date >> task1 >> task2
```
* https://medium.com/@loraxman/how-and-why-of-airflow-shortciruitoperator-85dcbeddb1ba
* https://registry.astronomer.io/dags/example-short-circuit-operator
* https://stackoverflow.com/questions/51725746/airflow-run-a-task-when-some-upstream-is-skipped-by-shortcircuit

# Trigger Rules

* `all_done`  - tasks (parents) are done with their execution whatever their state
* `all_success` - task gets triggered when all upstream tasks (parents) have succeeded
* `none_skipped` - task gets triggered if all upstream tasks have succeeded or been skipped
* `one_success` - As soon as one of the upstream tasks succeeds, your task gets triggered

```python
end = DummyOperator(
    task_id='end',
    retries=1,
    dag=dag,
    trigger_rule='none_failed'
)
```
* https://marclamberti.com/blog/airflow-trigger-rules-all-you-need-to-know/
* https://stackoverflow.com/questions/41670256/what-is-the-difference-between-airflow-trigger-rule-all-done-and-all-success


## References
* https://godatadriven.com/blog/the-zen-of-python-and-apache-airflow/
