
/**
 * A simple node class for a singly linked list.
 *
 * - value: The value stored in the node.
 * - next: The next node in the linked list
 */
fileprivate final class Node {
    /// The value stored in the node
    let value: Int
    /// The next node in the linked list
    var next: Node?

    /**
     * Initializes a new node with a value and an optional next node.
     *
     * - value: The value to store in the node.
     * - next: The next node in the linked list.
     */
    init(_ value: Int, next: Node? = nil) {
        self.value = value
        self.next = next
    }

    /**
     * Optional Initializer initializes a linked list from an array
     *
     * - value: The value to store in the node.
     * - next: The next node in the linked list.
     */
    init?(_ array: [Int]) {
        guard !array.isEmpty else { return nil }
        self.value = array[0]
        var prev: Node = self
        for i in 1..<array.count {
            let new = Node(array[i])
            prev.next = new
            prev = new
        }
    }
}

/**
 * Removes the kth last element from a singly linked list.
 *
 * - head: The head node of the linked list.
 * - k: The kth last element to be removed.
 *
 * - Returns: The head of the modified linked list.
 */
fileprivate func removeKthLastElement(head: Node?, k: Int) -> Node? {
    // Create sentinel node to simplify edge cases
    let sentinelNode = Node(-1, next: head)
    // Pointer to the node before the kth last element
    var slow: Node? = sentinelNode
    // Pointer to the node k positions ahead of the slow pointer
    var fast: Node? = sentinelNode

    // Move fast pointer k positions ahead of the slow pointer
    for _ in 0...k {
        fast = fast?.next
    }

    // Move both pointers until the fast pointer reaches the end of the list
    while fast != nil {
        slow = slow?.next
        fast = fast?.next
    }
    // Remove the kth last element by updating the next pointer of the slow pointer
    slow?.next = slow?.next?.next

    // Return the head of the modified list, excluding the sentinel node
    return sentinelNode.next
}

import XCTest

final class Day26: XCTestCase {
    func testRemoveKthLastElement() {
        // [25] -> [20] -> [15] -> [10] -> [5] ->
        let node1 = Node(5)
        let node2 = Node(10, next: node1)
        let node3 = Node(15, next: node2)
        let node4 = Node(20, next: node3)
        let node5 = Node(25, next: node4)

        // Test removing only node
        var head = removeKthLastElement(head: node1, k: 1)
        XCTAssertNil(head)

        // Test removing last node
        // [25] -> [20] -> [15] -> [10] ->
        head = removeKthLastElement(head: node5, k: 1)
        XCTAssertEqual(head?.value, 25)
        XCTAssertEqual(head?.next?.value, 20)
        XCTAssertEqual(head?.next?.next?.value, 15)
        XCTAssertEqual(head?.next?.next?.next?.value, 10)
        XCTAssertNil(head?.next?.next?.next?.next)

        // Test first node
        // [20] -> [15] -> [10] ->
        head = removeKthLastElement(head: head, k: 4)
        XCTAssertEqual(head?.value, 20)
        XCTAssertEqual(head?.next?.value, 15)
        XCTAssertEqual(head?.next?.next?.value, 10)
        XCTAssertNil(head?.next?.next?.next)

        // Test removing middle node
        // [20] -> [10] ->
        head = removeKthLastElement(head: head, k: 2)
        XCTAssertEqual(head?.value, 20)
        XCTAssertEqual(head?.next?.value, 10)
        XCTAssertNil(head?.next?.next)
    }
}
