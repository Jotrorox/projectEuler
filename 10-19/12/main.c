#include <stdio.h>
#include <math.h>

int count_divisors(int n) {
    int count = 0;
    int sqrt_n = (int)sqrt(n);

    for (int i = 1; i <= sqrt_n; i++) if (n % i == 0) count += 2;

    if (sqrt_n * sqrt_n == n) count--;

    return count;
}

int main() {
    int n = 1;
    int triangle_number = 0;

    while (1) {
        triangle_number += n;
        int divisors = count_divisors(triangle_number);

        if (divisors > 500) {
            printf("%d\n", triangle_number);
            break;
        }

        n++;
    }

    return 0;
}
