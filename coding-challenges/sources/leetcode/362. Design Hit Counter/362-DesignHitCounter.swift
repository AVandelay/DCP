

/**
 A hit counter that counts the number of hits received in the past 5 minutes (i.e., the past 300 seconds).
 This implementation uses a circular buffer to store the timestamp and hit count of each recorded hit.
 The buffer has a fixed size of 300, which means that it can store the timestamp and hit count for the last 300 seconds.
 When a new hit is recorded, it overwrites the oldest entry in the buffer.
 This allows for constant time insertions (O(1)) and retrievals (O(n)) of the number of hits in the last 5 minutes.
 The space complexity is O(n) where n is the buffer size.
 */
class HitCounter {

    // MARK: - Properties

    private var buffer: [(timestamp: Int, hits: Int)] = Array(repeating: (0, 0), count: 300)
    private var index = 0

    // MARK: - Initializers

    init() { }

    // MARK: - Public Methods

    /**
     Record a hit.
     - Parameter timestamp: The current timestamp (in seconds granularity)
     */
    func hit(_ timestamp: Int) {
        buffer[index] = (timestamp, buffer[index].hits + 1)
        index = (index + 1) % 300
    }

    /**
     Return the number of hits in the past 5 minutes.
     - Parameter timestamp: The current timestamp (in seconds granularity).
     - Returns: the number of hits in the past 5 minutes
     */
    @discardableResult
    func getHits(_ timestamp: Int) -> Int {
        var total = 0
        for i in 0..<300 {
            if timestamp - buffer[i].0 < 300 {
                total += buffer[i].1
            }
        }
        return total
    }
}

import XCTest

final class DesignHitCounterTests: XCTestCase {

    func testHit() {
        let hitCounter = HitCounter()
        hitCounter.hit(1)
        hitCounter.hit(2)
        hitCounter.hit(3)
        XCTAssertEqual(hitCounter.getHits(4), 3)
    }

    func testGetHits() {
        let hitCounter = HitCounter()
        hitCounter.hit(1)
        hitCounter.hit(2)
        hitCounter.hit(3)
        XCTAssertEqual(hitCounter.getHits(4), 3)
        hitCounter.hit(300)
        XCTAssertEqual(hitCounter.getHits(300), 4)
        XCTAssertEqual(hitCounter.getHits(301), 3)
    }

    func testGetHitsForExpiredHits() {
        let hitCounter = HitCounter()
        hitCounter.hit(1)
        hitCounter.hit(2)
        hitCounter.hit(3)
        XCTAssertEqual(hitCounter.getHits(4), 3)
        hitCounter.hit(301)
        hitCounter.hit(302)
        hitCounter.hit(303)
        hitCounter.hit(304)
        hitCounter.hit(305)
        hitCounter.hit(306)
        hitCounter.hit(601)
        XCTAssertEqual(hitCounter.getHits(601), 6)
    }
}
