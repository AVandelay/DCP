

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

fileprivate func postorderTraversal(root: TreeNode?) -> [Int] {
    // base case: if the root is `nil`, return an empty array
    guard let node = root else { return [] }

    var postorder = [Int]()

    // visit the left subtree
    postorder += postorderTraversal(root: node.left)
    // visit the right subtree
    postorder += postorderTraversal(root: node.right)
    // visit the root node
    postorder.append(node.val)

    return postorder
}

import XCTest

final class PostorderTraversalTests: XCTestCase {
    func test() {
        let root1 = TreeNode(1)
        root1.right = TreeNode(2)
        root1.right?.left = TreeNode(3)
        XCTAssertEqual(postorderTraversal(root: root1), [3,2,1])

        XCTAssertEqual(postorderTraversal(root: nil), [])

        let root2 = TreeNode(1)
        XCTAssertEqual(postorderTraversal(root: root2), [1])
    }
}
