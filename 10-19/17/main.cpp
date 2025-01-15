#include <iostream>
#include <string>
#include <algorithm>

std::string numberToWords(int num) {
    std::string ones[] = {"", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"};
    std::string teens[] = {"", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"};
    std::string tens[] = {"", "ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"};

    if (num == 1000) return "one thousand";

    std::string words = "";

    if (num / 100 > 0) {
        words += ones[num / 100] + " hundred";
        if (num % 100 != 0) words += " and ";
    }

    num %= 100;
    if (num >= 11 && num <= 19) {
        words += teens[num - 10];
    } else {
        if (num / 10 > 0) words += tens[num / 10];
        if (num % 10 > 0) words += " " + ones[num % 10];
    }

    return words;
}

int countLetters(const std::string& text) {
    return std::count_if(text.begin(), text.end(), [](char c) {
        return std::isalpha(c);
    });
}

int main() {
    int totalLetters = 0;
    for (int i = 1; i <= 1000; ++i) {
        totalLetters += countLetters(numberToWords(i));
    }
    std::cout << totalLetters << std::endl;
    return 0;
}
