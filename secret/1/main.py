from decimal import Decimal, getcontext

precision = 1100
getcontext().prec = precision

sqrt_13 = Decimal(13).sqrt()

decimal_part = str(sqrt_13)[2:1002]

digit_sum = sum(int(digit) for digit in decimal_part)

print(digit_sum)
