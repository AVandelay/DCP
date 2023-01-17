

fileprivate func kadanesAlgorithm(array: [Int]) -> Int {
    guard array.count > 0 else { return 0 }
    guard array.count > 1 else { return array[0] }

    var currentMax = array[0]
    var globalMax = currentMax
    for num in array[1...] {
        currentMax = max(currentMax + num, num)
        globalMax = max(globalMax, currentMax)
    }

    return globalMax
}

import XCTest

final class KadanesAlgorithmTests: XCTestCase {
    func testEmptyArray() {
        XCTAssertEqual(kadanesAlgorithm(array: []), 0)
    }

    func testArrayWithOneValue() {
        XCTAssertEqual(kadanesAlgorithm(array: [1]), 1)
    }

    func testKadanesAlgorithm() {
        XCTAssertEqual(kadanesAlgorithm(array: [3, 5, -9, 1, 3, -2, 3, 4, 7, 2, -9, 6, 3, 1, -5, 4]), 19)
    }
}
