#include <iostream>
#include <cmath>
#include <vector>

bool isPrime(int num) {
    if (num < 2) return false;
    for (int i = 2; i <= std::sqrt(num); ++i)
        if (num % i == 0) return false;
    return true;
}

int main() {
    int maxPrimes = 0;
    int productOfCoefficients = 0;

    for (int a = -999; a < 1000; ++a) {
        for (int b = -1000; b <= 1000; ++b) {
            int n = 0;
            while (true) {
                int quadraticValue = n * n + a * n + b;
                if (!isPrime(quadraticValue)) break;
                ++n;
            }

            if (n > maxPrimes) {
                maxPrimes = n;
                productOfCoefficients = a * b;
            }
        }
    }

    std::cout << productOfCoefficients << std::endl;
    return 0;
}