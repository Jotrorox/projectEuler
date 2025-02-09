import math

def continued_fraction_period(n):
    a0 = int(math.sqrt(n))
    if a0 * a0 == n:
        return 0

    m = 0
    d = 1
    a = a0
    period = 0

    while True:
        m = d * a - m
        d = (n - m * m) // d
        a = (a0 + m) // d
        period += 1
        if a == 2 * a0:
            break

    return period

def count_odd_periods(limit):
    odd_period_count = 0
    for n in range(2, limit + 1):
        if int(math.sqrt(n))**2 == n:
            continue
        if continued_fraction_period(n) % 2 == 1:
            odd_period_count += 1
    return odd_period_count

if __name__ == '__main__':
    limit = 10000
    result = count_odd_periods(limit)
    print(result)
