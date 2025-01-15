function getProperDivisorsSum(n) {
    let sum = 1;
    for (let i = 2; i <= Math.sqrt(n); i++) {
        if (n % i === 0) {
            sum += i;
            if (i !== n / i) {
                sum += n / i;
            }
        }
    }
    return sum;
}

function findAbundantNumbers(limit) {
    let abundantNumbers = [];
    for (let n = 12; n <= limit; n++) {
        if (getProperDivisorsSum(n) > n) {
            abundantNumbers.push(n);
        }
    }
    return abundantNumbers;
}

const LIMIT = 28123;
const abundantNumbers = findAbundantNumbers(LIMIT);
const abundantSet = new Set(abundantNumbers);

function isSumOfTwoAbundant(n) {
    for (let a of abundantNumbers) {
        if (a >= n) break;
        if (abundantSet.has(n - a)) return true;
    }
    return false;
}

let totalSum = 0;
for (let n = 1; n <= LIMIT; n++) {
    if (!isSumOfTwoAbundant(n)) {
        totalSum += n;
    }
}

console.log("The sum of all positive integers that cannot be written as the sum of two abundant numbers is:", totalSum);