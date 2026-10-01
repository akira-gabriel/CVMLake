from bcb.blocks import generate_data_blocks
from datetime import date

a = generate_data_blocks(date(2023, 10, 25),date(2055, 10, 25), 10)
print(a)