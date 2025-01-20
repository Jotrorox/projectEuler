#include <stdio.h>
#include <stdlib.h>
#include <math.h>

long* primeFactors(long n, int* size) {
    long* factors = malloc(sizeof(long) * 100);
    int index = 0;

    while (n % 2 == 0) {
        factors[index++] = 2;
        n = n / 2;
    }

    for (long i = 3; i <= sqrt(n); i = i + 2) {
        while (n % i == 0) {
            factors[index++] = i;
            n = n / i;
        }
    }

    if (n > 2) {
        factors[index++] = n;
    }

    *size = index;
    return factors;
}

int main() {
    long n = 600851475143;
    int size;
    long* factors = primeFactors(n, &size);

    if (size > 0) printf("%ld\n", factors[size - 1]);

    free(factors);
    return 0;
}