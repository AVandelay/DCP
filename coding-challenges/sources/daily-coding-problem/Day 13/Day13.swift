

fileprivate func longestSubstring(s: String, k: Int) -> Int {
    // Create a dictionary to store the number of occurrences of each character in the substring
    var counts = [Character: Int]()
    // Initialize the maximum length of the substring to 0
    var maxLength = 0
    // Initialize the left and right pointers to the start of the string
    var left = s.startIndex
    var right = s.startIndex
    // Iterate over the characters of the string
    while right < s.endIndex {
        // Increment the count of the current character in the counts dictionary
        counts[s[right], default: 0] += 1
        // While the number of distinct characters in the substring is greater than k, move the left pointer to the right
        while counts.count > k {
            counts[s[left], default: 0] -= 1
            if counts[s[left], default: 0] == 0 {
                counts.removeValue(forKey: s[left])
            }
            left = s.index(after: left)
        }
        // Update the maximum length of the substring if necessary
        maxLength = max(maxLength, s.distance(from: left, to: right) + 1)
        // Move the right pointer to the right
        right = s.index(after: right)
    }
    // Return the maximum length of the substring
    return maxLength
}

import XCTest

final class Day13: XCTestCase {
    func test() {
        XCTAssertEqual(longestSubstring(s: "abcba", k: 2), 3)
        XCTAssertEqual(reduceLongestSubstring(s: "abcba", k: 2), 3)
    }
}

fileprivate func reduceLongestSubstring(s: String, k: Int) -> Int {
    // Initialize the left and right pointers to the start of the string
    let left = s.startIndex
    let right = s.startIndex
    // Iterate over the characters of the string using the reduce function
    let result = s.reduce((left: left, right: right, counts: [Character: Int](), maxLength: 0)) { (result, character) -> (left: String.Index, right: String.Index, counts: [Character: Int], maxLength: Int) in
        // Increment the count of the current character in the counts dictionary
        var counts = result.counts
        counts[character, default: 0] += 1
        // While the number of distinct characters in the substring is greater than k, move the left pointer to the right
        var left = result.left
        while counts.count > k {
            counts[s[left], default: 0] -= 1
            if counts[s[left], default: 0] == 0 {
                counts.removeValue(forKey: s[left])
            }
            left = s.index(after: left)
        }
        // Update the maximum length of the substring if necessary
        let maxLength = max(result.maxLength, s.distance(from: left, to: result.right) + 1)
        // Return the updated result
        return (left: left, right: s.index(after: result.right), counts: counts, maxLength: maxLength)
    }
    // Return the maximum length of the substring
    return result.maxLength
}
