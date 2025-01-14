var a = 0, b = 1, sum = 0

while b < 4_000_000 {
    sum = b % 2 == 0 ? sum + b : sum
    let next = a + b
    a = b
    b = next
}

print(sum)