function polygonalNumbers(sides) {
    let nums = [];
    let n = 1;
    while (true) {
        let p;
        if (sides === 3) p = n * (n + 1) / 2;
        else if (sides === 4) p = n * n;
        else if (sides === 5) p = n * (3 * n - 1) / 2;
        else if (sides === 6) p = n * (2 * n - 1);
        else if (sides === 7) p = n * (5 * n - 3) / 2;
        else if (sides === 8) p = n * (3 * n - 2);
        else break;
        
        if (p >= 1000 && p < 10000) nums.push(p);
        if (p >= 10000) break;
        n++;
    }
    return nums;
}
const polys = {
    3: polygonalNumbers(3),
    4: polygonalNumbers(4),
    5: polygonalNumbers(5),
    6: polygonalNumbers(6),
    7: polygonalNumbers(7),
    8: polygonalNumbers(8)
};

function firstTwo(num) {
    return Math.floor(num / 100);
}
function lastTwo(num) {
    return num % 100;
}

let result = null;

function search(chain, used) {
    if (chain.length === 6) {
        if (lastTwo(chain[5].num) === firstTwo(chain[0].num)) result = chain.slice();
        return;
    }
    let target = chain.length > 0 ? lastTwo(chain[chain.length - 1].num) : null;

    for (let poly in polys) {
        poly = Number(poly);
        if (used.has(poly)) continue;
        for (let num of polys[poly]) {
            if (chain.length > 0 && firstTwo(num) !== target) continue;
            if (lastTwo(num) < 10) continue;
            used.add(poly);
            chain.push({ num, poly });
            search(chain, used);
            if (result) return;
            chain.pop();
            used.delete(poly);
        }
    }
}

for (let poly in polys) {
    poly = Number(poly);
    for (let num of polys[poly]) {
        if (lastTwo(num) < 10) continue;
        let chain = [{ num, poly }];
        let used = new Set([poly]);
        search(chain, used);
        if (result) break;
    }
    if (result) break;
}

let sum = result.reduce((acc, cur) => acc + cur.num, 0);
console.log(sum);
