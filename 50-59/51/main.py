from itertools import combinations

def is_prime(n):
    if n < 2:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return False
    return True

def generate_primes(limit):
    primes = []
    for n in range(2, limit):
        if is_prime(n):
            primes.append(n)
    return primes

def find_smallest_prime_family(family_size):
    def generate_patterns(prime_str, num_replacements):
        indices = range(len(prime_str))
        for positions in combinations(indices, num_replacements):
            pattern = list(prime_str)
            for pos in positions:
                pattern[pos] = '*'
            yield ''.join(pattern)

    def count_prime_family(pattern):
        primes = []
        for digit in '0123456789':
            if pattern[0] == '*' and digit == '0':
                continue
            candidate = int(pattern.replace('*', digit))
            if is_prime(candidate):
                primes.append(candidate)
        return primes

    primes = generate_primes(1000000)
    for prime in primes:
        prime_str = str(prime)
        for num_replacements in range(1, len(prime_str)):
            for pattern in generate_patterns(prime_str, num_replacements):
                prime_family = count_prime_family(pattern)
                if len(prime_family) == family_size:
                    return min(prime_family)

result = find_smallest_prime_family(8)
print(result)
