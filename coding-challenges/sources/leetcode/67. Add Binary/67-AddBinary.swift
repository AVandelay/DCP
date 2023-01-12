

/**
 *  This function takes in two binary strings and returns their sum as a binary string.
 *
 *  - Parameters:
 *      - a: String representation of the first binary number
 *      - b: String representation of the second binary number
 *  - Returns: String representing the sum of the binary numbers in binary format.
 *
 *  This function converts the binary strings to integers with radix 2. A radix, or base, is the number
 *  of unique digits, including zero, used to represent numbers in a positional numeral system. In the
 *  case of radix 2, or base 2, there are only two unique digits: 0 and 1. This is the numeral system used
 *  for binary numbers, which are used to represent values in digital systems.
 *
 *  e.g. The binary number 1011 represents the decimal value 11 because
 *  `1(2^3) + 0(2^2) + 1(2^1) + 1(2^0) = 8 + 0 + 2 + 1 = 11.`
 *
 */
fileprivate func addBinary(_ a: String, _ b: String) -> String {
    // Convert the input binary strings into integers with radix 2
    guard let aInt = Int(a, radix: 2),
          let bInt = Int(b, radix: 2) else {
        fatalError()
    }

    // Sum the two integers
    let sum = aInt + bInt

    // Convert the sum to binary strings with radix 2
    return String(sum, radix: 2)
}

/**
 *  This function takes in two binary strings, a and b, and returns their sum as a binary string
 *
 *  - Parameters:
 *      - a: The first binary string to be added
 *      - b: The second binary string to be added
 *  - Returns: The sum of the two binary strings as a binary string
 *  - Complexity:
 *      - Time: `O(n)` where n is the length of the input strings
 *      - Space: `O(n)` where n is the length of the input strings
 *
 *  This function works by first converting the input strings to arrays of characters and reversing them.
 *  It then iterates through the characters of the input strings, adding each character and the carry value together.
 *  The current digit of the sum is added to the result string and the carry value is updated.
 *  The function then checks if there is a remaining carry value and if so, adds it to the result string.
 *  Finally, the result string is returned.
 */
fileprivate func addBinary(a: String, b: String) -> String {
    // Initialize an empty result string and a carry value of 0
    var sum = ""
    var carry = 0

    // Create character arrays of the reversed input strings
    let aChars = Array(a.reversed())
    let bChars = Array(b.reversed())

    for i in 0..<max(aChars.count, bChars.count) {
        // Get the current character from the first string, or 0 if out of bounds
        let a = aChars.count > i ? Int(String(aChars[i])) : 0
        let b = bChars.count > i ? Int(String(bChars[i])) : 0

        guard let a, let b else { fatalError() }

        // Add the current characters and the carry value
        let total = a + b + carry
        // Add the current digit of the sum to the result string
        sum = "\(total % 2)\(sum)"
        carry = total / 2
    }

    // Check if there is a remaining carry value
    if carry == 1 {
        // If so, prepend 1 to the sum
        sum = "1\(sum)"
    }
    
    // Return the result
    return sum
}


import XCTest

final class AddBinaryTests: XCTestCase {
    func test()   {
        XCTAssertEqual(addBinary(a: "11", b: "1"), "100")
        XCTAssertEqual(addBinary(a: "1010", b: "1011"), "10101")
    }
}
