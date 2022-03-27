
# Operators

## Python Operator

* `provide_context=True` passes along the context variables to be used inside the operator

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

* `op_kwargs={}` allows us to pass the specific function arguments that `python_callable` expects

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

```


## PostgresOperator

```python

```


## BashOperator

```python

```


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

# Templating in airflow
Templating is a powerful concept in Airflow to pass dynamic information into task instances at runtime. 
For example, say you want to print the day of the week every time you run a task:

```python
BashOperator(
    task_id="print_day_of_week",
    bash_command="echo Today is {{ execution_date.format('dddd') }}",
)
```
In this example, the value in the double curly braces `{{ }}` is our templated code to be evaluated at runtime. 
If we execute this code on a Wednesday, the BashOperator will print “Today is Wednesday”.


## Rendering Native Python code
By default, Jinja templates always render to Python strings. 

This is fine in almost all situations in Airflow, 
but sometimes it’s desirable to render templates to native Python code. 
If the code you’re calling doesn’t work with strings, you’re in trouble. 

```python
def sum_numbers(*args):
    total = 0
    for val in args:
        total += val
    return total

sum_numbers(1, 2, 3)  # returns 6
sum_numbers("1", "2", "3")  # TypeError: unsupported operand type(s) for +=: 'int' and 'str'
```

Consider a scenario where you’re passing a list of values to this function 
by triggering a DAG with a config that holds some numbers:

```python
with DAG(dag_id="failing_template", start_date=datetime.datetime(2021, 1, 1), schedule_interval=None) as dag:
    sumnumbers = PythonOperator(
        task_id="sumnumbers",
        python_callable=sum_numbers,
        op_args="{{ dag_run.conf['numbers'] }}",
    )
```

We would trigger the DAG with the following JSON to the DAG run configuration:
```python
{"numbers": [1,2,3]}
```

```python
('[', '1', ',', ' ', '2', ',', ' ', '3', ']')
```

This is not going to work, so we must tell Jinja to return a native Python list instead of a string. 
Jinja supports this via `Environments`. The default `Jinja environment` outputs strings, 
but we can configure a `NativeEnvironment` which renders templates as `native Python code`.

```python
def sum_numbers(*args):
    total = 0
    for val in args:
        total += val
    return total


with DAG(
    dag_id="native_templating",
    start_date=datetime.datetime(2021, 1, 1),
    schedule_interval=None,
    render_template_as_native_obj=True,  # Render templates using Jinja NativeEnvironment
) as dag:
    sumnumbers = PythonOperator(
        task_id="sumnumbers",
        python_callable=sum_numbers,
        op_args="{{ dag_run.conf['numbers'] }}",
    )
```

**NB!**


Support for Jinja’s NativeEnvironment was added in `Airflow 2.1.0` via 
the `render_template_as_native_obj` argument on the DAG class. 

This argument takes a boolean value which determines 
whether to render templates with `Jinja’s default Environment` or `NativeEnvironment`. 



## References
* https://airflow.apache.org/docs/apache-airflow/stable/howto/operator/python.html
* https://medium.com/@loraxman/how-and-why-of-airflow-shortciruitoperator-85dcbeddb1ba
* https://registry.astronomer.io/dags/example-short-circuit-operator
* https://stackoverflow.com/questions/51725746/airflow-run-a-task-when-some-upstream-is-skipped-by-shortcircuit

* https://marclamberti.com/blog/airflow-trigger-rules-all-you-need-to-know/
* https://stackoverflow.com/questions/41670256/what-is-the-difference-between-airflow-trigger-rule-all-done-and-all-success

* https://www.astronomer.io/guides/templating/
* https://airflow.apache.org/docs/apache-airflow/stable/templates-ref.html


### Certification
https://academy.astronomer.io/astronomer-certified-apache-airflow-core-exam