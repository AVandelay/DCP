

/**
 *  Generates a  Gray code for a given number of bits
 *
 *  - Parameter n: The number of bits
 *  - Returns: An array of integers representing the Gray code
 *  - Complexity: O(2^n)
 *
 *  The function uses recursion to generate the gray code with two base cases.
 *  The first base case is when n is 0, in which case the gray code is an empty array
 *  The second base case is when n is 1, in which case the gray code is `[0, 1]`
 *  Otherwise, the function generates the gray code for `n-1` and appends a bit "0" or "1"
 *  to the front of each of the codes. To generate the full gray code for n, the function combines
 *  the two resulting lists in the correct order.
 */
fileprivate func grayCode(n: Int) -> [Int] {
    guard n > 0 else { return [] }
    guard n > 1 else { return [0, 1] }

    // generate gray code of n-1 bits
    let previousGrayCode = grayCode(n: n - 1)

    // Shift bits of an integer to the left by a certain number of positions.
    // i.e. this shifts the bits of the integer 1 to the left by n-1 positions.
    // The result is an integer with its leading bit equal to 1 and the rest of
    // its bits equal to 0.
    let leadingOne: Int = 1 << (n - 1)

    // Append leading bit "0" to the previous gray code list
    let firstHalf = previousGrayCode.map { $0 }
    // Append leading bit "1" to the reversed previous gray code list
    let secondHalf = previousGrayCode.reversed().map{ leadingOne + $0 }

    return firstHalf + secondHalf
}

import XCTest

final class Day148: XCTestCase {
    func test() {
        XCTAssertEqual(grayCode(n: 0), [])
        XCTAssertEqual(grayCode(n: 1), [0, 1])
        XCTAssertEqual(grayCode(n: 2), [0,1,3,2])
        /*
         The binary representation of [0,1,3,2] is [00,01,11,10].
         - 00 and 01 differ by one bit
         - 01 and 11 differ by one bit
         - 11 and 10 differ by one bit
         - 10 and 00 differ by one bit
         [0,2,3,1] is also a valid gray code sequence, whose binary representation is [00,10,11,01].
         - 00 and 10 differ by one bit
         - 10 and 11 differ by one bit
         - 11 and 01 differ by one bit
         - 01 and 00 differ by one bit
         */
    }
}
