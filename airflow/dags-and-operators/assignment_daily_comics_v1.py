
import time
from datetime import datetime, timedelta
from airflow import models
from airflow.models import Variable

from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.python_operator import PythonOperator
from airflow.utils.trigger_rule import TriggerRule

import json
import requests
import sqlalchemy as db

today = datetime.today().strftime('%Y-%m-%d')
engine = db.create_engine('mysql+pymysql://root:ateneva2021@localhost/airflow')
connection = engine.connect()
metadata = db.MetaData()


def retrieve_data(link):
    response = requests.get(link)
    daily_comics = [json.loads(response.text)]
    return daily_comics


def new_data(daily_comics):
    today_date = datetime(int(daily_comics[0]['year']), int(daily_comics[0]['month']),
                          int(daily_comics[0]['day'])).strftime('%Y-%m-%d')
    if today_date == today:
        return True
    return False


def poll():
    while True:
        if new_data(retrieve_data('https://xkcd.com/info.0.json')):
            break
        else:
            time.sleep(3)
            return 'Re-trying in 30 minutes'


default_dag_args = {
    'owner': 'Angelina',
    'depends_on_past': False,
    "start_date": datetime(2021, 5, 10),
    'catchup': False,
    "retries": 1,
    "retry_delay": timedelta(minutes=2)
    }

with models.DAG(
        'poll_data',
        description="poll for the latest data",
        default_args=default_dag_args,
        schedule_interval='0 0 * * 1,3,5',
        catchup=False
        ) as dag:

    do_nothing = DummyOperator(task_id="do_nothing", retries=3, dag=dag)

    poll_data = PythonOperator(
                    task_id='poll_for_new_data',
                    python_callable=poll,
                    dag=dag
        )


    poll_data >> do_nothing