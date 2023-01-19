

/**
 * Removes comments from a given C++ program represented as an array of strings.
 *
 *  - Parameter source: An array of strings representing the C++ program, where source[i] is the ith line of the source code.
 *  - Returns: An array of strings representing the source code with comments removed.
 *
 * The function iterates through each line of the `source` array and checks for the presence of line and block comments.
 * If a line comment is found, the rest of the characters in that line are ignored and not added to the final result.
 * If a block comment is found, all characters until the next closing block comment are ignored and not added to the final result.
 * If a line is empty after removing comments, it is not added to the final result.
 *
 *  - Complexity:
 *      - Time Complexity: O(n) where n is the total number of characters in the source code.
 *      - Space Complexity: O(n) where n is the total number of characters in the source code.
 */

func removeComments(_ source: [String]) -> [String] {
    var cleanedSource = [String]()
    var cleanedLine = ""
    var inBlock = false

    for line in source {
        var i = 0
        while i < line.count {
            let char = line[line.index(line.startIndex, offsetBy: i)]
            let nextChar = i+1 < line.count ? line[line.index(line.startIndex, offsetBy: i+1)] : nil

            switch(char, nextChar) {
            case("/", "/"):
                // Advance the pointer to the end of the current line
                i = line.count - 1
            case("/", "*"):
                inBlock = true
                i += 1
            case("*", "/"):
                if inBlock {
                    inBlock = false
                    i += 1
                }
            default:
                if !inBlock {
                    cleanedLine.append(char)
                }
            }

            i += 1
        }

        if cleanedLine != "" && !inBlock {
            cleanedSource.append(cleanedLine)
            cleanedLine = ""
        }
    }

    return cleanedSource
}

import XCTest

final class RemoveCommentsTests: XCTestCase {
    func test() {
        var source = ["/*Test program */", "int main()", "{ ", "  // variable declaration ", "int a, b, c;", "/* This is a test", "   multiline  ", "   comment for ", "   testing */", "a = b + c;", "}"]
        var expectation = ["int main()","{ ","  ","int a, b, c;","a = b + c;","}"]
        XCTAssertEqual(removeComments(source), expectation)

        source = ["a/*comment", "line", "more_comment*/b"]
        expectation = ["ab"]
        XCTAssertEqual(removeComments(source), expectation)
    }
}
