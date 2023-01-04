

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

fileprivate func inorderTraversal(root: TreeNode?) -> [Int] {
    // base case: if the root is `nil`, return an empty array
    guard let node = root else { return [] }

    var inorder = [Int]()

    // visit the left subtree
    inorder += inorderTraversal(root: node.left)
    // visit the root node
    inorder.append(node.val)
    // visit the right subtree
    inorder += inorderTraversal(root: node.right)

    return inorder
}

import XCTest

final class InorderTraversalTests: XCTestCase {
    func test() {
        let root1 = TreeNode(1)
        root1.right = TreeNode(2)
        root1.right?.left = TreeNode(3)
        XCTAssertEqual(inorderTraversal(root: root1), [1,3,2])

        XCTAssertEqual(inorderTraversal(root: nil), [])

        let root2 = TreeNode(1)
        XCTAssertEqual(inorderTraversal(root: root2), [1])
    }
}
