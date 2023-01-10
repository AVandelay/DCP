

/**
  * Given two distinct integer arrays nums1 and nums2, where nums1 is a subset of nums2,
  * the function finds the next greater element of nums2[j] in nums2 for each 0 <= i < nums1.length,
  * such that nums1[i] == nums2[j]. If there is no next greater element, then the answer for this query is -1.
  *
  * The function uses a stack data structure to keep track of elements that have not yet been paired with a next greater element.
  * It also uses a dictionary to store the next greater element for each element in nums2.
  * For each element in nums2, it checks if the current element is greater than the top element on the stack. If so,
  * the top element is paired with the current element and popped from the stack. After iterating through all elements
  * in nums2, all remaining elements in the stack will not have a next greater element and the dictionary will be updated
  * with -1 for these elements. Then it maps all elements from nums1 to the dictionary and returns the mapped elements.
  *
  *  - Parameters:
  *    - nums1: an array of integers
  *    - nums2: an array of integers, where nums1 is a subset of nums2
  *  - Returns: an array of integers where ans[i] is the next greater element as described above
*/
fileprivate func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    // Initialize a stack and map
    var elementStack = [Int]()
    var nextGreaterMap = [Int: Int]()

    // Iterate through the elements in nums2
    for element in nums2 {
        // Pop the elements that are smaller than the current element
        while !elementStack.isEmpty && elementStack.last! < element {
            let smallerElement = elementStack.popLast()!
            nextGreaterMap[smallerElement] = element
        }

        // Push the element in the stack
        elementStack.append(element)
    }

    // Set the next greater element of the remaining elements to -1
    for element in elementStack {
        nextGreaterMap[element] = -1
    }

    // Find the next greater element for each element in nums1
    return nums1.map { element in
        nextGreaterMap[element] ?? -1
    }
}

import XCTest

final class NextGreaterElementITests: XCTestCase {
    func test() {
        XCTAssertEqual(nextGreaterElement([4, 1, 2], [1, 3, 4, 2]), [-1, 3, -1])
        XCTAssertEqual(nextGreaterElement([2, 4], [1, 2, 3, 4]), [3, -1])
    }
}
