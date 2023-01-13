

/**
 Determine if an integer is a palindrome
 - Parameter x: the integer to evaluate
 - Returns `true` if `x` is a palindrome `false` otherwise
 - Complexity
    - Time: `O(n)`
    - Space: `O(1)`

    This function takes an integer x as an input, and returns a Boolean indicating whether or not x is a palindrome.
    It first creates a copy of the original input, original, and initializes a variable reversed to store the reversed version of x.
    It then enters a while loop that repeatedly divides x by 10 and adds the remainder to reversed, effectively reversing the digits of x.
    Once the loop is finished, it compares the original input x with the reversed number and return true if they are equal, otherwise false.
 */
fileprivate func isPalindrome(_ x: Int) -> Bool {
    var number = x
    var reversed = 0

    while number > 0 {
        reversed = (reversed * 10) + (number % 10)
        number /= 10
    }

    return x == reversed
}

import XCTest

final class PalindromeNumberTests: XCTestCase {
    func test() {
        XCTAssertTrue(isPalindrome(121))
        XCTAssertFalse(isPalindrome(-121))
        XCTAssertFalse(isPalindrome(10))
    }
}
