

/**
 *  Finds a fixed point in a sorted array of distinct elements
 *
 *  - Parameter nums: a sorted array of distinct integers
 *  - Returns:
 *      - An integer representing the fixed point if it exits or `nil` if no fixed point is found
 *  - Complexity:
 *      - Time: `O(log n)`
 *      - Space: `O(1)`
 *
 *  The function uses a binary search algorithm to find the fixed point. It starts with the middle element
 *  of the array and compares it with its index. If it's the same, it returns the middle element as the fixed
 *  point. If the middle element is less than its index, that means the fixed point should be on the right side
 *  of the array so the function will process the right side of the array. Else if the middle element is greater than
 *  it index, the fixed point should be on the left side of the array, so the function will process the left side of the
 *  array. The function will stop when a fixed point is found or when the searchable size becomes 0.
 */
fileprivate func fixedPoint(in nums: [Int]) -> Int? {
    var left =  0
    var right = nums.count - 1
    while left <= right {
        let middle = (left + right) / 2
        switch true {
        case middle < nums[middle]:
            right = middle - 1
        case middle == nums[middle]:
            return middle
        case middle > nums[middle]:
            left = middle + 1
        default:
            fatalError()
        }
    }

    return nil
}

import XCTest

final class Day273: XCTestCase {
    func test() {
        XCTAssertNil(fixedPoint(in: [1, 5, 7, 8]))
        XCTAssertEqual(fixedPoint(in: [0, 2, 3, 40]), 0)
        XCTAssertEqual(fixedPoint(in: [-6, 0, 2, 40]), 2)
        XCTAssertEqual(fixedPoint(in: [-6, 0, 1, 3]), 3)
    }
}
