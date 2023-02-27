

fileprivate final class Solution {
    private var original: [Int]
    private var shuffled: [Int]

    init(_ nums: [Int]) {
        original = nums
        shuffled = nums
    }

    /** Resets the array to its original configuration and return it. */
    func reset() -> [Int] {
        shuffled = original
        original = []
        return shuffled
    }

    /**
     A Fisher-Yates shuffle implementation in Swift that shuffles an array of integers.

     The Fisher-Yates shuffle algorithm shuffles a collection by iteratively swapping each element in the collection with another randomly selected element.

     In this implementation, we start with the last element of the array and swap it with a random element in the range of 0 to the current index. We then decrement the index and continue until we've swapped the first element.
     */
    func shuffle() -> [Int] {
        for i in stride(from: shuffled.count - 1, through: 1, by: -1) {
            let j = Int.random(in: 0...i)
            shuffled.swapAt(i, j)
        }
        return shuffled
    }
}
import XCTest

final class ShuffleAnArrayTests: XCTestCase {
    func testShuffleAnArray() {
        let solution = Solution([1, 2, 3])
        XCTAssertNotEqual(solution.shuffle(), [1, 2, 3])
        XCTAssertEqual(solution.reset(), [1,2,3])
        XCTAssertNotEqual(solution.shuffle(), [1, 2, 3])
    }
}
