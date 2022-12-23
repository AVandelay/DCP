

fileprivate func twoSum_linear(_ nums: [Int], k: Int) -> Bool {
    var seen = Set<Int>()
    for num in nums {
        if seen.contains(k - num) {
            return true
        }

        seen.insert(num)
    }

    return false
}

fileprivate func twoSum_binarySearch(_ nums: [Int], k: Int) -> Bool {
    let sorted = nums.sorted()
    var left = 0
    var right = sorted.count - 1
    while left < right {
        let sum = sorted[left] + sorted[right]
        if sum < k {
            left += 1
        } else if sum > k {
            right -= 1
        } else {
            return true
        }
    }
    return false
}

import XCTest

final class Day1: XCTestCase {

    func test() {
        XCTAssertTrue(twoSum_linear([10, 15, 3, 7], k: 17))
        XCTAssertTrue(twoSum_binarySearch([10, 15, 3, 7], k: 17))
    }
}
