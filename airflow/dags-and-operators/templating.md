
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

* https://www.astronomer.io/guides/templating/
* https://airflow.apache.org/docs/apache-airflow/stable/templates-ref.html
