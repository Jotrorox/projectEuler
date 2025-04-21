fun isPalindrome(number: Int): Boolean {
    val original = number
    var reversed = 0
    var temp = number
    while (temp > 0) {
        reversed = reversed * 10 + temp % 10
        temp /= 10
    }
    return original == reversed
}

fun main() {
    var currentMax = 0

    for (i in 100 until 1000) {
        for (j in 100 until 1000) {
            val product = i * j
            if (product > currentMax && isPalindrome(product)) {
                currentMax = product
            }
        }
    }

    println(currentMax)
}
