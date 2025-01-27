package main

import (
	"fmt"
	"math/big"
)

func isPalindrome(n *big.Int) bool {
	s := n.String()
	for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
		if s[i] != s[j] {
			return false
		}
	}
	return true
}

func reverseAndAdd(n *big.Int) *big.Int {
	s := n.String()
	revStr := ""
	for i := len(s) - 1; i >= 0; i-- {
		revStr += string(s[i])
	}

	revNum, _ := new(big.Int).SetString(revStr, 10)
	return new(big.Int).Add(n, revNum)
}

func isLychrel(n int) bool {
	num := big.NewInt(int64(n))
	for i := 0; i < 50; i++ {
		num = reverseAndAdd(num)
		if isPalindrome(num) {
			return false
		}
	}
	return true
}

func main() {
	lychrelCount := 0
	for i := 1; i < 10000; i++ {
		if isLychrel(i) {
			lychrelCount++
		}
	}
	fmt.Println(lychrelCount)
}
