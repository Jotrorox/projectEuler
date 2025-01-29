def is_prime(n):
    if n < 2:
        return False
    if n in (2, 3):
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True

def find_spiral_below_threshold(threshold=0.1):
    side_length = 1
    prime_count = 0
    total_diagonal_count = 1
    
    n = 1
    while True:
        n += 2
        
        corner1 = n**2
        corner2 = corner1 - (n - 1)
        corner3 = corner2 - (n - 1)
        corner4 = corner3 - (n - 1)
        
        for corner in [corner2, corner3, corner4]:
            if is_prime(corner):
                prime_count += 1
        
        total_diagonal_count += 4
        
        ratio = prime_count / total_diagonal_count
        
        if ratio < threshold:
            return n

result = find_spiral_below_threshold()
print(result)
