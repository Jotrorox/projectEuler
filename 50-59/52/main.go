package main

import (
	"fmt"
	"sort"
	"strconv"
)

func sortedDigits(n int) string {
	str := strconv.Itoa(n)
	digits := []rune(str)
	sort.Slice(digits, func(i, j int) bool {
		return digits[i] < digits[j]
	})
	return string(digits)
}

func findSmallestX() int {
	x := 1
	for {
		baseDigits := sortedDigits(x)
		allMatch := true
		for multiplier := 2; multiplier <= 6; multiplier++ {
			if sortedDigits(x*multiplier) != baseDigits {
				allMatch = false
				break
			}
		}
		if allMatch {
			return x
		}
		x++
	}
}

func main() {
	result := findSmallestX()
	fmt.Println(result)
}
