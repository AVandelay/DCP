

/**
 *  Given an integer array `height`, this function finds two lines that together with the x-axis form a container such that, the container contains the most water
 *  Returns the maximum amount of water a container can store.
 *
 *  The function uses two pointers, one at the beginning of the array and one at the end. The pointers are used to select the two lines and find the container.
 *  The function uses a while loop that runs while left pointer is less than right pointer. In each iteration, it finds the area of the container formed by the  two lines
 *  at the positions of the pointes and updates the `maxArea`variable if the current area is greater than the previous max.
 *
 *  Because we move one pointer at a time and only move the pointer that points to the shorter line, the two pointers eventually meet in the middle thus checking all possible containers.
 *
 * - Parameter height: The array of heights of the lines
 *
 * - Returns: The maximum amount of water that can be stored in a container
 *
 * - Complexity:
 *      Time: O(n)
 *      Space: O(1)
 */
func maxArea(_ height: [Int]) -> Int {
    var maxArea = 0 // keeps track of the maximum area

    var left = 0 // pointer to the left line
    var right = height.count - 1 // pointer to the right line

    // Loop while left pointer is less than right pointer
    while left < right {
        let width = right - left // width of the container
        let shorter = min(height[left], height[right]) // height of the container is determined by the shorter line
        // calculate the area of the container
        maxArea = max(maxArea, shorter * width)

        // check which bar is shorter
        if height[left] <= height[right] {
            // move left pointer to the right
            left  += 1
        } else {
            // move right pointer to the left
            right -= 1
        }
    }

    return maxArea
}

import XCTest

final class ContainerWithMostWaterTests: XCTestCase {
    func test() {
        XCTAssertEqual(maxArea([1,8,6,2,5,4,8,3,7]), 49)
    }
}
