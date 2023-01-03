

fileprivate class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?

    init() {
        self.val = 0
        self.left = nil
        self.right = nil
    }

    init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }

    init(_ val: Int,
         _ left: TreeNode?,
         _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
 }

fileprivate func preorderTraversal(root: TreeNode?) -> [Int] {
    // base case: if the root is `nil`, return an empty array
    guard let node = root else { return [] }

    // visit the root node
    var preorder = [node.val]
    // visit the left subtree
    preorder += preorderTraversal(root: node.left)
    // visit the right subtree
    preorder += preorderTraversal(root: node.right)

    return preorder
}

import XCTest

final class PreorderTraversalTests: XCTestCase {
    func test() {
        let root1 = TreeNode(1)
        root1.right = TreeNode(2)
        root1.right?.left = TreeNode(3)
        XCTAssertEqual(preorderTraversal(root: root1), [1,2,3])

        XCTAssertEqual(preorderTraversal(root: nil), [])

        let root2 = TreeNode(1)
        XCTAssertEqual(preorderTraversal(root: root2), [1])
    }
}
