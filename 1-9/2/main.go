package main

func main() {
	sum := 0
	current := 1
	previous := 0
	temp := 0

	for {
		if current > 4000000 {
			break
		}

		if current%2 == 0 {
			sum += current
		}

		temp = current
		current = current + previous
		previous = temp
	}

	println("Sum of even Fibonacci numbers:", sum)
}
