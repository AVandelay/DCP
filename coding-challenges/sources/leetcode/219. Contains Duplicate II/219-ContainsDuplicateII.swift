

fileprivate func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
    // create an empty set
    var seen = Set<Int>()

    // iterate over the elements of the array
    for (i, num) in nums.enumerated() {
        // if the element exists in the set
        if seen.contains(num) {
            return true
        }

        // add the element to the set
        seen.insert(num)

        // if the size of the set exceeds k, remove the oldenst element
        if i >= k {
            seen.remove(nums[i - k])
        }
    }

    // no such elements were found
    return false
}

import XCTest

final class ContainsDuplicateIITests: XCTestCase {
    func test() {
        XCTAssertTrue(containsNearbyDuplicate([1,2,3,1], 3))
        XCTAssertTrue(containsNearbyDuplicate([1,0,1,1], 1))
        XCTAssertFalse(containsNearbyDuplicate([1,2,3,1,2,3], 2))
    }
}
