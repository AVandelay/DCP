

func numJewelsInStones(_ jewels: String, _ stones: String) -> Int {
    var count = 0
    let jewelSet = Set(jewels)
    for stone in stones {
        if jewelSet.contains(stone) {
            count += 1
        }
    }
    return count
}

import XCTest

final class JewelsAndStonesTests: XCTestCase {
    func testNumJewelsInStones() {
        let testCases: [(jewels: String, stones: String, expectation: Int)] = [
            ("aA", "aAAbbbb", 3),
            ("z", "ZZ", 0)
        ]

        testCases.forEach { testCase in
            XCTAssertEqual(numJewelsInStones(testCase.jewels, testCase.stones), testCase.expectation)
        }
    }
}
