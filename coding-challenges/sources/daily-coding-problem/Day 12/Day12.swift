

fileprivate func climbStaircase(steps: Int) -> Int {
    if steps < 2 { return 1 }

    var ways = [Int](repeating: 1, count: steps + 1)
    for i in 2..<ways.count {
        ways[i] = ways[i - 1] + ways[i - 2]
    }
    return ways[steps]
}

import XCTest

final class Day12: XCTestCase {
    func test() {
        XCTAssertEqual(climbStaircase(steps: 4), 5)
    }
}
