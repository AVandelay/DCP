

fileprivate final class Node<Value> {
    var value: Value
    var left: Node?
    var right: Node?

    init(value: Value,
         left: Node? = nil,
         right: Node? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}

fileprivate func countUnivalSubtrees<Value: Equatable>(root: Node<Value>?) -> Int {
    guard let root else { return 0 }

    var count = 0

    if isUnival(node: root, value: root.value) {
        count += 1
    }

    count += countUnivalSubtrees(root: root.left)
    count += countUnivalSubtrees(root: root.right)

    return count
}

private func isUnival<Value: Equatable>(node: Node<Value>?, value: Value) -> Bool {
    guard let node else { return true }

    if node.value != value {
        return false
    }

    return isUnival(node: node.left, value: value) && isUnival(node: node.right, value: value)
}

import XCTest

final class Day8: XCTestCase {
    func test() {
        let root = Node(value: 0,
                        left: Node(value: 1),
                        right: Node(value: 0,
                                    left: Node(value: 1,
                                               left: Node(value: 1),
                                               right: Node(value: 1)),
                                    right: Node(value: 0)))
        XCTAssertEqual(countUnivalSubtrees(root: root), 5)
    }
}
