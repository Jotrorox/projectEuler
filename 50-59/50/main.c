#include <stdio.h>
#include <stdbool.h>

#define LIMIT 1000000

bool is_prime(int n) {
    if (n < 2) return false;
    if (n == 2 || n == 3) return true;
    if (n % 2 == 0 || n % 3 == 0) return false;
    for (int i = 5; i * i <= n; i += 6) if (n % i == 0 || n % (i + 2) == 0) return false;
    return true;
}

void generate_primes(int *primes, int *prime_count) {
    bool sieve[LIMIT] = { false };
    for (int i = 2; i < LIMIT; i++) sieve[i] = true;

    for (int i = 2; i * i < LIMIT; i++) if (sieve[i])
        for (int j = i * i; j < LIMIT; j += i) sieve[j] = false;

    *prime_count = 0;
    for (int i = 2; i < LIMIT; i++) if (sieve[i]) primes[(*prime_count)++] = i;
}

int main() {
    int primes[80000];
    int prime_count;
    generate_primes(primes, &prime_count);

    int max_length = 0, max_prime = 0;

    for (int i = 0; i < prime_count; i++) {
        int sum = 0;
        for (int j = i; j < prime_count; j++) {
            sum += primes[j];
            if (sum >= LIMIT) break;
            if (j - i + 1 > max_length && is_prime(sum)) {
                max_length = j - i + 1;
                max_prime = sum;
            }
        }
    }

    printf("%d\n", max_prime);

    return 0;
}
