

fileprivate final class Node {
    var value: Int?
    var both: Int?

    init(value: Int?) {
        self.value = value
    }
}

fileprivate final class XORLinkedList {
    var head: Node?
    var tail: Node?

    init(_ head: Node? = nil, _ tail: Node? = nil) {
        self.head = head
        self.tail = tail
    }

    func add(element: Int) {
        let node = Node(value: element)
        guard head != nil else {
            head = node
            tail = node
            node.both = head!.value! ^ tail!.value!
            return
        }

        node.both = address(node: &tail!.both)
        tail!.both = address(node: &tail!.both) ^ address(node: &node.value)
        tail = node
    }

    func get(index: Int) -> Node? {
        guard let node = head else { return nil }
        var prevAddress = 0

        for _ in 0...index {
            let nextAddress = prevAddress ^ address(node: &node.both!)

            prevAddress = node.both!
            node.both = nextAddress
        }
        return node
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
        XCTAssertEqual(ll.get(index: 0)!.value, 0)
    }
}

