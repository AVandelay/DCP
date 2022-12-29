
func maxSubarray(_ nums: [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }
    guard nums.count > 1 else { return nums.first! }

    var currentMax = nums.first!
    var globalMax = currentMax
    for num in nums[1...] {
        currentMax = max(num, currentMax + num)
        globalMax = max(globalMax, currentMax)
    }
    return globalMax
}

import XCTest

final class MaximumSubarrayTests: XCTestCase {
    func test() {
        XCTAssertEqual(maxSubarray([-2,1,-3,4,-1,2,1,-5,4]), 6)
        XCTAssertEqual(maxSubarray([1]), 1)
        XCTAssertEqual(maxSubarray([5,4,-1,7,8]), 23)
    }
}
