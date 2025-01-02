#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

unsigned long long sum_of_primes_below_limit(int limit) {
    bool *is_prime = (bool *)malloc(limit * sizeof(bool));
    if (!is_prime) {
        fprintf(stderr, "Memory allocation failed!\n");
        return 0;
    }

    for (int i = 0; i < limit; i++) {
        is_prime[i] = true;
    }

    is_prime[0] = false;
    is_prime[1] = false;

    for (int p = 2; p * p < limit; p++) {
        if (is_prime[p]) {
            for (int multiple = p * p; multiple < limit; multiple += p) {
                is_prime[multiple] = false;
            }
        }
    }

    unsigned long long sum = 0;
    for (int i = 2; i < limit; i++) {
        if (is_prime[i]) {
            sum += i;
        }
    }

    free(is_prime);

    return sum;
}

int main() {
    int max = 2000000;
    unsigned long long result = sum_of_primes_below_limit(max);
    printf("The sum of all primes below %d is %llu\n", max, result);
    return 0;
}
