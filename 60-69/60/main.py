import math
from functools import lru_cache

@lru_cache(maxsize=None)
def is_prime(n):
    if n < 2:
        return False
    if n in (2, 3):
        return True
    if n % 2 == 0:
        return False
    r = int(math.sqrt(n))
    for i in range(3, r + 1, 2):
        if n % i == 0:
            return False
    return True

def concat(a, b):
    return int(str(a) + str(b))

def is_valid_pair(a, b):
    return is_prime(concat(a, b)) and is_prime(concat(b, a))

def sieve(n):
    sieve = [True] * (n + 1)
    sieve[0] = sieve[1] = False
    for i in range(2, int(n ** 0.5) + 1):
        if sieve[i]:
            for j in range(i * i, n + 1, i):
                sieve[j] = False
    return [i for i, prime in enumerate(sieve) if prime]

def search_set(current_set, start, current_sum, best_sum, primes):
    if len(current_set) == 5:
        if current_sum < best_sum[0]:
            best_sum[0] = current_sum
        return current_sum
    for i in range(start, len(primes)):
        p = primes[i]
        if current_sum + p * (5 - len(current_set)) >= best_sum[0]:
            break
        if all(is_valid_pair(p, q) for q in current_set):
            search_set(current_set + [p], i + 1, current_sum + p, best_sum, primes)
    return best_sum[0]

primes = sieve(10000)
best_sum = [10**9]
result = search_set([], 0, 0, best_sum, primes)
print("Lowest sum:", result)