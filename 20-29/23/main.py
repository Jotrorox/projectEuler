def get_proper_divisors_sum(n):
    divisors = [1]
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            divisors.append(i)
            if i != n // i:
                divisors.append(n // i)
    return sum(divisors)

def find_abundant_numbers(limit):
    return [n for n in range(12, limit + 1) if get_proper_divisors_sum(n) > n]

LIMIT = 28123
abundant_numbers = find_abundant_numbers(LIMIT)
abundant_set = set(abundant_numbers)

def is_sum_of_two_abundant(n):
    for a in abundant_numbers:
        if a >= n:
            break
        if (n - a) in abundant_set:
            return True
    return False

total_sum = sum(n for n in range(1, LIMIT + 1) if not is_sum_of_two_abundant(n))

print("The sum of all positive integers that cannot be written as the sum of two abundant numbers is:", total_sum)
