

/**
 A class representing a locking binary tree node.

 A node can be locked or unlocked only if all of its descendants or ancestors are not locked.

 - Note: This class is designed to be used in a single-threaded program, so there is no need for actual locks or mutexes.

 - Properties:
    - value: The value stored in the node.
    - left: The left child of the node.
    - right: The right child of the node.
    - parent: The parent of the node.
    - isLocked:  A Boolean value indicating whether the node is locked.

 - Methods:
    - lock: Attempts to lock the node. Return `true` if the node was successfully locked, `false` if the node could not be locked.
    - unlock: Attempts to unlock the node. Returns `true` if the node was successfully unlocked `false` if the node could not be unlocked

 The node can only be locked if all of its descendants and ancestors are not locked. Each method runs in O(h), where h is the height of the tree.
*/
fileprivate final class LockingBinaryTreeNode<Value> {

    // MARK: Public Properties

    /// The value stored in the node
    var value: Value
    /// The left child of the node
    var left: LockingBinaryTreeNode?
    /// The right child of the node
    var right: LockingBinaryTreeNode?
    /// The parent of the node
    weak var parent: LockingBinaryTreeNode?
    /// Indicates whether the node is currently locked.
    var isLocked = false

    // MARK: - Private Properties

    private var lockedDescendantsCount = 0
    private var isLockable: Bool {
        guard lockedDescendantsCount == 0 else { return false }

        var node = parent
        while let n = node {
            guard !n.isLocked else { return false }

            node = n.parent
        }
        return true
    }

    /**
     Creates a locking binary tree node.

     - Parameters:
         - value: The value stored in the node.
         - left: The left child of the node.
         - right: The right child of the node.
         - parent: The parent of the node.
     */
    init(
        value: Value,
        left: LockingBinaryTreeNode? = nil,
        right: LockingBinaryTreeNode? = nil,
        parent: LockingBinaryTreeNode? = nil
    ) {
        self.value = value
        self.left = left
        self.right = right
        self.parent = parent
    }

    // MARK: Public Methods

    /**
     Attempts to lock the node.
     - Returns: `true` if the node was successfully locked, `false` otherwise.
     */
    func lock() -> Bool {
        guard !isLocked, isLockable else { return isLocked }

        isLocked = true

        var node = parent
        while let n = node {
            n.lockedDescendantsCount += 1
            node = n.parent
        }

        return true
    }

    /**
     Attempts to unlock the node.
     - Returns: `true` if the node was successfully unlocked, `false` otherwise.
     */
    func unlock() -> Bool {
        guard isLocked, isLockable else { return false }

        isLocked = false

        var node = parent
        while let n = node {
            n.lockedDescendantsCount -= 1
            node = n.parent
        }

        return true
    }
}

import XCTest

final class Day24: XCTestCase {
    func testLocking() {
        let root = LockingBinaryTreeNode(value: 0)
        let left = LockingBinaryTreeNode(value: 1, parent: root)
        let right = LockingBinaryTreeNode(value: 2, parent: root)
        root.left = left
        root.right = right

        XCTAssertTrue(root.lock())
        XCTAssertTrue(root.isLocked)
        XCTAssertTrue(root.unlock())
        XCTAssertFalse(root.isLocked)

        XCTAssertTrue(left.lock())
        XCTAssertTrue(left.isLocked)
        XCTAssertTrue(left.unlock())
        XCTAssertFalse(left.isLocked)

        XCTAssertTrue(right.lock())
        XCTAssertTrue(right.isLocked)
        XCTAssertTrue(right.unlock())
        XCTAssertFalse(right.isLocked)
    }
}
