

/**
 One approach to compute the approximate median of a list of numbers is to use the QuickSelect algorithm. QuickSelect is a variation of the QuickSort algorithm that aims to find the kth smallest element in an unsorted list in O(n) time complexity, on average. To find the median, we use the QuickSelect algorithm to find the element at rank N/2.
 */

/// Returns the approximate median of an unordered list of numbers.
///
/// More precisely, finds an element whose rank is between `N / 4` and `3 * N / 4`, with a high level of certainty, in less than `O(N)` time.
///
/// - Parameter list: The list of numbers.
///
/// - Returns: The approximate median of the list.
fileprivate func approximateMedian(_ list: [Int]) -> Int? {
    guard !list.isEmpty else { return nil }

    return quickSelect(list: list, left: 0, right: list.count - 1, k: list.count / 2)
}

/// Finds the kth smallest element in an unsorted list using the QuickSelect algorithm.
///
/// - Parameters:
///   - list: The list of numbers.
///   - left: The left index of the list.
///   - right: The right index of the list.
///   - k: The rank of the element to find.
///
/// - Returns: The kth smallest element in the list.
private func quickSelect(list: [Int], left: Int, right: Int, k: Int) -> Int {
    var list = list

    if left == right {
        return list[left]
    }

    // Select a pivot at random
    let pivotIndex = Int.random(in: left...right)
    let pivotValue = list[pivotIndex]

    // Move pivot to the end
    list.swapAt(pivotIndex, right)

    // Partition the list around the pivot
    var storeIndex = left
    for i in left..<right {
        if list[i] < pivotValue {
            list.swapAt(i, storeIndex)
            storeIndex += 1
        }
    }

    // Move pivot to its final place
    list.swapAt(storeIndex, right)

    // Check the rank of the pivot
    if k == storeIndex {
        return list[k]
    } else if k < storeIndex {
        return quickSelect(list: list, left: left, right: storeIndex - 1, k: k)
    } else {
        return quickSelect(list: list, left: storeIndex + 1, right: right, k: k)
    }
}

import XCTest

final class Day323: XCTestCase {
    func testApproximateMedian() {
        let testCases: [(list: [Int], expectedMedian: Int)] = [
            ([1, 2, 3, 4, 5, 6, 7], 4),
            ([5, 4, 3, 2, 1], 3),
            ([1, 2, 3, 4, 5, 6], 4),
            ([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 6),
            ([1, 1, 1, 1, 1, 1, 1], 1),
            ([1, 2, 3, 3, 3, 3, 3, 3, 3, 10], 3),
            ([1, 2, 3, 4, 5, 6, 7, 8, 9], 5),
        ]
        for (list, expectedMedian) in testCases {
            XCTAssertEqual(approximateMedian(list), expectedMedian)
        }
    }
}
