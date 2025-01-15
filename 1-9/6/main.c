#include <stdio.h>

int main() {
    int sum_of_squares = 0;
    int square_of_sum = 0;

    for (int i = 1; i <= 100; i++) {
        sum_of_squares += i * i;
        square_of_sum += i;
    }

    square_of_sum *= square_of_sum;

    printf("The difference between the sum of the squares of the first one hundred natural numbers and the square of the sum is: %d\n", square_of_sum - sum_of_squares);

    return 0;
}