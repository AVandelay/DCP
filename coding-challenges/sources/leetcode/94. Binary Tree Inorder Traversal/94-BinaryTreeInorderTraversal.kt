fun main() {
    val root1 = TreeNode(1)
    root1.right = TreeNode(2)
    root1.right?.left = TreeNode(3)
    println(inorderTraversal(root1) == listOf(1, 3, 2))
    
    println(inorderTraversal(null).isEmpty())
    
    val root2 = TreeNode(1)
    println(inorderTraversal(root2) == listOf(1))
}

class TreeNode(var `val`: Int) {
    var left: TreeNode? = null
    var right: TreeNode? = null
}

fun inorderTraversal(root: TreeNode?): List<Int> {
    if (root == null) {
        return emptyList()
    }
    
    val inorder = ArrayList<Int>()
    
    // visit the left subtree
    inorder.addAll(inorderTraversal(root.left))
    // visit the root node
    inorder.add(root.`val`)
    // visit the right subtree
    inorder.addAll(inorderTraversal(root.right))
    
    return inorder
}