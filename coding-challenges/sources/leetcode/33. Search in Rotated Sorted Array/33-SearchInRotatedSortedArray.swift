

fileprivate func search(_ nums: [Int], _ target: Int) -> Int {
    // If the array is empty, return -1
    guard !nums.isEmpty else { return -1 }

    var left = 0
    var right = nums.count - 1

    // Use binary search to find the target
    while left <= right {
        let mid = left + (right - left) / 2

        // if the target is found, return the index
        if nums[mid] == target {
            return mid
        }

        // Check if the left part of the array is sorted
        if nums[left] <= nums[mid] {
            // If the target is in the left part of the array,
            // move right pointer to the left
            if nums[left] <= target, target <= nums[mid] {
                right = mid - 1
            } else {
                // If the target is not in the left part of the array,
                // move the left pointer to the right
                left = mid + 1
            }
        } else {
            // Check if the right part of the array is sorted
            // If the target is in the right part of the array,
            // move the left pointer to the right
            if nums[mid] <= target, target <= nums[right] {
                left = mid + 1
            } else {
                // If the target is not in the right part of the array,
                // move right pointer to the left
                right = mid - 1
            }
        }
    }

    // If the target is not found, return -1
    return -1
}

import XCTest

final class SearchInRotatedArrayTests: XCTestCase {
    func test() {
        var nums = [4,5,6,7,0,1,2]
        var target = 0
//        XCTAssertEqual(search(nums, target), 4)
//
//        target = 3
//        XCTAssertEqual(search(nums, target), -1)

        nums = [1,3]
        target = 3
        XCTAssertEqual(search(nums, target), 1)
    }
}
