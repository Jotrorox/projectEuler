#include <stdio.h>
#include <stdbool.h>
#include <math.h>

bool is_prime(int n) {
  if (n < 2) return false;
  for (int i = 2; i <= sqrt(n); i++) if(n % i == 0) return false;
  return true;
}

bool is_truncatable_left(int n) {
  for (int divisor = 10; divisor < n; divisor *= 10) if (!is_prime(n % divisor)) return false;
  return true;
}

bool is_truncatable_right(int n) {
  while (n > 0) {
    if (!is_prime(n)) return false;
    n /= 10;
  }
  return true;
}

int main() {
  int count = 0, sum = 0;
  for (int n = 11; count < 11; n += 2) {
    if (is_prime(n) && is_truncatable_left(n) && is_truncatable_right(n)) {
      count++;
      sum += n;
    }
  }
  printf("%d\n", sum);
  return 0;
}
