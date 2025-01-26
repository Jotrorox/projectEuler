import math

def find_count_exceeding_million():
    count = 0
    for n in range(23, 101):
        for r in range(1, n + 1):
            if math.factorial(n) // (math.factorial(r) * math.factorial(n - r)) > 10**6:
                count += 1
    return count

print(find_count_exceeding_million())
