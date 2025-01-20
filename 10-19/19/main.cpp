#include <iostream>
using namespace std;

bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}

int main() {
    int daysInMonths[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    int dayOfWeek = 1;
    int sundaysOnFirst = 0;

    for (int year = 1900; year < 1901; year++)
        for (int month = 0; month < 12; month++)
            dayOfWeek = (dayOfWeek + daysInMonths[month] + (month == 1 && isLeapYear(year) ? 1 : 0)) % 7;

    for (int year = 1901; year <= 2000; year++) {
        for (int month = 0; month < 12; month++) {
            if (dayOfWeek == 0) sundaysOnFirst++;
            dayOfWeek = (dayOfWeek + daysInMonths[month] + (month == 1 && isLeapYear(year) ? 1 : 0)) % 7;
        }
    }

    cout << sundaysOnFirst << endl;
    return 0;
}