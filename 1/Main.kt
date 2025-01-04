fun main() {
    val sum = (0..999).filter { it % 3 == 0 || it % 5 == 0 }.sum()
    println(sum)
}