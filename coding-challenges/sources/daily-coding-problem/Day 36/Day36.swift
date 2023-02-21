

fileprivate class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?

    init(_ val: Int) {
        self.val = val
    }
}

/// Finds the second largest node in a binary search tree.
///
/// - Parameter root: The root node of the binary search tree.
/// - Returns: The value of the second largest node in the tree, or nil if it doesn't exist.
fileprivate func findSecondLargest(_ root: TreeNode?) -> Int? {
    // Initialize count and val variables to keep track of the current node count and the value of the second largest node, respectively.
    var count = 0
    var val: Int?

    // Declare an implicitly unwrapped optional closure inorder, which takes a TreeNode? parameter and returns Void.
    // We use an implicitly unwrapped optional so we can reference the closure before it is declared.
    var inorder: ((TreeNode?) -> Void)!

    // Define the implementation of the closure.
    inorder = { node in
        // If the node is nil or we've already visited two nodes, return.
        guard let node = node, count < 2 else {
            return
        }

        // Traverse the right subtree first, if it exists.
        if let right = node.right {
            inorder(right)
        }

        // Increment the node count and check if we've visited two nodes yet.
        count += 1
        if count == 2 {
            // If we've visited two nodes, set the value of the second largest node and return.
            val = node.val
            return
        }

        // Traverse the left subtree next, if it exists.
        if let left = node.left {
            inorder(left)
        }
    }

    // Call the inorder closure with the root node to start the traversal.
    inorder(root)

    // Return the value of the second largest node, or nil if it doesn't exist.
    return val
}


import XCTest

final class Day36: XCTestCase {

    func testSingleNodeTree() {
        let root = TreeNode(5)
        let result = findSecondLargest(root)
        XCTAssertNil(result)
    }

    func testTwoNodeTree() {
        let root = TreeNode(5)
        root.left = TreeNode(3)
        let result = findSecondLargest(root)
        XCTAssertEqual(result, 3)
    }

    func testThreeNodeTree() {
        let root = TreeNode(5)
        root.left = TreeNode(3)
        root.right = TreeNode(8)
        let result = findSecondLargest(root)
        XCTAssertEqual(result, 5)
    }

    func testUnbalancedTree() {
        let root = TreeNode(5)
        root.right = TreeNode(7)
        root.right?.left = TreeNode(6)
        let result = findSecondLargest(root)
        XCTAssertEqual(result, 6)
    }
}



