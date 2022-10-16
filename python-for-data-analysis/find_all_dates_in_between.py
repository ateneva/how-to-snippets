
import datetime as dt


def get_file_months(start_date, end_date):
    file_months = []
    if isinstance(start_date, str):
        start_date = dt.datetime.strptime(start_date, '%Y-%m-%d')
        end_date = dt.datetime.strptime(end_date, '%Y-%m-%d')

    curr_date = start_date
    while curr_date <= end_date:
        file_month = curr_date.strftime('%Y%m')
        file_months.append(file_month)
        curr_date += dt.timedelta(days=1)
    return sorted(set(file_months))


if __name__ == '__main__':
    print(get_file_months('2022-07-01', '2022-10-30'))