#include <stdio.h>
#include <stdbool.h>

bool is_prime(int n);

int main() {
    int count = 0;
    int number = 1;
    int target = 10001;

    while (count < target) {
        number++;
        if (is_prime(number)) count++;
    }

    printf("%d\n", number);
    return 0;
}

bool is_prime(int n) {
    if (n < 2) return false;
    for (int i = 2; i * i <= n; i++) if (n % i == 0) return false;
    return true;
}