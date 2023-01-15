

/**
 * Finds the number of different arrays consist of numbers from 1 to n such that there are exactly k inverse pairs.
 * - Parameters:
 *    - n: An integer representing the range of number from 1 to n
 *    - k: An integer representing the number of inverse pairs
 * - Returns An integer representing the number of different arrays such that there are exactly k inverse pairs
 * - Complexity:
 *    - Time: `O(n*k)`
 *    - Space: `O(n*k)`
 *
 *  This function uses dynamic programming to find the number of different arrays that consists of numbers from 1 to n
 *  such that there are exactly k inverse pairs. We initialize a 2D array `dp[i][j]` where `i` is the range 1 to n and `j`
 *  is the number of inverse pairs. We use a bottom-up approach where we first initialize a base case `dp[0][0]=1` and
 *  `dp[i][0]=1`. We then use the previous values of `dp[i][j-1]` and `dp[i-1][j]` to find `dp[i][j]`. We
 *  also subtract the number of cases where `i` is less than or equal than `j` by subtracting the value of `dp[i-1][j-1]`.
 */
func kInversePairs(_ n: Int, _ k: Int) -> Int {
    // Maximum possible inverse pairs for any given i,
    // there are i-1 elements that come before it,
    // and for each of these elements, there is one
    // inverse pair that can be formed
    let maxInversions = (n * (n - 1))/2

    // Guard to check that k is within valid range
    guard k >= 0 && k <= maxInversions else { return 0 }

    // Guard to check for base cases
    guard k != 0, k != maxInversions else { return 1 }

    /*let mod = 1_000_000_007*/
    // 2D array stores the number of different arrays that can be formed
    var dp = [[Int]](repeating: [Int](repeating: 0, count: k+1), count: n+1)
    // Base case
    dp[0][0] = 1
    for i in 1...n {
        dp[i][0] = 1
        for j in 1...min(maxInversions, k) {
            dp[i][j] = (dp[i][j-1] + dp[i-1][j]) /* % mod */
            // if the current number of inverse pairs are >= current value
            // in the range of numbers 1...n
            if j >= i {
                // subtract the number of arrays that are double counted
                // as some of the previous elements that have i as the max
                // element is counted twice
                dp[i][j] = (dp[i][j] - dp[i-1][j-i]/* + mod */)/* % mod */
            }
        }
    }
    return dp[n][k]
}

import XCTest

final class KInversePairsTests: XCTestCase {
    func test() {
        XCTAssertEqual(kInversePairs(3, 0), 1)
        XCTAssertEqual(kInversePairs(3, 1), 2)
    }
}
