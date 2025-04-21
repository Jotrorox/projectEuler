#include <iostream>

bool is_palindrome(int number) {
    int original = number;
    int reversed = 0;
    while (number > 0) {
        reversed = reversed * 10 + number % 10;
        number /= 10;
    }
    return original == reversed;
}

int main() {
    int current_max = 0;

    for (int i = 100; i < 1000; ++i) {
        for (int j = 100; j < 1000; ++j) {
            int product = i * j;
            if (product > current_max && is_palindrome(product))
                current_max = product;
        }
    }

    std::cout << current_max << std::endl;

    return 0;
}
