#include <stdio.h>
#include <math.h>

int main() {
    // Constants
    double phi = (1 + sqrt(5)) / 2;  // Golden ratio
    double log_phi = log10(phi);
    double log_sqrt5 = log10(sqrt(5));

    // Calculate the index n
    int n = (int) ceil((999 + log_sqrt5) / log_phi);

    // Print the result
    printf("The index of the first Fibonacci number with 1000 digits is: %d\n", n);

    return 0;
}
