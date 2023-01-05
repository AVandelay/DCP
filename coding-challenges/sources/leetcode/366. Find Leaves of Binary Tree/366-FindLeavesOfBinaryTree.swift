

fileprivate class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init() { self.val = 0; self.left = nil; self.right = nil; }
    init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

fileprivate func findLeaves(_ root: TreeNode?) -> [[Int]] {
    var leaves = [[Int]]()

    // recursive function to calculate the height of the tree
    @discardableResult
    func getHeight(_ root: TreeNode? = root) -> Int {
        // return 0 for null nodes
        guard let node = root else { return 0 }

        // calculate the height of the left and right children
        let leftHeight = getHeight(node.left)
        let rightHeight = getHeight(node.right)

        // the current height is the maximum of the left and right heights plus root
        let currentHeight = max(leftHeight, rightHeight) + 1

        // if the list of leaves does not have enough elements, add a new list
        if leaves.count == currentHeight - 1 {
            leaves.append([node.val])
        } else {
            // otherwise, add the current node to the existing list
            leaves[currentHeight - 1].append(node.val)
        }

        return currentHeight
    }

    getHeight()
    return leaves
}


import XCTest

final class FindLeavesOfBinaryTreeTests: XCTestCase {
    func test() {
        let testCases: [(root: TreeNode, leaves: [[Int]])] = [
            (TreeNode(1, TreeNode(2, TreeNode(4), TreeNode(5)), TreeNode(3)), [[4,5,3],[2],[1]]),
            (TreeNode(1), [[1]])
        ]

        for (root, leaves) in testCases {
            XCTAssertEqual(findLeaves(root), leaves)
        }
    }
}
