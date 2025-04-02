import math

def sieve_euler_totient(limit):
    phi = list(range(limit + 1))

    for i in range(2, limit + 1):
        if phi[i] == i:
            for j in range(i, limit + 1, i): 
            	phi[j] -= phi[j] // i

    return phi


def is_permutation(a, b):
    return sorted(str(a)) == sorted(str(b))


limit = 10**7
phi = sieve_euler_totient(limit)
min_ratio = float('inf')
min_x = 0

for x in range(2, limit + 1):
    if is_permutation(phi[x], x):
        ratio = x / phi[x]
        if ratio < min_ratio:
            min_ratio = ratio
            min_x = x

print(min_x)