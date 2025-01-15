let amicableNumbers = [];

for(var i = 0; i < 10_000; i++) {
    if (amicableNumbers.includes(i)) {
        continue;
    }

    let sum1 = 0;
    let sum2 = 0;

    for (var j = 1; j < i; j++) {
        if (i % j === 0) {
            sum1 += j;
        }
    }

    for (var j = 1; j < sum1; j++) {
        if (sum1 % j === 0) {
            sum2 += j;
        }
    }

    if (i === sum2 && i !== sum1) {
        amicableNumbers.push(i);
        amicableNumbers.push(sum1);
    }
}

console.log(amicableNumbers.reduce((acc, curr) => acc + curr, 0));