fun getProperDivisorsSum(n: Int): Int {
    var sum = 1
    for (i in 2..Math.sqrt(n.toDouble()).toInt()) {
        if (n % i == 0) {
            sum += i
            if (i != n / i) {
                sum += n / i
            }
        }
    }
    return sum
}

fun findAbundantNumbers(limit: Int): List<Int> {
    val abundantNumbers = mutableListOf<Int>()
    for (n in 12..limit) {
        if (getProperDivisorsSum(n) > n) {
            abundantNumbers.add(n)
        }
    }
    return abundantNumbers
}

fun isSumOfTwoAbundant(n: Int, abundantNumbers: List<Int>, abundantSet: Set<Int>): Boolean {
    for (a in abundantNumbers) {
        if (a >= n) break
        if ((n - a) in abundantSet) {
            return true
        }
    }
    return false
}

fun main() {
    val LIMIT = 28123
    val abundantNumbers = findAbundantNumbers(LIMIT)
    val abundantSet = abundantNumbers.toSet()

    var totalSum = 0
    for (n in 1..LIMIT) {
        if (!isSumOfTwoAbundant(n, abundantNumbers, abundantSet)) {
            totalSum += n
        }
    }

    println("The sum of all positive integers that cannot be written as the sum of two abundant numbers is: $totalSum")
}
