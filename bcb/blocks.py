from dateutil.relativedelta import relativedelta
from datetime import date, timedelta

def generate_data_blocks(init_date, finish_date, years_block):
    l_date = []
    d_control = init_date

    while True:
        time_mark = d_control + relativedelta(years=years_block)

        if time_mark >= finish_date:
            l_date.append((d_control, finish_date))
            break
        else:
            l_date.append((d_control, time_mark - timedelta(days=1)))
            d_control = time_mark

    return l_date

a = generate_data_blocks(date(2023, 10, 25),date(2055, 10, 25), 10)
print(a)