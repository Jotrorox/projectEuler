#include <stdio.h>
#include <stdbool.h>

bool is_divisible_up_to(int number, int limit);

int main() {
    int current_number = 1;
    
    while (!is_divisible_up_to(current_number, 20)) {
        current_number++;
    }
    
    printf("The smallest positive number that is evenly divisible by all of the numbers from 1 to 20 is: %d\n", current_number);
    
    return 0;
}

bool is_divisible_up_to(int number, int limit) {
    for (int i = 1; i <= limit; i++) {
        if (number % i != 0) {
            return false;
        }
    }
    return true;
}