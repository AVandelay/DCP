fun main() {
    test()
}

class TreeNode(var `val`: Int) {
    var left: TreeNode? = null
    var right: TreeNode? = null
}



fun findLeaves(root: TreeNode?): List<List<Int>> {
    // list to store the leaf nodes at each level of the tree
    val leaves = mutableListOf<MutableList<Int>>()
    
    // recursive function to calculate the height of the tree
    fun getHeight(root: TreeNode?): Int {
        // return 0 for null nodes
        if (root == null) {
            return 0
        }
        
        // calculate the height of the left and right children
        val leftHeight = getHeight(root.left)
        val rightHeight = getHeight(root.right)
        
        // the current height is the maximum of the left and right heights plus 1
        val currentHeight = maxOf(leftHeight, rightHeight) + 1
        
        // if the list of leaves does not have enough elements, add a new list
        if (leaves.size == currentHeight - 1) {
            leaves.add(mutableListOf(root.`val`))
        } else {
            // otherwise, add the current node to the existing list
            leaves[currentHeight - 1].add(root.`val`)
        }
        
        return currentHeight
    }
    
    // start the recursive function
    getHeight(root)
    return leaves
}

fun test() {
    val testCases: List<Pair<TreeNode, List<List<Int>>>> = listOf(
        Pair(TreeNode(1).apply {
            left = TreeNode(2).apply {
                left = TreeNode(4)
                right = TreeNode(5)
            }
            right = TreeNode(3)
        }, listOf(listOf(4,5,3), listOf(2), listOf(1))),
        Pair(TreeNode(1), listOf(listOf(1)))
    )
    
    for ((root, leaves) in testCases) {
        println(findLeaves(root) == leaves)
    }
}
