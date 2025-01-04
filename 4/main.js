function isPalindromeNumber(num) {
    let num_str = num.toString();
    let num_str_rev = num_str.split('').reverse().join('');
    return num_str === num_str_rev;
}

let max = 0;

for (let i = 100; i < 1000; i++) {
    for (let j = 100; j < 1000; j++) {
        if(isPalindromeNumber(i * j)) {
            max = (i * j > max) ? i * j : max;
        }
    }
}

console.log(max);