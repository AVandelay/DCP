

/**
 The kmpMatch function takes a string and a pattern as input and returns the starting index of the pattern in the string if it is found, or nil otherwise.

 The algorithm works as follows:

    1. First, the failure table is computed using the pattern. The `failure` array is initialized with a single zero, and a variable `j` is used to keep track of the length of the longest proper suffix of the pattern that is also a prefix of the pattern. The `failure` array is computed iteratively, updating `j` as necessary, until the end of the pattern is reached.

    2. Next, the string is searched for the pattern. A variable `j` is used to keep track of how much of the pattern has been matched so far. For each character `c` in the string, the algorithm checks whether `c` matches the next character in the pattern. If so, j is incremented. If not, j is updated using the failure table until a match is found or the end of the string is reached.

 The worst-case time complexity of the KMP algorithm is `O(N + k)`, which is much faster than `O(N * k)` for long patterns.

 The failure table in the algorithm, stores the length of the longest proper prefix of the pattern that is also a proper suffix. This table will help us skip over unnecessary comparisons when searching for the pattern in the string.

 For example, consider the pattern `ABCDABD`. The failure table for this pattern would be:

```
 Pattern:     A B C D A B D
 Failure:    [0 0 0 0 1 2 0]
 ```
 This table tells us that the longest proper prefix of the pattern that is also a proper suffix of the first character is 0, the second character is 0, the third character is 0, the fourth character is 0, the fifth character is 1 (the proper prefix is `A` and the proper suffix is `A`), the sixth character is 2 (the proper prefix is `AB` and the proper suffix is `AB`), and the seventh character is 0.

 To find the pattern in the string, we iterate over both the pattern and the string using two indices, `i` and `j`. If the characters match, we move on to the next characters in both the pattern and the string. If the characters do not match, but we have seen some matching characters

 This is the brute force approach
 ```
 func stringMatch(_ string: String, _ pattern: String) -> Int? {
     let n = string.count
     let m = pattern.count

     if m > n {
         return nil
     }

     for i in 0...(n-m) {
         var j = 0
         while j < m && pattern[pattern.index(pattern.startIndex, offsetBy: j)] == string[string.index(string.startIndex, offsetBy: i+j)] {
             j += 1
         }
         if j == m {
             return i
         }
     }

     return nil
 }
 ```
 */
fileprivate func findPattern(_ string: String, _ pattern: String) -> Int? {
    guard !pattern.isEmpty else { return nil }
    
    let n = string.count
    let m = pattern.count

    // Create a failure table to store the longest proper prefix of the pattern that is also a proper suffix.
    var failureTable = [Int](repeating: 0, count: m)

    // Calculate the failure table.
    var j = 0
    var i = 1
    while i < m {
        let pi = pattern.index(pattern.startIndex, offsetBy: i)
        let pj = pattern.index(pattern.startIndex, offsetBy: j)
        if pattern[pi] == pattern[pj] {
            // If the characters match, set the failure table entry to the length of the matching prefix.
            j += 1
            failureTable[i] = j
            i += 1
        } else if j > 0 {
            // If the characters do not match, but we have seen some matching characters before,
            // update j to the length of the longest matching prefix.
            j = failureTable[j - 1]
        } else {
            // If the characters do not match and we have not seen any matching characters before,
            // the failure table entry is 0.
            failureTable[i] = 0
            i += 1
        }
    }

    // Use the failure table to find the pattern in the string.
    i = 0
    j = 0
    while i < n {
        let si = string.index(string.startIndex, offsetBy: i)
        let pj = pattern.index(pattern.startIndex, offsetBy: j)
        if string[si] == pattern[pj]  {
            // If the characters match, move on to the next characters in both the pattern and the string.
            i += 1
            j += 1
            if j == m {
                // If we have reached the end of the pattern, we have found a match.
                // Return the start index of the match in the string.
                return i - m
            }
        } else if j > 0 {
            // If the characters do not match, but we have seen some matching characters before,
            // update j to the length of the longest matching prefix.
            j = failureTable[j - 1]
        } else {
            // If the characters do not match and we have not seen any matching characters before,
            // move on to the next character in the string.
            i += 1
        }
    }

    // If the pattern was not found, return nil.
    return nil
}


import XCTest

final class Day276: XCTestCase {
    func testKMP() {
        let testCases: [(string: String, pattern: String, expectedIndex: Int?)] = [
            ("hello world", "world", 6),
            ("hello world", "lo wo", 3),
            ("hello world", "goodbye", nil),
            ("hello world", "l", 2),
            ("hello world", "h", 0),
            ("", "pattern", nil),
            ("pattern", "", nil),
        ]
        
        for testCase in testCases {
            let actual = findPattern(testCase.string, testCase.pattern)
            XCTAssertEqual(testCase.expectedIndex, actual)
        }
    }
}
