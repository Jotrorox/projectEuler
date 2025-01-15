#include <iostream>

int main() {
    int sum = 0;

    for (int i = 0; i < 1000; i++)
        sum = (i % 3 == 0 || i % 5 == 0) ? sum + i : sum;

    std::cout << "Sum: " << sum << std::endl;

    return 0;
}