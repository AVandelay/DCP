fun main() {
    val root1 = TreeNode(1)
    root1.right = TreeNode(2)
    root1.right?.left = TreeNode(3)
    println(preorderTraversal(root1) == listOf(1, 2, 3))
    
    println(preorderTraversal(null).isEmpty())
    
    val root2 = TreeNode(1)
    println(preorderTraversal(root2) == listOf(1))
}

class TreeNode(var `val`: Int) {
    var left: TreeNode? = null
    var right: TreeNode? = null
}

fun preorderTraversal(root: TreeNode?): List<Int> {
    if (root == null) {
        return emptyList()
    }
    
    // visit the root node
    val preorder = mutableListOf(root.`val`)
    // visit the left subtree
    preorder.addAll(preorderTraversal(root.left))
    // visit the right subtree
    preorder.addAll(preorderTraversal(root.right))
    
    return preorder
}