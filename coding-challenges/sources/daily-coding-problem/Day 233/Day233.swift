

/**
 *  Function that returns the nth number in the Fibonacci sequence
 *
 *  - Parameter n: positive integer that represents the position of the Fibonacci number
 *  - Returns fib: an integer representing the nth number in the Fibonacci sequence
 *  - Complexity space: O(1) time: O(n)
 *
 *  The Fibonacci sequence of numbers in which each number is the sum of the two preceding ones.
 *  The function uses a for loop to iterate `n-1` times, using `a` and `b` as the previous 2 numbers,
 *  storing the result in b and swapping the values to use for next iteration. This way the function doesn't
 *  have to store all the previous numbers in an array and uses only O(1) space. Time complexity is O(n)
 *  as it performs n-1 operations.
 *
 *  Alternatively, this can be solved using a closed form mathematical function
 *
 *  ```
 *  func fib(n: Int) -> Int {
 *      let PHI = (1 + sqrt(5)) / 2
 *      return Int((pow(PHI, Double(n)) / sqrt(5) + 0.5))
 *  }
 *  ```
 */
func fib(n: Int) -> Int {
    // Return n if smaller than 1
    guard n > 1 else { return n }

    var a = 0
    var b = 1
    for _ in 1..<n {
        /* shorthand for:
             let temp = a
             a = b
             b = temp + b
         */
        (a, b) = (b, a + b)

    }
    return b
}


import XCTest

final class Day233: XCTestCase {
    func test() {
        XCTAssertEqual(fib(n: 5), 5)
    }
}
