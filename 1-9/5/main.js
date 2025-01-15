function checkDivisible(num) {
    for (let i = 1; i <= 20; i++) {
        if (num % i != 0) return false
    }
    return true
}

let a = 0;

for (let j = 1; !checkDivisible(j); j++) {
    a = j;
}

console.log(a+1);