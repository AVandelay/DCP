

fileprivate final class OrderLog {

    // MARK: - Private Properties

    // Maximum size of the order log.
    private let n: Int
    // Circular buffer to store the order IDs.
    private var orders: [Int]
    // Index of the first element in the buffer.
    private var start = 0
    // Index to the next element to be added to the buffer.
    private var end = 0


    // MARK: - Initializers

    // Initialize a new order log
    init(n: Int) {
        self.n = n
        self.orders = [Int](repeating: 0, count: n)
    }

    // Adds an order ID to the log.
    func record(orderID: Int) {
        // Add the order ID to the end of the buffer.
        orders[end] = orderID
        // Update the end index.
        end = (end + 1) % n
        // If the buffer is full, remove the oldest element
        if end == start {
            start = (start + 1) % n
        }
    }

    // Returns the ith last element from the log.
    func getLast(i: Int) -> Int {
        // Compute the index of the element in the buffer
        orders[(end - i + n) % n]
    }
}

import XCTest

final class Day16: XCTestCase {
    func test() {
        let log = OrderLog(n: 3)

        // Record some order IDs
        for i in (1...4) {
            log.record(orderID: i)
        }

        // Check the last 3 order IDs are correct
        XCTAssertEqual(log.getLast(i: 1), 4)
        XCTAssertEqual(log.getLast(i: 2), 3)
        XCTAssertEqual(log.getLast(i: 3), 2)
    }
}
