

fileprivate func maxOfSubarrays(arr: [Int], k: Int) {
    // Initialize deque to store the indices of the elements in the window
    var dq = [Int]()

    for (i, element) in arr.enumerated() {
        // Remove elements from the deque that are outside the current window
        while !dq.isEmpty && dq.first! <= i - k {
            dq.removeFirst()
        }
        // Remove elements from the deque that are smaller than the current element
        while !dq.isEmpty && element >= arr[dq.last!] {
            dq.removeLast()
        }
        // Add the current element to the deque
        dq.append(i)

        // If we have processed at least k elements, print the maximum element in the window
        if i >= k - 1 {
            print(arr[dq.first!], terminator: " ")
        }
    }
    print()
}

import XCTest

class MaxOfSubarraysTests: XCTestCase {
    func testMaxOfSubarrays() {
        let arr1 = [10, 5, 2, 7, 8, 7]
        let k1 = 3
        // expected output: 10 7 8 8
        maxOfSubarrays(arr: arr1, k: k1)

        let arr2 = [1, 2, 3, 4, 5, 6]
        let k2 = 4
        // expected output: 4 5 6
        maxOfSubarrays(arr: arr2, k: k2)

        let arr3 = [6, 5, 4, 3, 2, 1]
        let k3 = 2
        // expected output: 6 5 4 3 2
        maxOfSubarrays(arr: arr3, k: k3)

        let arr4 = [1]
        let k4 = 1
        // expected output: 1
        maxOfSubarrays(arr: arr4, k: k4)

        let arr5 = [1, 2, 3, 4, 5, 6]
        let k5 = 6
        // expected output: 6
        maxOfSubarrays(arr: arr5, k: k5)
    }
}
