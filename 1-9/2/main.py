sum_of_evens = 0
a, b = 0, 1

while b <= 4000000:
    if b % 2 == 0: sum_of_evens += b
    a, b = b, a + b

print(f"Sum of even Fibonacci numbers: {sum_of_evens}")
