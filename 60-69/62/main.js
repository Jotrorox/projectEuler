function sortedDigits(n) {
    return n.toString().split('').sort().join('');
}

const cubes = {};
let i = 1;
let answer = null;

while (true) {
    const cube = i * i * i;
    const key = sortedDigits(cube);

    if (!cubes[key]) cubes[key] = [];
    cubes[key].push(cube);

    if (cubes[key].length === 5) {
        answer = Math.min(...cubes[key]);
        break;
    }

    i++;
}

console.log(answer);
