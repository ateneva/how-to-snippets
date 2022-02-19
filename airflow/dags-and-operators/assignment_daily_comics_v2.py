
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
latest_comic_link = Variable.get('latest_comic')

db_credentials = Variable.get('mysql-db-credentails')
engine = db.create_engine(db_credentials)
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


def insert_values(backfill=False):
    comics_data = db.Table('xkcd_comics', metadata, autoload=True, autoload_with=engine)
    query = db.insert(comics_data)

    # retrieve the the range of already inserted comic_id
    select_latest = db.select([db.func.max(comics_data.columns.num)])
    select_first = db.select([db.func.min(comics_data.columns.num)])
    max_comic_id = connection.execute(select_latest).scalar()
    min_comic_id = connection.execute(select_first).scalar()
    print(min_comic_id, max_comic_id)

    num_inserted = 0
    if backfill:
        for i in range(max_comic_id - 180, max_comic_id):
            if i < min_comic_id:  # double check record is not already in
                link = f'https://xkcd.com/{i}/info.0.json'
                data = retrieve_data(link)
                ResultProxy = connection.execute(query, data)
                num_inserted += 1
        return f'{num_inserted} records backfilled'

    data = retrieve_data(latest_comic_link)
    if max_comic_id is None:
        ResultProxy = connection.execute(query, data)
    else:
        # check that the current comic_id is not already in
        if max_comic_id < data[0]['num']:
            ResultProxy = connection.execute(query, data)

    num_inserted += 1
    return f'{num_inserted} records inserted'


def poll():
    while True:
        if new_data(retrieve_data(latest_comic_link)):
            break
        else:
            time.sleep(1800)
            print('Re-trying in 30 minutes')


default_dag_args = {
    'owner': 'Angelina',
    'depends_on_past': False,
    "start_date": datetime(2021, 5, 10),
    'catchup': False,
    "retries": 1,
    "retry_delay": timedelta(minutes=2)
    }

with models.DAG(
        'update_comic_data',
        description="get the latest xkcd data",
        default_args=default_dag_args,
        schedule_interval='0 0 * * 1,3,5',
        catchup=False
        ) as dag:

    #do_nothing = DummyOperator(task_id="do_nothing", retries=3, dag=dag)

    poll_data = PythonOperator(
                    task_id='poll_for_new_data',
                    python_callable=poll,
                    dag=dag
        )

    update_data = PythonOperator(
                    task_id='update_comic_data',
                    python_callable=insert_values,
                    trigger_rule=TriggerRule.ALL_SUCCESS,
                    dag=dag
        )

    poll_data >> update_data