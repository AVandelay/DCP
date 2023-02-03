

fileprivate class TimeMap {
    typealias TimeStamp = (timestamp: Int, value: String)
    var data = [String: [TimeStamp]]()

    /**
     * Stores the key `key` with the value `value` at the given time `timestamp`.
     *
     * - Parameters:
     *   - key: The key to be stored.
     *   - value: The value to be stored for the key.
     *   - timestamp: The timestamp for the key-value data.
     */
    func set(key: String, value: String, timestamp: Int) {
        // If the 'key' does not exist in dictionary.
        if data[key] == nil {
            data[key] = []
        }

        // Store '(timestamp, value)' pair in 'key' bucket.
        data[key]!.append((timestamp, value))
    }

    func get(key: String, timestamp: Int) -> String {
        // If the 'key' does not exist in dictionary we will return empty string.
        guard let values = data[key] else {
            return ""
        }

        if timestamp < values[0].timestamp {
            return ""
        }

        var left = 0
        var right = values.count - 1

        while left <= right {
            let mid = (left + right) >> 1
            if values[mid].timestamp < timestamp {
                left = mid + 1
            } else if values[mid].timestamp > timestamp {
                right = mid - 1
            } else {
                return values[mid].value
            }
        }

        // If iterator points to first element it means, no time <= timestamp exists.
        return right >= 0 ? values[right].value : ""
    }
}

import XCTest

final class TimeBasedKeyValueStoreTests: XCTestCase {
    func test() {
        let timeMap = TimeMap()
        timeMap.set(key: "foo", value: "bar", timestamp: 1)
        XCTAssertEqual(timeMap.get(key: "foo", timestamp: 1), "bar")
        XCTAssertEqual(timeMap.get(key: "foo", timestamp: 3), "bar")
        timeMap.set(key: "foo", value: "bar2", timestamp: 4)
        XCTAssertEqual(timeMap.get(key: "foo", timestamp: 4), "bar2")
        XCTAssertEqual(timeMap.get(key: "foo", timestamp: 5), "bar2")
    }
}
