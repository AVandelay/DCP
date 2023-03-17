

fileprivate func maximumScore(_ nums: [Int], _ multipliers: [Int]) -> Int {
    // Initialize a memoization table with dimensions nums.count x multipliers.count
    var memo: [[Int?]] = Array(repeating: Array(repeating: nil, count: multipliers.count), count: nums.count)

    // Helper function for the dynamic programming approach
    func helper(_ left: Int, _ right: Int, _ index: Int) -> Int {
        // Base case: if we've used all multipliers, return 0
        guard index < multipliers.count else { return 0 }

        // If the memo table contains a result for this subproblem, return the result
        if let cachedResult = memo[left][index] {
            return cachedResult
        }

        // Choose the left element, multiply it with the current multiplier, and recurse
        let chooseLeft = nums[left] * multipliers[index] + helper(left + 1, right, index + 1)
        // Choose the right element, multiply it with the current multiplier, and recurse
        let chooseRight = nums[right] * multipliers[index] + helper(left, right - 1, index + 1)

        // Store the maximum score between choosing left and right in the memo table
        memo[left][index] = max(chooseLeft, chooseRight)
        // Return the maximum score for this subproblem
        return memo[left][index]!
    }

    // Call the helper function with the initial values for left, right, and index
    return helper(0, nums.count - 1, 0)
}

import XCTest

final class MaximumScoreFromPerformingMultiplicationOperationsTests: XCTestCase {
    func test() {
        XCTAssertEqual(maximumScore([1,2,3], [3,2,1]), 14)
        XCTAssertEqual(maximumScore([-5,-3,-3,-2,7,1], [-10,-5,3,4,6]), 102)
    }
}
