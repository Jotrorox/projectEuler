let numProduct = 1, denProduct = 1;

for (let num = 10; num < 100; num++) {
    for (let den = num + 1; den < 100; den++) {
        let [n1, n2] = num.toString().split("").map(Number);
        let [d1, d2] = den.toString().split("").map(Number);

        if (n2 === d1 && d2 !== 0 && num * d2 === den * n1) {
            numProduct *= num;
            denProduct *= den;
        }
    }
}

function gcd(a, b) {
    return b === 0 ? a : gcd(b, a % b);
}

console.log(denProduct / gcd(numProduct, denProduct));

