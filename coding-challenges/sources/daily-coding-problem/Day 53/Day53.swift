

fileprivate class QueueWithStacks {
    // Stack for enqueue operations
    private(set) var enqueueStack: [Int] = []
    // Stack for dequeue operations
    private(set) var dequeueStack: [Int] = []

    /// Inserts an element into the queue
    /// - Parameter element: The element to be inserted
    /// - Complexity: O(1) for enqueue operation, as it only appends the element at the end of the stack
    func enqueue(element: Int) {
        // Push the new element onto enqueueStack
        enqueueStack.append(element)
    }

    /// Removes and returns the first element in the queue
    /// - Returns: The first element in the queue or `nil` if the queue is empty
    /// - Complexity: O(n) for dequeue operation where n is the number of elements in the queue. In worst case scenario,
    ///               if all elements are in enqueueStack, all elements need to be transferred to dequeueStack
    func dequeue() -> Int? {
        // If dequeueStack is empty, transfer elements from enqueueStack
        if dequeueStack.isEmpty {
            while !enqueueStack.isEmpty {
                dequeueStack.append(enqueueStack.popLast()!)
            }
        }

        // Pop and return the first element from dequeueStack
        return dequeueStack.popLast()
    }
}

import XCTest

final class Day53: XCTestCase {

    fileprivate var queue: QueueWithStacks? = QueueWithStacks()

    func testEnqueue() {
        queue?.enqueue(element: 1)
        queue?.enqueue(element: 2)
        queue?.enqueue(element: 3)

        XCTAssertEqual(queue?.enqueueStack.count, 3)
        queue = nil
    }

    func testDequeue() {
        queue?.enqueue(element: 1)
        queue?.enqueue(element: 2)
        queue?.enqueue(element: 3)

        let first = queue?.dequeue()
        let second = queue?.dequeue()

        XCTAssertEqual(first, 1)
        XCTAssertEqual(second, 2)
        
        XCTAssertEqual(queue?.dequeueStack.count, 1)

        queue = nil
    }
}
