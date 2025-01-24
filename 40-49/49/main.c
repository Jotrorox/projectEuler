#include <stdio.h>
#include <stdbool.h>

bool isPermutation(int num1, int num2) {
    for (int i = 0; i < 10; i++) {
        int count1 = 0, count2 = 0, temp1 = num1, temp2 = num2;
        while (temp1 > 0) {
            if (temp1 % 10 == i) count1++;
            temp1 /= 10;
        }
        while (temp2 > 0) {
            if (temp2 % 10 == i) count2++;
            temp2 /= 10;
        }
        if (count1 != count2) return false;
    }
    return true;
}

bool isPrime(int num) {
    if (num < 2) return false;
    for (int i = 2; i * i <= num; i++) {
        if (num % i == 0) return false;
    }
    return true;
}

int main() {
    for (int i = 1000; i <= 9999; i++) {
        if (i == 1487) continue;
        int nums[] = {i, i + 3330, i + 3330*2};
        if (isPrime(nums[0]) && isPrime(nums[1]) && isPrime(nums[2])) {
            if (isPermutation(nums[0], nums[1]) && isPermutation(nums[0], nums[2])) {
                printf("%d%d%d\n", nums[0], nums[1], nums[2]);
                break;
            }
        }
    }
    return 0;
}
