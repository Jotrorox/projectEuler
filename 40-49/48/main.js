let sum = 0;
const MOD = 10000000000; // 10^10 to keep track of the last ten digits

for (let i = 1; i <= 1000; i++) {
    // Calculate i^i % MOD efficiently
    let term = 1;
    for (let j = 0; j < i; j++) {
        term = (term * i) % MOD;
    }

    // Add the current term to the sum and take modulo MOD
    sum = (sum + term) % MOD;
}

console.log(sum)

