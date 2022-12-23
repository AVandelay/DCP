

func largestSum(numbers: [Int]) -> Int {
    guard !numbers.isEmpty else { return 0 }

    guard numbers.count != 1 else { return numbers.first! }

    var prevMax = numbers[0]
    var currMax = max(numbers[0], numbers[1])
    for i in 2..<numbers.count {
        let temp = currMax
        currMax = max(currMax, prevMax + numbers[i])
        prevMax = temp
    }
    return currMax
}

import XCTest

final class Day9: XCTestCase {
    func test() {
        XCTAssertEqual(largestSum(numbers: [2, 4, 6, 2, 5]), 13)
        XCTAssertEqual(largestSum(numbers: [5, 1, 1, 5]), 10)
    }
}
