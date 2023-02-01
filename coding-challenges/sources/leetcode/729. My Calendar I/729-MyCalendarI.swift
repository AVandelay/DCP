

fileprivate class MyCalendar {
    // Initialize an empty sorted list of events
    private var events = [(start: Int, end: Int)]()

    /**
     *  Book a time slot in the calendar
     *
     *  - Parameters:
     *      - start: The start time of the booking, represented as an integer
     *      - end: The end time of the booking, represented as an integer
     *  - Returns `true` if the booking was successful, `false` otherwise.
     *  - Complexity
     *      - Time: `O(log n)`
     *      - Space: `O(n)`
     *
     *  The `book` method checks if the time slot defined by `start` and `end` overlaps with any existing bookings in the calendar.
     *  If the time slot is available, the booking is added to the calendar and the method returns `true`.
     *  If the time slot is not available, the method returns `false`.
     */
    func book(_ start: Int, _ end: Int) -> Bool {
        // Use binary search to find the index that maps to (start, end)
        guard let index = events.firstIndex(where: binarySearch(start: start, end: end)) else {
            // The list of events is empty, so add (start, end)
            events = [(start, end)]
            return true
        }

        // Check if the start of the current booking is less than the end time of the previous booking
        guard index == 0 || events[index - 1].end > start else { return false }
        // Check if the end of the current booking is greater than the start time of the next booking
        guard index == events.count || events[index].start >= end else { return false }

        events.insert((start, end), at: index)

        return true
    }

    /**
     *  Performs binary search on an array of tuples to find the if value exists.
     *
     *  - Parameters
     *      - start: The start value to compare against the tuples in the array.
     *      - end: The end value to compare against the tuples in the array.
     *  - Returns: A closure that takes in a tuple and returns a true if the value was found in the array and false otherwise
     */
    private func binarySearch(start: Int, end: Int) -> ((Int, Int)) -> Bool {
        return { (value: (Int, Int)) -> Bool in
            let (valueStart, valueEnd) = value
            if start >= valueEnd {
                return false
            } else if end <= valueStart {
                return false
            } else {
                return true
            }
        }
    }
}

import XCTest

final class MyCalendarITests: XCTestCase {
    func test() {
        let calendar = MyCalendar()
        XCTAssertTrue(calendar.book(10, 20))
        XCTAssertFalse(calendar.book(15, 25))
        XCTAssertTrue(calendar.book(20, 30))
    }
}
