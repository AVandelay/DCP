

/**
 * Determines whether the given string containing brackets is valid.
 *
 * - Parameter bracketString: A string containing only the characters '(', ')', '{', '}', '[' and ']'.
 *
 * - Returns: A boolean indicating whether the string is valid.
 *
 * This function iterates over the input string, character by character and checks if the character
 * is an open bracket or closing bracket. If the current character is an open bracket, the function
 * pushes it to the stack, if it's closing bracket the function checks whether the last open bracket
 * in the stack matches the current closing bracket, If not, it returns `false` immediately.
 * If all brackets are matched, the stack should be empty and the function returns `true`, otherwise
 * it returns `false`.
 *
 * Time Complexity: O(n) where n is the length of the input string.
 * Space Complexity: O(n) where n is the length of the input string.
 */
fileprivate func isBalanced(bracketString: String) -> Bool {
    // Dictionary that maps closing brackets to opening brackets
    let brackets: [Character: Character] = [")": "(", "]": "[", "}": "{"]
    // Stack that holds the open bracket
    var stack = [Character]()
    // Iterate the input string
    for char in bracketString {
        // If the current character is a closing bracket
        if let openBracket = brackets[char] {
            // Check if the last open bracket matches the current closing bracket
            if let last = stack.popLast(),
               last != openBracket {
                return false
            }
        } else if brackets.values.contains(char) {
            // If the current character is an open bracket, push it to the stack
            stack.append(char)
        }
    }

    // If the stack is empty, that means all brackets are matched
    return stack.isEmpty
}

import XCTest

final class Day27: XCTestCase {
    func test() {
        XCTAssertTrue(isBalanced(bracketString: "([])[]({})"))
        XCTAssertFalse(isBalanced(bracketString: "([)]"))
        XCTAssertFalse(isBalanced(bracketString: "((()"))
    }
}
