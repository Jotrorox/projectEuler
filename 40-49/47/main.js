let count = 0, n = 2;
while (true) {
    let factors = 0, x = n, d = 2;
    while (x > 1) {
        if (x % d === 0) {
            factors++;
            while (x % d === 0) x /= d;
        }
        d++;
        if (d * d > x) {
            if (x > 1) factors++;
            break;
        }
    }
    if (factors === 4) {
        count++;
        if (count === 4) {
            console.log(n - 3);
            break;
        }
    } else {
        count = 0;
    }
    n++;
}
