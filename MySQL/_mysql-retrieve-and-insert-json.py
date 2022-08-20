
import json
import requests
from mysql.connector import connect, Error


def retrieve_data(link):
    response = requests.get(link)
    daily_comic = json.loads(response.text)
    retrieve_values = tuple([str(t).replace("'", "") for t in daily_comic.values()])
    return retrieve_values


def establish_connection(ip, username, credentials, database):
    try:
        with connect(
            host=ip,
            user=username,
            password=credentials,
            database=database
                     ) as connection:
            return connection
    except Error as e:
        print(e)


def insert_values():
    #engine = create_engine('mysql://root:ateneva2021@localhost/airflow')
    conn = connect(host='localhost', user='root', password='ateneva2021', db='airflow')
    data = retrieve_data('https://xkcd.com/info.0.json')
    to_insert = [data]
    print(type(data), data)
    print(type(to_insert), to_insert)
    print(data[0])
    
    insert_comics = """
                    INSERT INTO comics (month, num, link, year, news, safe_title, transcript, alt, img, title, day)
                    VALUES (%s, %s, $s, %s, %s, %s, %s, %s, %s, %s, %s)
                    """
    #VALUES (%s, %s, $s, %s, %s, %s, %s, %s, %s, %s, %s)
    #VALUES ('5', '2459', '', '2021', '', 'March 2020', '', '"Ive traveled here from the year 2020 to bring you this vaccine!"', 'https://imgs.xkcd.com/comics/march_2020.png', 'March 2020', '5')
    with conn.cursor() as cursor:
        cursor.execute(insert_comics, data)
        conn.commit()



if __name__ == '__main__':
    today_data = retrieve_data('https://xkcd.com/info.0.json')
    print((today_data))
    print(type(today_data))
    insert_values()

    '''
    for k, v in today_data.items():
        print(f'{k}: {type(v)}')
    '''
