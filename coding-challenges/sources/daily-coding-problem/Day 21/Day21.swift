

fileprivate func minimumRooms(intervals: [(Int, Int)]) -> Int {
    // Sort the intervals by their start time
    let starts = intervals.map { $0.0 }.sorted()
    let ends = intervals.map { $0.1 }.sorted()

    // Pointers for start and end pointers
    var startPointer = 0
    var endPointer = 0

    // Variables to track the max number of overlaps and current number of overlaps
    var maxOverlaps = 0
    var currentOverlaps = 0

    // Iterate through sorted intervals
    while startPointer < intervals.count {
        // If the current start is before the current end, we have a new overlap
        if starts[startPointer] < ends[endPointer] {
            currentOverlaps += 1
            startPointer += 1
        } else {
            // If the current start is after the current end, the overlap closes
            currentOverlaps -= 1
            endPointer += 1
        }
        // Update the max number of overlaps
        maxOverlaps = max(maxOverlaps, currentOverlaps)
    }

    return maxOverlaps
}

import XCTest

final class Day21: XCTestCase {
    func test() {
        let testCases = [
            ([(30, 75), (0, 50), (60, 150)], 2),
            ([(0, 10), (10, 20)], 1),
            ([(0, 10), (5, 15), (5, 20)], 3)
        ]

        for (intervals, expected) in testCases {
            XCTAssertEqual(minimumRooms(intervals: intervals), expected)
        }
    }
}
