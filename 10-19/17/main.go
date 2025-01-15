package main

import (
	"fmt"
	"strings"
)

func numberToWords(num int) string {
	ones := []string{"", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}
	teens := []string{"", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"}
	tens := []string{"", "ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"}

	if num == 1000 {
		return "one thousand"
	}

	words := ""

	if num/100 > 0 {
		words += ones[num/100] + " hundred"
		if num%100 != 0 {
			words += " and "
		}
	}

	num %= 100
	if num >= 11 && num <= 19 {
		words += teens[num-10]
	} else {
		if num/10 > 0 {
			words += tens[num/10]
		}
		if num%10 > 0 {
			words += " " + ones[num%10]
		}
	}

	return strings.TrimSpace(words)
}

func countLetters(text string) int {
	count := 0
	for _, char := range text {
		if char >= 'a' && char <= 'z' {
			count++
		}
	}
	return count
}

func main() {
	totalLetters := 0
	for i := 1; i <= 1000; i++ {
		totalLetters += countLetters(numberToWords(i))
	}
	fmt.Println(totalLetters)
}
