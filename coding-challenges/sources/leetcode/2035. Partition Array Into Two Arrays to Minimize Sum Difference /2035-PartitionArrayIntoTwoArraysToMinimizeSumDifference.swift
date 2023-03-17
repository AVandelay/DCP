

fileprivate func minimumDifference(_ nums: [Int]) -> Int {
    let midIndex = nums.count / 2
    let left = Array(nums[0..<midIndex])
    let right = Array(nums[midIndex...])
    let leftSum = left.reduce(0, +)
    let rightSum = right.reduce(0, +)

    var ans = Int.max

    for i in 0...midIndex {
        let leftCombinations = combinations(left, choose: i).map { 2 * $0.reduce(0, +) - leftSum }
        let sortedLeftVals = leftCombinations.sorted()

        for rightCombo in combinations(right, choose: midIndex - i) {
            let diff = 2 * rightCombo.reduce(0, +) - rightSum
            if let k = sortedLeftVals.firstIndex(where: { $0 >= -diff }) {
                if k > 0 {
                    ans = min(ans, abs(sortedLeftVals[k - 1] + diff))
                }
                if k < sortedLeftVals.count {
                    ans = min(ans, abs(sortedLeftVals[k] + diff))
                }
            }
        }
    }

    return ans
}

func combinations<T>(_ elements: [T], choose: Int) -> [[T]] {
    guard choose != 0 else { return [[]] }
    guard !elements.isEmpty else { return [] }

    let head = elements[0]
    let subcombinations = combinations(Array(elements.dropFirst()), choose: choose - 1)
    return combinations(Array(elements.dropFirst()), choose: choose) + subcombinations.map { [head] + $0 }
}

import XCTest

final class PartitionArrayIntoTwoArraysToMinimizeSumDifferenceTests: XCTestCase {
    func test() {
        XCTAssertEqual(minimumDifference([3,9,7,3]), 2)
    }
}

