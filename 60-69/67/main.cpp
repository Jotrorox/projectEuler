#include <iostream>
#include <fstream>
#include <vector>
#include <sstream>
#include <algorithm>
#include <filesystem>

namespace fs = std::filesystem;
using std::ifstream;
using std::vector;
using std::string;
using std::getline;
using std::istringstream;
using std::max;
using std::cout;
using std::endl;

vector<vector<int>> readPyramid(const string &filename) {
    ifstream file(filename);
    vector<vector<int>> pyramid;
    string line;

    while (getline(file, line)) {
        istringstream stream(line);
        vector<int> row;
        int number;
        while (stream >> number) {
            row.push_back(number);
        }
        pyramid.push_back(row);
    }

    return pyramid;
}

int findMaxPathSum(vector<vector<int>> &pyramid) {
    for (int row = pyramid.size() - 2; row >= 0; --row)
        for (int col = 0; col < pyramid[row].size(); ++col)
            pyramid[row][col] += max(pyramid[row + 1][col], pyramid[row + 1][col + 1]);
    return pyramid[0][0];
}

int main(int argc, char* argv[]) {
    fs::path exePath = fs::absolute(argv[0]);
    fs::path inputPath = exePath.parent_path() / "input.txt";
    
    vector<vector<int>> pyramid = readPyramid(inputPath.string());
    cout << findMaxPathSum(pyramid) << endl;
    return 0;
}