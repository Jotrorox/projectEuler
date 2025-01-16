#include <stdio.h>
#include <math.h>

int main() {
    int limit = 354294, total_sum = 0;

    for (int i = 2; i <= limit; i++) {
        int sum = 0, num = i;
        while (num > 0) {
            sum += pow(num % 10, 5);
            num /= 10;
        }
        if (sum == i) total_sum += i;
    }

    printf("%d", total_sum);
    return 0;
}
