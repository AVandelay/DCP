

fileprivate func isValid(_ s: String) -> Bool {
    let brackets: [Character: Character] = [")": "(", "]": "[", "}": "{"]
    var stack = [Character]()
    for c in s {
        if brackets.values.contains(String(c)) {
            stack.append(c)
        } else if let openBracket = brackets[c] {
            if let last = stack.last,
               last != openBracket {
                return false
            }
            stack.removeLast()
        }
    }
    return stack.isEmpty
}

import XCTest

final class ValidParenthesesTests: XCTestCase {
    func test() {
        XCTAssertTrue(isValid("()"))
        XCTAssertTrue(isValid("()[]{}"))
        XCTAssertFalse(isValid("(]"))
    }
}
