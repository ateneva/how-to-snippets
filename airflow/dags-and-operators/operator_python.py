
# https://airflow.apache.org/docs/apache-airflow/1.10.4/howto/operator/python.html


from __future__ import print_function

import time
import requests
import json
from builtins import range
from pprint import pprint

import airflow
from airflow.models import DAG
from airflow.operators.python_operator import PythonOperator

args = {
    'owner': 'airflow',
    'start_date': airflow.utils.dates.days_ago(2),
}

dag = DAG(
    dag_id='example_python_operator',
    default_args=args,
    schedule_interval=None,
)


# [START howto_operator_python]
def print_context(ds, **kwargs):
    pprint(kwargs)
    print(ds)
    return 'Whatever you return gets printed in the logs'


run_this = PythonOperator(
    task_id='print_the_context',
    provide_context=True,           # allows that you pass additional arguments
    python_callable=print_context,  # python_callable needs to have **kwargs as argument else conf error ensues

    dag=dag,
)
# [END howto_operator_python]


# [START howto_operator_python_kwargs]
def my_sleeping_function(random_base):
    """This is a function that will run within the DAG execution"""
    time.sleep(random_base)


# op_kwargs={} allows us to pass the specific function arguments that python_callable expects
for i in range(5):
    task = PythonOperator(
        task_id='sleep_for_' + str(i),
        python_callable=my_sleeping_function,
        op_kwargs={'random_base': float(i) / 10},
        dag=dag,
    )

    run_this >> task


def retrieve_data(link):
    response = requests.get(link)
    daily_comics = [json.loads(response.text)]
    return daily_comics


task_call_api = PythonOperator(
    task_id='call_api',
    provide_context=True,
    python_callable=retrieve_data,
    op_kwargs={
               'link': 'https://xkcd.com/info.0.json'
               },
    dag=dag
)

# [END howto_operator_python_kwargs]


# jinja templating --> https://airflow.apache.org/docs/apache-airflow/1.10.4/concepts.html#id1
