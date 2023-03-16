

fileprivate func checkValidString(_ s: String) -> Bool {
    // Create two stacks to keep track of left parentheses and asterisks
    var leftStack = [Int]()
    var starStack = [Int]()

    // Iterate over each character in the string
    for (i, c) in s.enumerated() {
        // If the current character is a left parenthesis, push its index onto the left stack
        if c == "(" {
            leftStack.append(i)
        }
        // If the current character is an asterisk, push its index onto the star stack
        else if c == "*" {
            starStack.append(i)
        }
        // If the current character is a right parenthesis, try to match it with a left parenthesis
        else {
            // If there are no left parentheses or asterisks left, the string is invalid
            if leftStack.isEmpty {
                if starStack.isEmpty {
                    return false
                }
                // Pop the last asterisk index from the star stack to match the right parenthesis
                else {
                    starStack.removeLast()
                }
            }
            // Pop the last left parenthesis index from the left stack to match the right parenthesis
            else {
                leftStack.removeLast()
            }
        }
    }

    // Iterate over any leftover left parentheses and asterisks
    while !leftStack.isEmpty && !starStack.isEmpty {
        // If the last left parenthesis index is greater than the last asterisk index, the string is invalid
        if leftStack.last! > starStack.last! {
            return false
        }
        // Pop the last left parenthesis index and asterisk index from their respective stacks
        else {
            leftStack.removeLast()
            starStack.removeLast()
        }
    }

    // If there are any leftover left parentheses, the string is invalid
    return leftStack.isEmpty
}

import XCTest

final class ValidParenthesisStringTests: XCTestCase {
    func test() {
        XCTAssertTrue(checkValidString("()"))
        XCTAssertTrue(checkValidString("(*)"))
        XCTAssertTrue(checkValidString("(*))"))
    }
}
