#include <stdio.h>

int main(int argc, char *argv[]) {
    (void)argc;
    (void)argv;

    int sum = 0;
    int current = 1;
    int previous = 0;
    int temp;

    for (;;) {
        if (current > 4000000) {
            break;
        }
        
        if (current % 2 == 0) {
            sum += current;
        }

        temp = current;
        current = current + previous;
        previous = temp;
    }

    printf("Sum of even Fibonacci numbers: %d\n", sum);

    return 0;
}