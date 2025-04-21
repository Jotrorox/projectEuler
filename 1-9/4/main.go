package main

import (
	"fmt"
	"strconv"
)

func isPalindrome(number int) bool {
	s := strconv.Itoa(number)
	left, right := 0, len(s)-1
	for left < right {
		if s[left] != s[right] {
			return false
		}
		left++
		right--
	}
	return true
}

func main() {
	currentMax := 0

	for i := 100; i < 1000; i++ {
		for j := 100; j < 1000; j++ {
			product := i * j
			if product > currentMax && isPalindrome(product) {
				currentMax = product
			}
		}
	}

	fmt.Println(currentMax)
}
