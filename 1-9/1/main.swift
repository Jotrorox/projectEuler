var sum = 0

for num in 0...999 {
    if num % 3 == 0 || num % 5 == 0 {
        sum += num
    }
}

print(sum)