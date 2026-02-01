#include <stdio.h>
#include <stdint.h>

#define LIMIT 1000000

int main(void) {
    static uint32_t phi[LIMIT + 1];
    uint64_t sum = 0;

    for (uint32_t i = 0; i <= LIMIT; i++) {
        phi[i] = i;
    }

    for (uint32_t i = 2; i <= LIMIT; i++) {
        if (phi[i] == i) {
            for (uint32_t j = i; j <= LIMIT; j += i) {
                phi[j] -= phi[j] / i;
            }
        }
    }

    for (uint32_t i = 2; i <= LIMIT; i++) {
        sum += phi[i];
    }

    printf("%llu\n", (unsigned long long)sum);
    return 0;
}
