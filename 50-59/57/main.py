def count_digits(n):
    return len(str(n))

n_prev_prev = 1
n_prev = 3
d_prev_prev = 1
d_prev = 2

count = 0
for i in range(1000):
    n = 2 * n_prev + n_prev_prev
    d = 2 * d_prev + d_prev_prev
    
    if count_digits(n) > count_digits(d):
        count += 1
    
    n_prev_prev = n_prev
    n_prev = n
    d_prev_prev = d_prev
    d_prev = d

print(count)