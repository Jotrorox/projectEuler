#include <iostream>
#include <fstream>
#include <vector>
#include <sstream>
#include <algorithm>
#include <filesystem>

std::vector<std::vector<int>> readPyramid(const std::string &filename) {
    std::ifstream file(filename);
    std::vector<std::vector<int>> pyramid;
    std::string line;

    while (std::getline(file, line)) {
        std::istringstream stream(line);
        std::vector<int> row;
        int number;
        while (stream >> number) {
            row.push_back(number);
        }
        pyramid.push_back(row);
    }

    return pyramid;
}

int findMaxPathSum(std::vector<std::vector<int>> &pyramid) {
    for (int row = pyramid.size() - 2; row >= 0; --row)
        for (int col = 0; col < pyramid[row].size(); ++col)
            pyramid[row][col] += std::max(pyramid[row + 1][col], pyramid[row + 1][col + 1]);
    return pyramid[0][0];
}

int main(int argc, char* argv[]) {
    std::filesystem::path exePath = std::filesystem::absolute(argv[0]);
    std::filesystem::path inputPath = exePath.parent_path() / "input.txt";
    
    std::vector<std::vector<int>> pyramid = readPyramid(inputPath.string());
    std::cout << findMaxPathSum(pyramid) << std::endl;
    return 0;
}
