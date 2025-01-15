import Foundation

func factorial(_ n: Int) -> Int {
    return n == 0 ? 1 : (1...n).reduce(1, *)
}

func lexicographicPermutation(of digits: [Int], at position: Int) -> [Int]? {
    var digits = digits
    var targetPosition = position - 1
    var result: [Int] = []

    guard position > 0 && position <= factorial(digits.count) else {
        return nil
    }

    for i in stride(from: digits.count - 1, through: 0, by: -1) {
        let fact = factorial(i)
        let index = targetPosition / fact

        guard index < digits.count else { return nil }

        result.append(digits[index])
        digits.remove(at: index)
        targetPosition %= fact
    }

    return result
}

let digits = Array(0...9)
let position = 1_000_000

if let result = lexicographicPermutation(of: digits, at: position) {
    let resultString = result.map(String.init).joined()
    print("The \(position)th lexicographic permutation is \(resultString).")
} else {
    print("Invalid position.")
}
