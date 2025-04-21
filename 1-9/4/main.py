is_palindrome = lambda n: str(n) == str(n)[::-1]

current_max = 0

for i in range(100, 1000):
    for j in range(100, 1000):
        product = i * j
        if product > current_max and is_palindrome(product):
            current_max = product

print(current_max)
