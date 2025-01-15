const limit = 1000;
let maxD = 0, maxLength = 0;

for (let d = 2; d < limit; d++) {
    let remainders = [], remainder = 1, position = 0;

    while (!remainders[remainder] && remainder !== 0) {
        remainders[remainder] = position++;
        remainder = (remainder * 10) % d;
    }

    let cycleLength = position - (remainders[remainder || 0]);
    if (cycleLength > maxLength) {
        maxLength = cycleLength;
        maxD = d;
    }
}

console.log(maxD);
