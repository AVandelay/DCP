

/**
 *  Counts the number of different non-empty palindromic subsequences in a given string
 *
 *  - Parameter s: The input string
 *  - Returns Int: The number of different non-empty palindromic subsequences in the input string
 *  - Complexity
 *      - Time: `O(n^2)` where n is the length of the input string
 *      - Space: `O(n^2)`
 *
 *  The function uses dynamic programming to count the number of different non-empty palindromic subsequences in the input string
 */
func countPalindromicSubsequences(_ s: String) -> Int {
    let mod = 1_000_000_007
    let n = s.count
    let chars = Array(s)

    // 2D array to store the number of different non-empty palindromic subsequences
    var dp = [[Int]].init(repeating: [Int].init(repeating: 0, count: n), count: n)

    for i in 0..<n {
        dp[i][i] = 1 // Each single character is a palindrome, so set the diagonal elements to 1
    }

    for length in 2...n {
        for startIndex in 0...n-length {
            let endIndex = startIndex + length - 1
            if chars[startIndex] == chars[endIndex] {
                var leftPalindromeStart = startIndex + 1
                var rightPalindromeEnd = endIndex - 1
                dp[startIndex][endIndex] = 2 * dp[startIndex+1][endIndex-1] // count all palindromes without the two ends
                // delete non palindromic characters on both ends
                while leftPalindromeStart <= rightPalindromeEnd && chars[leftPalindromeStart] != chars[startIndex] {
                    leftPalindromeStart += 1
                }
                while leftPalindromeStart <= rightPalindromeEnd && chars[rightPalindromeEnd] != chars[startIndex] {
                    rightPalindromeEnd -= 1
                }
                if leftPalindromeStart < rightPalindromeEnd {
                    dp[startIndex][endIndex] -= dp[leftPalindromeStart+1][rightPalindromeEnd-1]
                } else if leftPalindromeStart == rightPalindromeEnd {
                    dp[startIndex][endIndex] += 1 // a...a...a, add aa
                } else {
                    dp[startIndex][endIndex] += 2 // a...a, add a, aa
                }
            } else {
                dp[startIndex][endIndex] = dp[startIndex+1][endIndex] + dp[startIndex][endIndex-1] - dp[startIndex+1][endIndex-1]
            }
            dp[startIndex][endIndex] = dp[startIndex][endIndex] < 0 ? dp[startIndex][endIndex] + mod : dp[startIndex][endIndex] % mod
        }
    }
    return dp[0][n-1]
}

import XCTest

final class CountDifferentPalindromicSubsequencesTests: XCTestCase {
    func tests() {
        XCTAssertEqual(countPalindromicSubsequences("bccb"), 6)
        XCTAssertEqual(countPalindromicSubsequences("abcdabcdabcdabcdabcdabcdabcdabcddcbadcbadcbadcbadcbadcbadcbadcba"), 104860361)
    }
}
