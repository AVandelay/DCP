

/// Returns `true` if `string` matches `pattern`, `false` otherwise.
///
/// - Parameters:
///   - string: The string to be matched.
///   - pattern: The regular expression pattern.
///
/// - Special Characters:
///   - `.`: Matches any single character.
///   - `*`: Matches zero or more of the preceding element.
///
/// - Example:
///
///     match("ray", "ra.")  // true
///     match("raymond", "ra.")  // false
///     match("chat", ".*at")  // true
///     match("chats", ".*at")  // false
func match(_ string: String, _ pattern: String) -> Bool {
    // base case
    guard !pattern.isEmpty else { return string.isEmpty }

    // check if the current characters match, taking into account the special character `.`
    let charMatch = !string.isEmpty &&
    (string[string.startIndex] == pattern[pattern.startIndex] || pattern[pattern.startIndex] == ".")

    // pattern has at least 2 chars and second char is is the special character `*`
    guard pattern.count >= 2 && pattern[pattern.index(pattern.startIndex, offsetBy: 1)] == "*" else {
        // no `*` present, so we just check if the characters match in string after first character and pattern after second character
        return charMatch && match(
            String(string[string.index(string.startIndex, offsetBy: 1)...]),
            String(pattern[pattern.index(pattern.startIndex, offsetBy: 1)...]))
    }
    // the `*` matches zero or more occurrences of the preceding element in string after first character and pattern after second character
//    let stringAfterFirstChar = String(string[string.index(string.startIndex, offsetBy: 1)...])
//    let patternAfterSecondChar = String(pattern[pattern.index(pattern.startIndex, offsetBy: 2)...])
    return match(string, String(pattern[pattern.index(pattern.startIndex, offsetBy: 2)...])) ||
           (charMatch && match(String(string[string.index(string.startIndex, offsetBy: 1)...]), pattern))
}


import XCTest

final class Day25: XCTestCase {
    func testMatch() {
        XCTAssertTrue(match("ray", "ra."))
        XCTAssertFalse(match("raymond", "ra."))
        XCTAssertTrue(match("chat", ".*at"))
        XCTAssertFalse(match("chats", ".*at"))
    }
}
