#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

// Function to precompute factorials for digits 0 to 9
vector<int> precomputeFactorials() {
    vector<int> factorials(10, 1);
    for (int i = 1; i <= 9; ++i) {
        factorials[i] = factorials[i - 1] * i;
    }
    return factorials;
}

// Function to calculate the sum of factorial of digits of a number
int sumOfDigitFactorials(int number, const vector<int>& factorials) {
    int sum = 0;
    while (number > 0) {
        int digit = number % 10;
        sum += factorials[digit];
        number /= 10;
    }
    return sum;
}

int main() {
    // Precompute factorials of digits 0 to 9
    vector<int> factorials = precomputeFactorials();

    // Determine the upper limit: For 7 digits, 7 * 9! is 2540160, which is sufficient
    const int UPPER_LIMIT = 7 * factorials[9];

    int totalSum = 0;

    // Iterate through all numbers and find those equal to the sum of factorials of their digits
    for (int i = 10; i <= UPPER_LIMIT; ++i) { // Start from 10 to exclude 1 and 2
        if (i == sumOfDigitFactorials(i, factorials)) {
            totalSum += i;
        }
    }

    // Output the result
    cout << totalSum << endl;

    return 0;
}

