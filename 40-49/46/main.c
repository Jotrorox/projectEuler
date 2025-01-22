#include <stdio.h>
#include <stdbool.h>
#include <math.h>

bool is_prime(int n) {
    if (n < 2) {
        return false;
    }
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) {
            return false;
        }
    }
    return true;
}

bool can_be_written_as_sum(int n) {
    for (int i = 1; 2 * i * i < n; i++) {
        if (is_prime(n - 2 * i * i)) {
            return true;
        }
    }
    return false;
}

int main() {
    int n = 9;

    while (true) {
        if (!is_prime(n) && !can_be_written_as_sum(n)) {
            printf("%d\n", n);
            break;
        }
        n += 2;
    }

    return 0;
}