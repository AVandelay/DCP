

func missingNumber(_ arr: [Int]) -> Int {
    // Calculate the difference between successive elements in the arithmetic progression
    let difference = (arr[arr.count - 1] - arr[0]) / arr.count

    var left = 0
    var right = arr.count - 1

    // Use binary search to find the missing element in the original arithmetic progression
    while left < right {
        let mid = left + (right - left) / 2

        // If the current element in the arithmetic progression is equal to the element at the current index in the modified array, move to the right half of the array
        if arr[0] + difference * mid == arr[mid] {
            left = mid + 1
        } else {
            // Otherwise, a number is missing before `mid` inclusive of `mid` itself, so move to the left half of the array
            right = mid
        }
    }

    // The index of the left pointer will be the position with the first incorrect number
    // Return the value that was supposed to be at this index
    return arr[0] + difference * left
}

import XCTest

final class MissingNumberInArithmeticProgressionTests: XCTestCase {
    func test() {
        let testCases: [(arr: [Int], removedValue: Int)] = [
            ([5, 7, 11, 13], 9),
            ([15, 13, 12], 14)
        ]

        for (arr, removedValue) in testCases {
            XCTAssertEqual(missingNumber(arr), removedValue)
        }
    }
}
