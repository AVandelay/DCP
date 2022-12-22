

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
            tail.both = tail.both ^ getPointer(for: &newNode)
            newNode.both = getPointer(for: &tail)
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
            let next = current!.both ^ getPointer(for: &prev)
            prev = current
            current = dereferencePointer(for: next)
            i += 1
        }

        return current
    }

    private func getPointer(for node: UnsafeRawPointer) -> Int {
        return Int(bitPattern: node)
    }

    private func dereferencePointer(for node: Int) -> XORLinkedListNode? {
        return UnsafeMutablePointer<XORLinkedListNode>(bitPattern: node)?.pointee
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

