from itertools import permutations

def is_substring_divisible(num_str):
    primes = [2, 3, 5, 7, 11, 13, 17]
    for i in range(1, 8):
        if int(num_str[i:i+3]) % primes[i-1] != 0:
            return False
    return True

pandigital_numbers = [''.join(p) for p in permutations('0123456789')]
result = sum(int(num) for num in pandigital_numbers if is_substring_divisible(num))
print(result)