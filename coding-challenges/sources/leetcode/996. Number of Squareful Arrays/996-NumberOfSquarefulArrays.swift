

import Foundation

/**
 *  numSquarefulPerms - a function to return the number of permutations of nums that are squareful
 *
 *  - Parameter nums: an array of integers
 *  - Returns the number of permutations of nums that are squareful
 *  - Complexity
 *      - Time: `O(n!*n)` where n is the length of the input array, as it generates all possible permutations of the input array and checks each one.
 *      - Space: `O(n)` due to the recursion stack used by the permute helper function.
 *
 * The function uses a backtracking algorithm to generate all possible permutations of the sorted input array,
 * then checks if each permutation is squareful by iterating through the permutation and checking if the sum of each pair of adjacent elements is a perfect square.
 * If it is, it increments a counter variable. Finally, the function returns the counter variable as the result.
 */
fileprivate func numSquarefulPerms(_ nums: [Int]) -> Int {
    var allPaths = [[Int]]()
    var currentPath = [Int]()
    generatePermutations(nums.sorted(), &currentPath, &allPaths)
    return allPaths.count
}

/**
 *  Helper function to check if a given number is a perfect number
 *
 *  - Parameter num: an integer
 *  - Returns true if the number is a perfect square, false otherwise
 *
 */
private func isPerfectSquare(_ num: Int) -> Bool {
    let squareRoot = Int(sqrt(Double(num)))
    return squareRoot * squareRoot == num
}

/**
 *  Helper function to generate all permutations of the input array
 *
 *  - Parameters
 *      - nums: an array of integers
 *      - currentPath: a current path that is being built
 *      - allPaths: a list of all paths found so far
 *  - Complexity
 *      - Time: `O(n!*n)` where n is the length of the input array, as it generates all possible permutations of the input array and check each one.
 *      - Space: `O(n)` due to the recursion stack used by the function.
 *
 *  The function uses a backtracking algorithm to generate all possible permutations of the input array,
 *  by iterating through the elements of the array and recursively generating all possible permutations
 *  of the remaining elements. It also checks for duplicates and whether the last element and the current
 *  element of the path form a perfect square or not before going further in the recursion.
 */
private func generatePermutations(_ nums: [Int], _ currentPath: inout [Int], _ allPaths: inout [[Int]]) {
    if nums.isEmpty {
        // All permutations have been generated, add it to allPaths
        allPaths.append(currentPath)
    } else {
        for i in 0..<nums.count {
            if i > 0,
               nums[i] == nums[i - 1] {
                // skip duplicates
                continue
            }

            if !currentPath.isEmpty,
               !isPerfectSquare(currentPath.last! + nums[i]) {
                // backtracking without going further if the last element and the current element of the path do not form a perfect square
                continue
            }
            currentPath.append(nums[i])
            generatePermutations(nums.filter { $0 != nums[i] }, &currentPath, &allPaths)
            currentPath.removeLast()
        }
    }
}

import XCTest

final class NumberOfSquarefulArrays: XCTestCase {
    func test() {
        XCTAssertEqual(numSquarefulPerms([1,17,8]), 2)
        XCTAssertEqual(numSquarefulPerms([2,2,2]), 1)
    }
}
