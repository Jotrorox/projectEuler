#include <stdio.h>
#include <stdbool.h>

// Function to check if a number is palindromic in base 10
bool is_palindromic_base10(int num) {
    int original = num, reversed = 0;
    
    // Reverse the number
    while (num > 0) {
        reversed = reversed * 10 + (num % 10);
        num /= 10;
    }
    
    return original == reversed;
}

// Function to check if a number is palindromic in base 2
bool is_palindromic_base2(int num) {
    int original = num, reversed = 0;
    
    // Reverse the number's binary representation
    while (num > 0) {
        reversed = (reversed << 1) | (num & 1); // Shift reversed left and add the last bit
        num >>= 1; // Right shift the original number
    }
    
    return original == reversed;
}

int main() {
    int sum = 0;

    // Iterate through all numbers less than 1 million
    for (int i = 1; i < 1000000; i++) {
        if (is_palindromic_base10(i) && is_palindromic_base2(i)) {
            sum += i;
        }
    }
    
    // Output the sum of all palindromic numbers in both base 10 and base 2
    printf("The sum is: %d\n", sum);
    
    return 0;
}

