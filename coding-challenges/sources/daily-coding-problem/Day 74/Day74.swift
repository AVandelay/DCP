

/**
    Given integers N and X, this function returns the number of times X appears as a value in an N by N multiplication table.
    - Parameters:
        - n: An integer representing the size of the multiplication table.
        - x: An integer representing the target number to search for in the multiplication table.
    - Returns: An integer representing the number of times x appears in the table.
    - Complexity: O(n) as it iterates through all rows of the table, and for each row, it checks if x is a multiple of the current row number i, if it is not it continues to the next row.

    Improves on brute force  O(n^2) implementation

    ```
    func countXInMultiplicationTable(n: Int, x: Int) -> Int {
        var count = 0
        for i in 1...n {
            for j in 1...n {
                if i * j == x {
                    count += 1
                }
            }
        }
        return count
    }
    ```
*/
fileprivate func countXInMultiplicationTable(n: Int, x: Int) -> Int {
    var count = 0

    // Iterate through all rows
    for i in 1...n {
        // If x is not a multiple of i, skip to the next row
        guard x % i == 0 else { continue }

        // Calculate the possible `j`s. If the current row is a divisor of the target,
        // then it is possible that the result of the multiplication `i * j` is a possible
        // value that we are checking if it exists in the table
        let j = x / i

        // Check if j is within the range of the table and a whole number
        if j > 0 && j <= n {
            count += 1
        }
    }

    return count
}

import XCTest

final class Day74: XCTestCase {
    func test() {
        var n = 6
        var x = 12
        var expectation = 4
        XCTAssertEqual(countXInMultiplicationTable(n: n, x: x), expectation)

        n = 10
        x = 25
        expectation = 1
        XCTAssertEqual(countXInMultiplicationTable(n: n, x: x), expectation)

        n = 8
        x = 36
        expectation = 1
        XCTAssertEqual(countXInMultiplicationTable(n: n, x: x), expectation)
    }
}
