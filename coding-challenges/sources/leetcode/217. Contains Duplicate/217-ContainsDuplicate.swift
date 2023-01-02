

fileprivate func containsDuplicate(_ nums: [Int]) -> Bool {
    nums.count != Set(nums).count
}

import XCTest

final class ContainsDuplicates: XCTestCase {
    func test() {
        XCTAssertTrue(containsDuplicate([1,2,3,1]))
        XCTAssertFalse(containsDuplicate([1,2,3,4]))
        XCTAssertTrue(containsDuplicate([1,1,1,3,3,4,3,2,4,2]))
    }
}
