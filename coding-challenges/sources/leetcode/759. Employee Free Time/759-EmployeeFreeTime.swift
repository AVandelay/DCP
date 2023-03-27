

fileprivate class Interval {
    var start: Int
    var end: Int
    init(_ start: Int, _ end: Int) {
        self.start = start
        self.end = end
    }
}

fileprivate func employeeFreeTime(_ schedule: [[Interval]]) -> [Interval] {
    // Flatten and sort the intervals in the schedule
    let sortedIntervals = schedule
        .flatMap { $0 }
        .sorted { $0.start < $1.start }

    // Calculate the merged intervals
    let mergedIntervals = sortedIntervals.reduce([]) { (result, interval) -> [Interval] in
        var merged = result
        if let last = merged.last,
           last.end >= interval.start {
            last.end = max(last.end, interval.end)
        } else {
            merged.append(interval)
        }
        return merged
    }

    // Find the free time intervals between the merged intervals
    let freeTimeIntervals = zip(mergedIntervals, mergedIntervals.dropFirst())
        .map { (prev, curr) -> Interval in
            Interval(prev.end, curr.start)
        }

    return freeTimeIntervals
}

import XCTest

final class EmployeeFreeTimeTests: XCTestCase {
    func test() {
        let schedule = [
            [Interval(1, 2), Interval(5, 6)],
            [Interval(1, 3)],
            [Interval(4, 10)]
        ]
        let freeTimeIntervals = employeeFreeTime(schedule)
        var actual = [Int]()
        let expectation = [3, 4]
        for interval in freeTimeIntervals {
            actual.append(interval.start)
            actual.append(interval.end)
        }
        XCTAssertEqual(expectation, actual)
    }
}
