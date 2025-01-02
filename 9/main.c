#include <stdio.h>

int main() {
    int a, b, c;
    int sum = 1000;

    for (a = 1; a < sum / 3; a++) {
        for (b = a + 1; b < sum / 2; b++) {
            c = sum - a - b;

            if (a * a + b * b == c * c) {
                printf("The Pythagorean triplet is: a = %d, b = %d, c = %d\n", a, b, c);
                printf("The product abc is: %d\n", a * b * c);
                return 0;
            }
        }
    }

    printf("No Pythagorean triplet found.\n");
    return 1;
}