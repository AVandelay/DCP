

/**
 * Converts a Roman numeral string to an integer.
 *
 * - Parameters:
 *     - s: The Roman numeral string to convert.
 *
 * - Returns:
 *     The integer value of the Roman numeral string.
 *
 * - Complexity:
 *    Time: O(n), where n is the length of the input string.
 *    Space: O(1), constant space is used for the dictionary and variables.
 */
fileprivate func romanToInt(_ s: String) -> Int {
    // Create a dictionary to map Roman numerals to their corresponding integer values.
    let numerals = [
        "I": 1,
        "V": 5,
        "X": 10,
        "L": 50,
        "C": 100,
        "D": 500,
        "M": 1000
    ]

    // Initialize a variable to store the final result and a variable to keep track of the previous numeral.
    var total = 0
    var prev = 0
    // Iterate through the characters in the input string in reverse order.
    for char in s.reversed() {
        // Get the integer value of the current numeral from the dictionary.
        let num = numerals[String(char)]!
        // Check if the current numeral is less than the previous numeral.
        // Handles cases like IV
        if num < prev {
            // If so, subtract the current numeral from the result.
            total -= num
        } else {
            // If not, add the current numeral to the result.
            total += num
        }
        // Update the previous numeral variable to the current numeral.
        prev = num
    }

    // Return the computed total
    return total
}

import XCTest

final class RomanToIntegerTests: XCTestCase {
    func test() {
        var roman = "III"
        var expectation = 3
        XCTAssertEqual(romanToInt(roman), expectation)

        roman = "LVIII"
        expectation = 58
        XCTAssertEqual(romanToInt(roman), expectation)

        roman = "MCMXCIV"
        expectation = 1994
        XCTAssertEqual(romanToInt(roman), expectation)
    }
}
