package main

import (
	"fmt"
	"math"
)

func contains(nums []int, target int) bool {
	for _, num := range nums {
		if num == target {
			return true
		}
	}
	return false
}

func isPentagonal(x int) bool {
	n := (math.Sqrt(24*float64(x)+1) + 1) / 6
	return n == float64(int(n))
}

func check(nums []int) bool {
	for i := 0; i < len(nums); i++ {
		for j := i + 1; j < len(nums); j++ {
			sum := nums[i] + nums[j]
			diff := int(math.Abs(float64(nums[i] - nums[j])))
			if isPentagonal(sum) && isPentagonal(diff) {
				fmt.Printf("Pj: %d, Pk: %d, D: %d\n", nums[i], nums[j], diff)
				return true
			}
		}
	}
	return false
}

func main() {
	numbers := []int{1}

	for !check(numbers) {
		n := len(numbers) + 1
		pentagonal := (n * (3*n - 1)) / 2
		numbers = append(numbers, pentagonal)
	}
}
