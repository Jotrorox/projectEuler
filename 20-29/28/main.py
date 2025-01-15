layers = (1001 - 1) // 2
total_sum = 1
for k in range(1, layers + 1):
    corners_sum = 4 * (2 * k + 1) ** 2 - 12 * k
    total_sum += corners_sum
print(total_sum)