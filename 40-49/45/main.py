def triangle_number(n):
    return n * (n + 1) // 2

def pentagonal_number(n):
    return n * (3 * n - 1) // 2

def hexagonal_number(n):
    return n * (2 * n - 1)


start_index = 286
t_index = start_index
p_index = start_index
h_index = start_index
while True:
    t = triangle_number(t_index)
    p = pentagonal_number(p_index)
    h = hexagonal_number(h_index)

    if t == p == h:
        break

    if t <= p and t <= h:
        t_index += 1
    elif p <= t and p <= h:
        p_index += 1
    else:
        h_index += 1
print(t)