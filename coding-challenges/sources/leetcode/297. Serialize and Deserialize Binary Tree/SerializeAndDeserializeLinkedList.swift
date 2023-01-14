

import Foundation

fileprivate class Node: Hashable {
    private var id = UUID()
    var value: Int
    var next: Node?

    init(value: Int) {
        self.value = value
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: Node, rhs: Node) -> Bool {
        return lhs.id == rhs.id
    }
}

/**
 *  Serializes the linked list.
 *  - Returns a string representation of the linked list values.
 *  - Complexity
 *      - Time: `O(n)`
 *      - Space: `O(n)`
 *
 *  Serialize the linked list by traversing it and appending the values of the nodes
 *  and the next pointers to a string. Handle cycles by using a set to keep track
 *  of the nodes that have already been visited. If a node is encountered that is
 *  already in the set, append a special character to the string instead of the next pointer.
 *
 */
fileprivate func serialize(head: Node?) -> String {
    var serialized = ""
    var visited = Set<Node>()
    var current = head
    while current != nil {
        if visited.contains(current!) {
            serialized += "#"
            break
        } else {
            serialized += "\(current!.value),"
            visited.insert(current!)
        }
        current = current?.next
    }

    return serialized
}

/**
 * Deserializes the string and creates a linked list.
 * - Parameter data: The string of the values for the linked list
 * - Returns Node?: the head node of the linked list
 * - Complexity:
 *  - Time: `O(n)`
 *  - Space: `O(n)`
 *
 * Deserialize the string by creating new nodes for each value in the string
 * and linking them together. Handle cycles by checking for the special character
 * and linking the last node in the deserialized list back to the appropriate node.
 */
fileprivate func deserialize(data: String) -> Node? {
    let serializedStrings = data.split(separator: ",")
    var root: Node?
    var current: Node?
    for value in serializedStrings {
        if value == "#" {
            current = nil
        } else {
            if let intValue = Int(value) {
                let newNode = Node(value: intValue)
                if root == nil {
                    root = newNode
                    current = root
                } else {
                    current?.next = newNode
                    current = newNode
                }
            }
        }
    }
    return root
}

import XCTest

final class SerializeAndDeserializeLinkedList: XCTestCase {
    func testSerializeDeserialize() {
        let node1 = Node(value: 1)
        let node2 = Node(value: 2)
        let node3 = Node(value: 3)
        let node4 = Node(value: 4)

        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node2 // Creating a cycle

        let serialized = serialize(head: node1)
        let deserialized = deserialize(data: serialized)

        // check if the deserialized linked list is equal to the original one
        var current: Node? = node1
        var currentDeserialized = deserialized
        while currentDeserialized != nil {
            XCTAssertEqual(current?.value, currentDeserialized?.value)
            current = current?.next
            currentDeserialized = currentDeserialized?.next
        }
    }
}
