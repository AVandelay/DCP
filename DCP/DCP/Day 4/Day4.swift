

fileprivate func findFirstMissingPositive(_ nums: [Int]) -> Int {
    let nums = Set(nums)

    var i = 1
    while nums.contains(i) {
        i += 1
    }

    return i
}

import XCTest

final class Day4: XCTestCase {

    func test() {
        XCTAssertEqual(findFirstMissingPositive([3, 4, -1, 1]), 2)
        XCTAssertEqual(findFirstMissingPositive([1, 2, 0]), 3)
    }
}
