package main

import (
	"fmt"
	"math"
	"math/big"
)

func minimalSolution(D int) (*big.Int, *big.Int) {
	sqrtD := int(math.Sqrt(float64(D)))
	if sqrtD*sqrtD == D {
		return nil, nil
	}

	a0 := sqrtD

	m := 0
	dVal := 1
	a := a0

	hm2 := big.NewInt(1)
	hm1 := big.NewInt(int64(a0))
	km2 := big.NewInt(0)
	km1 := big.NewInt(1)

	x := new(big.Int)
	y := new(big.Int)
	for {
		hSquare := new(big.Int).Mul(hm1, hm1)
		kSquare := new(big.Int).Mul(km1, km1)
		Dbig := big.NewInt(int64(D))
		DkSquare := new(big.Int).Mul(Dbig, kSquare)
		leftSide := new(big.Int).Sub(hSquare, DkSquare)
		if leftSide.Cmp(big.NewInt(1)) == 0 {
			x.Set(hm1)
			y.Set(km1)
			break
		}

		m = dVal*a - m
		dVal = (D - m*m) / dVal
		a = (a0 + m) / dVal

		aBig := big.NewInt(int64(a))
		h := new(big.Int).Mul(aBig, hm1)
		h.Add(h, hm2)
		k := new(big.Int).Mul(aBig, km1)
		k.Add(k, km2)

		hm2, hm1 = hm1, h
		km2, km1 = km1, k
	}

	return x, y
}

func main() {
	maxX := big.NewInt(0)
	resultD := 0

	for D := 2; D <= 1000; D++ {
		sqrtD := int(math.Sqrt(float64(D)))
		if sqrtD*sqrtD == D {
			continue
		}

		x, _ := minimalSolution(D)
		if x == nil {
			continue
		}

		if x.Cmp(maxX) > 0 {
			maxX.Set(x)
			resultD = D
		}
	}

	fmt.Printf("%d\n", resultD)
}
