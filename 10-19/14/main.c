#include <stdio.h>

int get_sequence_length(long n) {
    int length = 1;
    while (n != 1) {
        if (n % 2 == 0) {
            n = n / 2;
        } else {
            n = 3 * n + 1;
        }
        length++;
    }
    return length;
}

int main() {
    int max_length = 0;
    int answer = 0;

    for (int i = 1; i < 1000000; i++) {
        int length = get_sequence_length(i);
        if (length > max_length) {
            max_length = length;
            answer = i;
        }
    }

    printf("%d\n", max_length);
    return 0;
}
