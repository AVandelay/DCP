

/// PeekingIterator class that supports peek operation on an existing iterator in addition to the hasNext and the next operations.
///
/// - Complexity:
///     - `init`: O(1)
///     - `next`: O(1)
///     - `peek`: O(1)
///     - `hasNext`: O(1)
class PeekingIterator {
    enum PeekingIteratorError: Error {
        case noMoreElements
    }

    private var iterator: IndexingIterator<Array<Int>>
    private var current: Int? = nil

    /// Initializes the object with the given integer iterator iterator.
    ///
    /// - Parameter arr: iterator
    ///
    /// - Complexity: O(1)
    init(_ arr: IndexingIterator<Array<Int>>) {
        iterator = arr
        current = iterator.next()
    }

    /// Returns the next element in the array and moves the pointer to the next element.
    ///
    /// - Returns: next element in the array
    ///
    /// - Complexity: O(1)
    func next() throws -> Int {
        guard let current else { throw PeekingIteratorError.noMoreElements }
        self.current = iterator.next()
        return current
    }

    /// Returns the next element in the array without moving the pointer.
    ///
    /// - Returns: next element in the array
    ///
    /// - Complexity: O(1)
    func peek() throws -> Int {
        guard let current else { throw PeekingIteratorError.noMoreElements }
        return current
    }

    /// Returns true if there are still elements in the array.
    ///
    /// - Returns: true if there are still elements in the array, false otherwise
    ///
    /// - Complexity: O(1)
    func hasNext() -> Bool {
        return current != nil
    }
}

import XCTest

final class PeekingIteratorTests: XCTestCase {
    func testPeekingIterator() {
        let array = [1, 2, 3, 4, 5]
        let iterator = PeekingIterator(array.makeIterator())

        XCTAssertTrue(iterator.hasNext())
        XCTAssertEqual(try iterator.peek(), 1)
        XCTAssertEqual(try iterator.next(), 1)
        XCTAssertEqual(try iterator.next(), 2)
        XCTAssertEqual(try iterator.peek(), 3)
        XCTAssertEqual(try iterator.next(), 3)
        XCTAssertEqual(try iterator.next(), 4)
        XCTAssertEqual(try iterator.next(), 5)
        XCTAssertFalse(iterator.hasNext())
    }

    func testPeekingIteratorWithError() {
        let array = [1, 2, 3, 4, 5]
        let iterator = PeekingIterator(array.makeIterator())

        XCTAssertEqual(try iterator.peek(), 1)
        XCTAssertEqual(try iterator.next(), 1)
        XCTAssertEqual(try iterator.next(), 2)
        XCTAssertEqual(try iterator.peek(), 3)
        XCTAssertEqual(try iterator.next(), 3)
        XCTAssertEqual(try iterator.next(), 4)
        XCTAssertEqual(try iterator.next(), 5)
        XCTAssertThrowsError(try iterator.next(), "no more elements") { error in
            XCTAssertEqual(error as? PeekingIterator.PeekingIteratorError, PeekingIterator.PeekingIteratorError.noMoreElements)
        }
    }
}

