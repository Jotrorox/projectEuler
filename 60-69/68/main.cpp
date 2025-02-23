#include <algorithm>
#include <iostream>
#include <string>
#include <vector>

using namespace std;

int main() {
  vector<int> v{1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
  string maxStr = "";

  do {
    vector<int> external(v.begin(), v.begin() + 5);
    vector<int> internal(v.begin() + 5, v.end());

    bool isCanonical = true;
    for (int i = 1; i < 5; i++)
      if (external[i] < external[0]) {
        isCanonical = false;
        break;
      }
    if (!isCanonical) continue;

    int sum = external[0] + internal[0] + internal[1];
    bool valid = true;

    for (int i = 1; i < 4; i++)
      if (external[i] + internal[i] + internal[i + 1] != sum) {
        valid = false;
        break;
      }

    if (valid && (external[4] + internal[4] + internal[0] != sum)) valid = false;

    if (valid) {
      string candidate = "";
      for (int i = 0; i < 5; i++) {
        candidate += to_string(external[i]);
        candidate += to_string(internal[i]);
        candidate += to_string(internal[(i + 1) % 5]);
      }
      if (candidate.length() == 16 && candidate > maxStr) maxStr = candidate;
    }
  } while (next_permutation(v.begin(), v.end()));

  cout << maxStr << endl;
  return 0;
}
