

fileprivate final class Node {
    var val: Int
    var next: Node?

    init(_ val: Int, next: Node? = nil) {
        self.val = val
        self.next = next
    }
}

extension Node {
    var length: Int {
        // Return 0 if the list is empty
        guard let next = self.next else { return 0 }

        // Return 1 plush length of the rest of the list
        return 1 + next.length
    }
}

fileprivate func intersection(_ a: Node?, _ b: Node?) -> Node? {
    // Determine the length of each linked list
    let m = a?.length ?? 0
    let n = b?.length ?? 0

    // Initialize pointers to the head of each list
    var curA = a
    var curB = b

    // Advance the pointer for the longer list by the difference in lengths
    if m > n {
        var steps = m - n
        repeat {
            curA = curA?.next
            steps -= 1
        } while steps > 0
    } else {
        var steps = m - n
        repeat {
            curB = curB?.next
            steps -= 1
        } while steps > 0

    }

    // Iterate through both lists in parallel, comparing the nodes at each step
    while curA !== curB {
        curA = curA?.next
        if curA === curB {
            return curA
        }
        curB = curB?.next
    }

    // Return the node where the pointers intersect
    return curA
}

import XCTest

final class Day20: XCTestCase {
    func test_intersectionAtBeginning() {
        let intersectingNode = Node(2, next: Node(3))
        let a = Node(1, next: intersectingNode)
        let b = intersectingNode
        XCTAssertEqual(intersection(a, b)?.val, 2)
    }

    func test_intersectionAtEnd() {
        let intersectingNode = Node(3)
        let a = Node(1, next: Node(2, next: intersectingNode))
        let b = Node(4, next: Node(5, next: intersectingNode))
        XCTAssertEqual(intersection(a, b)?.val, 3)
    }

    func test_noIntersection() {
        let a = Node(1, next: Node(2, next: Node(3)))
        let b = Node(4, next: Node(5, next: Node(6)))
        XCTAssertNil(intersection(a, b)?.val)
    }
}
