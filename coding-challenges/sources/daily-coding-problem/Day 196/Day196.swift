

fileprivate class TreeNode {
    var value: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ value: Int) {
        self.value = value
    }
}

/**
 *  Given the root of a binary tree, finds the most frequent subtree sum.
 *  The subtree sum of a node is the sum of all values under a node,
 *  including the node itself.
 *
 *  - Parameter root: the root of the binary tree
 *  - Returns: the most frequent subtree sum
 *  - Complexity: O(n) where n is the number of nodes in the tree
 *
 *  The function uses a post-order traversal dfs helper function. It uses
 *  a dictionary to store the frequency of each subtree sum found in the tree.
 *  As the function traverses the tree, it recursively computes the sum of subtrees.
 *  The function uses `max(by:)` to iterate over the dictionary entries by passing a closure
 *  `{$0.value < $1.value}` compares the frequency of subtrees, returns the one
 *  with the higher count. This can also be accomplished with the following block
 *  ```
 *  var maxCount = 0
 *  var frequentSum = 0
 *  for (key, value) in frequencies {
 *      if value > maxCount {
 *          maxCount = value
 *          frequentSum = key
 *      }
 *  }
 *  return frequentSum
 *  ```
 */
fileprivate func findFrequentTreeSum(_ root: TreeNode?) -> Int {
    // Create a dictionary to store the frequency of each subtree sum
    var frequencies = [Int: Int]()

    @discardableResult
    func dfs(_ node: TreeNode? = root) -> Int {
        guard let node else { return 0 }
        let leftSum = dfs(node.left)
        let rightSum = dfs(node.right)
        let subtreeSum = node.value + leftSum + rightSum
        // update the frequency of the subtree sum
        frequencies[subtreeSum, default: 0] += 1
        return subtreeSum
    }

    dfs()
    return frequencies.max(by: { $0.value < $1.value })?.key ?? 0
}

import XCTest

final class Day196: XCTestCase {
    func test() {
        let root = TreeNode(5)
        root.left = TreeNode(2)
        root.right = TreeNode(-5)
        XCTAssertEqual(findFrequentTreeSum(root), 2)
    }
}
