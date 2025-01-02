#include <stdio.h>

int is_palindrome(int number);

int main() {
    int current_max = 0;

    for (int i = 100; i < 1000; i++) {
        for (int j = 100; j < 1000; j++) {
            int product = i * j;
            if (product > current_max && is_palindrome(product)) {
                current_max = product;
            }
        }
    }

    printf("The largest palindrome made from the product of two 3-digit numbers is: %d\n", current_max);

    return 0;
}

int is_palindrome(int number) {
    int original = number;
    int reversed = 0;
    while (number > 0) {
        reversed = reversed * 10 + number % 10;
        number /= 10;
    }
    return original == reversed;
}