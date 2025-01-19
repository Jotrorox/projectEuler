#include <iostream>
#include <vector>
#include <cmath>
#include <string>
#include <algorithm>

// Function to check if a number is prime using Sieve of Eratosthenes
std::vector<bool> sieve(int limit) {
    std::vector<bool> is_prime(limit, true);
    is_prime[0] = is_prime[1] = false; // 0 and 1 are not primes
    for (int i = 2; i * i < limit; ++i) {
        if (is_prime[i]) {
            for (int j = i * i; j < limit; j += i) {
                is_prime[j] = false;
            }
        }
    }
    return is_prime;
}

// Function to generate all rotations of a number
std::vector<int> generate_rotations(int num) {
    std::vector<int> rotations;
    std::string s = std::to_string(num);
    int len = s.length();
    for (int i = 0; i < len; ++i) {
        std::rotate(s.begin(), s.begin() + 1, s.end());
        rotations.push_back(std::stoi(s));
    }
    return rotations;
}

// Function to check if all rotations of a number are prime
bool is_circular_prime(int num, const std::vector<bool>& is_prime) {
    std::vector<int> rotations = generate_rotations(num);
    for (int rotation : rotations) {
        if (!is_prime[rotation]) return false;
    }
    return true;
}

int main() {
    const int LIMIT = 1000000;
    std::vector<bool> is_prime = sieve(LIMIT);
    int circular_prime_count = 0;

    // Check all numbers below the limit
    for (int i = 2; i < LIMIT; ++i) {
        if (is_prime[i] && is_circular_prime(i, is_prime)) {
            ++circular_prime_count;
        }
    }

    std::cout << "Number of circular primes below " << LIMIT << ": " << circular_prime_count << std::endl;

    return 0;
}

