#include <iostream>
#include <vector>
using namespace std;

int main() {
  const int limit = 1000000;
  long long product = 1;

  vector<int> primes = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29};

  for (int p : primes) {
    if (product * p > limit) break;
    product *= p;
  }

  cout << product << endl;
  return 0;
}
