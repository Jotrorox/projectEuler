#include <stdio.h>
#include <stdbool.h>

bool is_divisible_up_to(int number, int limit) {
    for (int i = 1; i <= limit; i++) if (number % i != 0) return false;
    return true;
}

int main() {
    int current_number = 1;
    
    while (!is_divisible_up_to(current_number, 20)) current_number++;
    
    printf("%d\n", current_number);
    
    return 0;
}