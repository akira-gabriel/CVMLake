from datetime import timedelta
from dateutil.relativedelta import relativedelta


def generate_date_blocks(init_date, finish_date, years_block):

    if init_date > finish_date:
        raise ValueError("erro por init_date depois de finish_date")
    if years_block < 1:
        raise ValueError("years_block menor que 1")

    l_date = []
    d_control = init_date

    while True:
        time_mark = d_control + relativedelta(years=years_block)

        if time_mark > finish_date:
            l_date.append((d_control, finish_date))
            break
        else:
            l_date.append((d_control, time_mark - timedelta(days=1)))
            d_control = time_mark

    return l_date