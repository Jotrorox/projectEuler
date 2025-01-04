let a = 0, b = 1;
let sum = 0;

for (let next = a + b; next < 4_000_000; next = a + b) {
    if (next % 2 === 0) sum += next;
    a = b;
    b = next;
}

console.log(sum)