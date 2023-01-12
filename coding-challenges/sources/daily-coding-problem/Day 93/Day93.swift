

fileprivate class TreeNode {
    var value: Int
    var left: TreeNode?
    var right: TreeNode?

    init(_ value: Int) {
        self.value = value
    }
}

/**
 *  Finds the largest BST in a given tree by traversing the tree recursively
 *
 *  - Parameter root: The root of the tree
 *  - Returns: The size of the largest BST
 *  - Complexity: O(n)
 *
 *  The function uses a helper function dfs to traverse the tree recursively and check for BST.
 *  It also uses a struct Subtree to store the maxValue, minValue, and count for a subtree.
 *  It returns the count of the largest BST
 *
 */
fileprivate func largestBST(root: TreeNode?) -> Int {
    struct Subtree {
        /// The minimum value in the current subtree
        let minValue: Int
        /// The maximum value in the current subtree
        let maxValue: Int
        /// The size of the largest BST in the current subtree
        let size: Int
    }

    /**
     *  helper function dfs to traverse the tree recursively
     *  - Parameter node: The current node of the tree
     *  - Returns: The Subtree struct for the current subtree
     *
     *  The function first traverses the left and right subtree recursively
     *  Then it checks if the current node is greater than maxValue of the left subtree
     *  and less than minValue of the right subtree. If it is, the current node is part of
     *  the largest BST. The function returns minValue, maxValue, and count of the subtree
     *  Otherwise, it returns the result for the subtree with the max count
     */
    func dfs(_ node: TreeNode?) -> Subtree {
        guard let node else { return Subtree(minValue: Int.max, maxValue: Int.min, size: 0) }

        let left = dfs(node.left)
        let right = dfs(node.right)
        if node.value > left.maxValue,
           node.value < right.minValue {
            return Subtree(
                minValue: min(left.minValue, node.value),
                maxValue: max(right.maxValue, node.value),
                size: 1 + left.size + right.size)
        } else {
            return Subtree(
                minValue: Int.min,
                maxValue: Int.max,
                size: max(left.size, right.size))
        }
    }

    return dfs(root).size
}

import XCTest

final class Day93: XCTestCase {
    func testLargestBST() {
        var expectation = 3
        var root = TreeNode(10)
        root.left = TreeNode(5)
        root.right = TreeNode(15)
        root.left?.left = TreeNode(1)
        root.left?.right = TreeNode(8)
        root.right?.right = TreeNode(7)
        XCTAssertEqual(largestBST(root: root), expectation)

        expectation = 2
        root = TreeNode(4)
        root.left = TreeNode(2)
        root.right = TreeNode(7)
        root.left?.left = TreeNode(2)
        root.left?.right = TreeNode(3)
        root.right?.left = TreeNode(5)
        root.left?.left?.left = TreeNode(2)
        root.left?.left?.left?.right = TreeNode(1)
        XCTAssertEqual(largestBST(root: root), expectation)
    }
}
