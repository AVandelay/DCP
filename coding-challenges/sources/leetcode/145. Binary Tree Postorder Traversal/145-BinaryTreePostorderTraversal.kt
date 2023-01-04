fun main() {
    val root1 = TreeNode(1)
    root1.right = TreeNode(2)
    root1.right?.left = TreeNode(3)
    println(postorderTraversal(root1) == listOf(3, 2, 1))
    
    println(postorderTraversal(null).isEmpty())
    
    val root2 = TreeNode(1)
    println(postorderTraversal(root2) == listOf(1))
}

class TreeNode(var `val`: Int) {
    var left: TreeNode? = null
    var right: TreeNode? = null
}

fun postorderTraversal(root: TreeNode?): List<Int> {
    if (root == null) {
        return emptyList()
    }
    
    val postorder = ArrayList<Int>()
    
    // visit the left subtree
    postorder.addAll(postorderTraversal(root.left))
    // visit the right subtree
    postorder.addAll(postorderTraversal(root.right))
    // visit the root node
    postorder.add(root.`val`)
    
    return postorder
}