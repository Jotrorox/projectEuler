#include <iostream>
using namespace std;

int getCollatzLength(long n) {
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
    int maxLength = 0;
    int answer = 0;

    for (int i = 1; i < 1000000; i++) {
        int length = getCollatzLength(i);
        if (length > maxLength) {
            maxLength = length;
            answer = i;
        }
    }

    cout << "Number " << answer << " has length " << maxLength << endl;
    return 0;
}
