fun main() {
    var sum = 0
    var current = 1
    var previous = 0

    while (current <= 4000000) {
        if (current % 2 == 0) {
            sum += current
        }

        val temp = current
        current += previous
        previous = temp
    }

    println("Sum of even Fibonacci numbers: $sum")
}
