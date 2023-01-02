

fileprivate func threeSum(_ nums: [Int]) -> [[Int]] {
    // Return an empty array if the input array has fewer than 3 elements
    guard nums.count > 2 else { return  [] }

    // Sort the array in ascending order
    let sortedNums = nums.sorted()

    // Initialize the triplets array and tripletSet set
    var triplets = [[Int]]()
    var tripletSet = Set<[Int]>()

    // Iterate through the sorted array, using each number as the first element
    for i in 0..<(sortedNums.count - 2) {
        // Initialize the left and right pointers to the start and end of the remaining array
        var left = i + 1
        var right = sortedNums.count - 1

        // While left has less than right, find the other two elements of the triplet
        while left < right {
            // Calculate the sum of the current number and the numbers at left and right
            let currentSum = sortedNums[i] + sortedNums[left] + sortedNums[right]

            // If the sum is 0, then we have found a triplet
            switch true {
            case 0 ~= currentSum:
                // Add the triplet to the triplets array only if it is not already present in tripletSet
                let triplet = [sortedNums[i], sortedNums[left], sortedNums[right]]
                if !tripletSet.contains(triplet) {
                    triplets.append(triplet)
                    tripletSet.insert(triplet)
                }

                // Increment the left to move on to the next number
                left += 1
            case currentSum < 0:
                // If the sum is less than 0, then we need to find a pair of numbers that add up to a larger sum.
                // To do this, increment left
                left += 1
            case currentSum > 0:
                // If the sum is greater than 0, then we need to find a pair of numbers that adds up to a smaller sum.
                // To do this, decrement right
                right -= 1
            default:
                fatalError()
            }
        }
    }

    return triplets
}

import XCTest

final class ThreeSumTests: XCTestCase {
    func test() {
        XCTAssertEqual(threeSum([-1,0,1,2,-1,-4]), [[-1,-1,2],[-1,0,1]])
        XCTAssertEqual(threeSum([0,1,1]), [])
    }
}
