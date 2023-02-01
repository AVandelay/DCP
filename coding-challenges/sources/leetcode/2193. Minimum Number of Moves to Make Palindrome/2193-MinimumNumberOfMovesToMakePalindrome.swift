

func minimumMovesToFormPalindrome(_ s: String) -> Int {
    guard !s.isEmpty else { return 0 }

    var chars = Array(s)
    var leftPointer = 0
    var rightPointer = s.count - 1
    var moves = 0

    // Traverse the string while incrementing the left pointer and decrementing the right pointer
    while leftPointer < rightPointer {
        let right = rightPointer
        if chars[leftPointer] == chars[right] {
            leftPointer += 1
            rightPointer -= 1
            continue
        }

        // Move the right pointer until characters match
        var rightIndex = right
        while chars[leftPointer] != chars[rightIndex] {
            rightIndex -= 1
        }

        // If left pointer and right index meet, swap the left pointer with the next index
        if leftPointer == rightIndex {
            chars.swapAt(leftPointer, leftPointer + 1)
            moves += 1
        } else {
            // Swap all characters from the right index to the right pointer
            for i in rightIndex..<rightPointer {
                chars.swapAt(i, i + 1)
                moves += 1
            }
        }
    }

    return moves
}

import XCTest

final class MinimumNumberOfMovesToMakePalindromeTests: XCTestCase {
    func test() {
        XCTAssertEqual(minimumMovesToFormPalindrome("aabb"), 2)
        XCTAssertEqual(minimumMovesToFormPalindrome("letelt"), 2)
    }
}
