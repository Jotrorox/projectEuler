num = 20

while True:
    for i in range(1, 20 + 1):
        if num % i != 0:
            break
    else:
        print(num)
        break
    num += 20