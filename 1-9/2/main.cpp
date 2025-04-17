#include <iostream>

int main() {
    long long sum = 0;
    long long current = 1;
    long long previous = 0;

    while (current <= 4000000) {
        if (current % 2 == 0) sum += current;

        long long next = current + previous;
        previous = current;
        current = next;
    }

    std::cout << "Sum of even Fibonacci numbers: " << sum << std::endl;

    return 0;
}
