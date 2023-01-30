

import Foundation

/// Class to keep track of hits using binary search and condensing the timestamp to 1 minute intervals
/// In comparison the brute force approach would be the following implementation
/// class HitCounter {
///   var hits: [(Int, Int)] = []
///   func record(timestamp: Int) {
///     hits.append((timestamp, 1))
///   }
///   func total() -> Int {
///     hits.reduce(0) { $0 + $1.1 }
///   }
///   func range(lower: Int, upper: Int) -> Int {
///     return hits.filter { $0.0 >= lower && $0.0 <= upper }.reduce(0) { $0 + $1.1 }
///   }
/// }
fileprivate class HitCounter {

    // MARK: - Private Properties

    private var hits = [(timestamp: Int, hits: Int)]()
    private let interval = 60.0 // 1-minute interval

    // MARK: - Public Methods

    /// Records a hit that happened at the given timestamp
    /// - Parameter timestamp: the timestamp at which the hit occurred
    func record(timestamp: Date) {
        // convert the timestamp to minutes
        let minute = Int(timestamp.timeIntervalSinceReferenceDate / interval)
        // find the index of the element in the `hits` array that is greater than or equal to `minute`
        let index = hits.firstIndex { $0.timestamp >= minute } ?? hits.count
        // if the element with the same timestamp exists, increment the number of hits
        if index < hits.count, hits[index].timestamp == minute {
            hits[index].hits += 1
        } else {
            // insert the new tuple of (timestamp, 1) at the found index
            hits.insert((minute, 1), at: index)
        }
    }

    /// Returns the total number of hits recorded
    func total() -> Int {
        hits.reduce(0) { $0 + $1.hits }
    }

    /// Returns the number of hits that occurred between timestamps `lower` and `upper` (inclusive)
    /// - Parameters:
    ///     - lower: the lower timestamp
    ///     - upper: the upper timestamp
    func range(lower: Date, upper: Date) -> Int {
        // convert the lower and upper timestamps to minutes
        let lowerMinute = Int(lower.timeIntervalSinceReferenceDate / interval)
        let upperMinute = Int(upper.timeIntervalSinceReferenceDate / interval)
        // find the lower and upper hit indices using binary search
        let lowerHitIndex = binarySearch(for: lowerMinute)
        let upperHitIndex = binarySearch(for: upperMinute)
        var count = 0
        for i in lowerHitIndex...upperHitIndex {
            count += hits[i].hits
        }
        return count
    }

    /// Binary search for the index of the hit that has the same timestamp as the given `minute`
    /// - Parameter minute: the given timestamp in minutes
    private func binarySearch(for minute: Int) -> Int {
        var low = 0
        var high = hits.count - 1
        while low <= high {
            let mid = (low + high) / 2
            if hits[mid].timestamp < minute {
                low = mid + 1
            } else if hits[mid].timestamp > minute {
                high = mid - 1
            } else {
                return mid
            }
        }
        return low
    }
}

import XCTest

final class Day132: XCTestCase {
    func test() {
        let hitCounter = HitCounter()
        let time1 = Date(timeIntervalSinceReferenceDate: 0)
        let time2 = Date(timeIntervalSinceReferenceDate: 30)
        let time3 = Date(timeIntervalSinceReferenceDate: 60)
        let time4 = Date(timeIntervalSinceReferenceDate: 240)
        hitCounter.record(timestamp: time1)
        hitCounter.record(timestamp: time2)
        hitCounter.record(timestamp: time3)
        hitCounter.record(timestamp: time4)
        XCTAssertEqual(hitCounter.total(), 4)
        XCTAssertEqual(hitCounter.range(lower: time1, upper: time2), 2)
        XCTAssertEqual(hitCounter.range(lower: time1, upper: time3), 3)
        XCTAssertEqual(hitCounter.range(lower: time1, upper: time4), 4)
    }
}
