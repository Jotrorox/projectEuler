#include <stdio.h>
#include <string.h>

#define MAX 5000

int multiply(int x, int result[], int result_size) {
    int carry = 0;

    for (int i = 0; i < result_size; i++) {
        int prod = result[i] * x + carry;
        result[i] = prod % 10;
        carry = prod / 10;
    }

    while (carry) {
        result[result_size] = carry % 10;
        carry = carry / 10;
        result_size++;
    }

    return result_size;
}

int factorial_digit_sum(int n) {
    int result[MAX];
    result[0] = 1;
    int result_size = 1;

    for (int x = 2; x <= n; x++) {
        result_size = multiply(x, result, result_size);
    }

    int sum = 0;
    for (int i = 0; i < result_size; i++) {
        sum += result[i];
    }
    return sum;
}

int main() {
    int n = 100;
    printf("Sum of the digits in %d! is %d\n", n, factorial_digit_sum(n));
    return 0;
}
