const fs = require('fs');
const path = require('path');

function readPyramid(filename) {
    const data = fs.readFileSync(filename, 'utf-8');
    return data.split('\n').map(line => line.trim().split(/\s+/).map(Number));
}

function findMaxPathSum(pyramid) {
    for (let row = pyramid.length - 2; row >= 0; row--) {
        for (let col = 0; col < pyramid[row].length; col++) {
            pyramid[row][col] += Math.max(pyramid[row + 1][col], pyramid[row + 1][col + 1]);
        }
    }
    return pyramid[0][0];
}

const filename = path.resolve(__dirname, 'input.txt');
const pyramid = readPyramid(filename);
console.log('Maximum Path Sum:', findMaxPathSum(pyramid));
