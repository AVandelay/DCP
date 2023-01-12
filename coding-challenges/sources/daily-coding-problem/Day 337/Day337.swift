

fileprivate final class Node {
    var value: Int
    var next: Node?
    init(_ value: Int) {
        self.value = value
    }
}

fileprivate final class LinkedList {
    var head: Node?

    /**
     Shuffle the Linked List
     - Complexity: `O(n)`
     */
    @discardableResult
    func shuffle() -> Node? {
        let size = length(node: head)
        guard size > 1 else { return nil }

        let sentinel: Node? = Node(-1)
        sentinel?.next = head
        // Start with a window of size 1, growing by a factor of 2 each time
        // window keeps track of the current sublist being shuffled. The sublists
        // with the current window size are then shuffled by merging them in a random
        // order using the `merge` helper method.
        var window = 1
        while window < size {
            var previousList = sentinel
            var current = sentinel?.next

            while current != nil {
                // Isolate the left sublist as `left`
                var left = current
                var previous: Node?
                var right = left
                for _ in 0..<window {
                    guard right != nil else { break }
                    previous = right
                    right = right?.next
                }
                previous?.next = nil

                // Isolate the right sublist as `right`
                current = right
                for _ in 0..<window {
                    guard current != nil else { break }
                    previous = current
                    current = current?.next
                }
                previous?.next = nil

                // Merge the two sublists
                let merged = merge(left: &left, right: &right)
                // Add back into the list in the correct location
                previousList?.next = merged
                previousList = last(node: merged) ?? head
            }

            window *= 2
        }

        return sentinel?.next
    }

    /**
     Helper method for shuffling a linked list.
     - Parameter node: The initial node of the linked list
     - Returns: The number of nodes in a list.
     - Complexity: O(n)
     */
    private func length(node: Node?) -> Int {
        var count = 0
        var current = node
        while current != nil {
            count += 1
            current = current?.next
        }
        return count
    }

    /**
     Helper method for shuffling a linked list.
     Given two linked lists, left and right, this method will merge the nodes of the two lists into a new list in a random order.
     - Parameters:
         - left: The first linked list to be merged.
         - right: The second linked list to be merged.
     - Returns: A new linked list containing the merged nodes of the left and right lists in a random order.
     - Complexity: O(n) where n is the total number of nodes in both the left and right lists.
     */
    private func merge(left: inout Node?, right: inout Node?) -> Node? {
        // Create dummy node to act as the head of the new merged list
        let dummy = Node(-1)
        var current = dummy
        // Keep track of the remaining lengths of the left and right lists
        var leftLen = length(node: left)
        var rightLen = length(node: right)
        // Iterate through both lists until one is exhausted
        while left != nil || right != nil {
            // Generate a random number between 0 and 1
            let random = Double.random(in: 0...1)
            // Compare the random number against the ratio of the remaining length of
            // the left list to the total remaining length of both lists.
            if random < Double(leftLen) / Double(leftLen + rightLen) {
                // Add a node from the left list to the new merged list
                current.next = left
                left = left?.next
                leftLen -= 1
            } else {
                current.next = right
                right = right?.next
                rightLen -= 1
            }
            current = current.next!
        }
        return dummy.next
    }

    /**
     Helper method for shuffling a linked list.
     - Parameter node: the node of the linked list
     - Returns the last node of the linked list
     - Complexity: `O(n)`
     */
    private func last(node: Node?) -> Node? {
        var current = node
        while current != nil {
            current = current?.next
        }
        return current
    }
}

import XCTest

final class Day337: XCTestCase {
    func test() {
        let list = LinkedList()
        let node1 = Node(1)
        list.head = node1
        let node2 = Node(2)
        node1.next = node2
        let node3 = Node(3)
        node2.next = node3
        let node4 = Node(4)
        node3.next = node4
        var result = [Int]()
        var node = list.head
        list.shuffle()
        while let value = node?.value {
            result.append(value)
            node = node?.next
        }
        // Assert that the values of the shuffled list are not in their original order
        XCTAssertNotEqual(result, [1, 2, 3, 4])
    }
}
