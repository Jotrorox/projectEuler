let nums = [];

for (let a = 2; a <= 100; a++) {
    for (let b  = 2; b <= 100; b++) {
        if (nums.indexOf(a**b) === -1) nums.push(a ** b);
    }
}

console.log(nums.length)