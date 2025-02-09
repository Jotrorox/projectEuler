count = 0
for n in range(1, 30):
    for k in range(1, 10):
        if len(str(k**n)) == n:
            count += 1
print(count)
