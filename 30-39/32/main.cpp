#include <iostream>
#include <set>
#include <string>
#include <algorithm>

bool isPandigital(const std::string &str) {
    if (str.length() != 9) return false;
    std::string digits = str;
    std::sort(digits.begin(), digits.end());
    return digits == "123456789";
}

int main() {
    std::set<int> uniqueProducts;
    int sum = 0;

    for (int a = 1; a < 100; ++a) {
        for (int b = a + 1; b < 10000 / a; ++b) {
            int product = a * b;
            std::string concatenated = std::to_string(a) + std::to_string(b) + std::to_string(product);
            if (isPandigital(concatenated)) {
                if (uniqueProducts.find(product) == uniqueProducts.end()) {
                    uniqueProducts.insert(product);
                    sum += product;
                }
            }
        }
    }

    std::cout << "Sum of all products: " << sum << std::endl;
    return 0;
}