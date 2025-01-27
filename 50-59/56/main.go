package main

import (
	"fmt"
	"math/big"
)

func digitSum(n *big.Int) int {
	sum := 0
	str := n.String()
	for _, digit := range str {
		sum += int(digit - '0')
	}
	return sum
}

func main() {
	maxSum := 0
	for a := 1; a < 100; a++ {
		for b := 1; b < 100; b++ {
			bigA := big.NewInt(int64(a))
			bigPow := new(big.Int).Exp(bigA, big.NewInt(int64(b)), nil)

			sum := digitSum(bigPow)

			if sum > maxSum {
				maxSum = sum
			}
		}
	}
	fmt.Println("Maximum digital sum:", maxSum)
}
