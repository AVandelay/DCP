

fileprivate final class XORLinkedListNode {
    var value: Int
    var both: Int

    init(value: Int, both: Int) {
        self.value = value
        self.both = both
    }
}

fileprivate final class XORLinkedList {
    var head: XORLinkedListNode?
    var tail: XORLinkedListNode?

    func add(element: Int) {
        var newNode = XORLinkedListNode(value: element, both: 0)

        if var tail = tail {
            tail.both = tail.both ^ address(node: &newNode)
            newNode.both = address(node: &tail)
        } else {
            head = newNode
        }

        tail = newNode
    }

    func get(index: Int) -> XORLinkedListNode? {
        var prev: XORLinkedListNode?
        var current: XORLinkedListNode? = head
        var i = 0

        while current != nil && i < index {
            let next = current!.both ^ address(node: &prev)
            prev = current
            current = UnsafeMutablePointer<XORLinkedListNode>(bitPattern: next)?.pointee
            i += 1
        }

        return current
    }

    func address(node: UnsafeRawPointer) -> Int {
        return Int(bitPattern: node)
    }
}

import XCTest

final class Day6: XCTestCase {
    func test() {
        let ll = XORLinkedList()
        for value in 0...5 {
            ll.add(element: value)
        }
        if let node = ll.get(index: 2) {
            XCTAssertEqual(node.value, 2)
        }
    }
}

