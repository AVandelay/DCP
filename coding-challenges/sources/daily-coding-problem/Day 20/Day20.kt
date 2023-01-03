fun main(args: Array<String>) {
    findIntersectionTests()
}

class Node(val value: Int, var next: Node? = null)

fun Node?.length(): Int {
    // Return 0 if the list is empty
    if (this == null) {
        return 0
    }
    // Return 1 plus the length of the rest of the list
    return 1 + (this.next?.length() ?: 0)
}


fun findIntersection(a: Node? , b: Node?): Node? {
    // Determine the lenght of the each linked list
    val m = a?.length() ?: 0
    val n = b?.length() ?: 0
    
    // Pointers to the head of each list
    var curA = a
    var curB = b
    
    // Advaince the pointer for the longer list by the difference in lengths
    if (m > n) {
        repeat(m - n) {
            curA = curA?.next
        }
    } else {
        repeat(n - m) {
            curB = curB?.next
        }
    }
    
    // Iterate through both lists in parallel, comparing the nodes at each step
    while (curA !== curB) {
        curA = curA?.next
        if (curA == curB) return curA
        curB = curB?.next
    }
    
    return curA
}

fun findIntersectionTests() {
    fun testIntersectionAtBeginning() {
        val intersectingNode = Node(2, Node(3))
        val a = Node(1, intersectingNode)
        val b = intersectingNode
        println(findIntersection(a, b) == intersectingNode)
    }
    
    fun testIntersectionAtEnd() {
        val intersectingNode = Node(3)
        val a = Node(1, Node(2, intersectingNode))
        val b = Node(4, Node(5, intersectingNode))
        println(findIntersection(a, b) == intersectingNode)
    }
    
    fun testNoIntersection() {
        val a = Node(1, Node(2, Node(3)))
        val b = Node(4, Node(5, Node(6)))
        println(findIntersection(a, b) == null)
    }
    
    testIntersectionAtBeginning()
    testIntersectionAtEnd()
    testNoIntersection()
}
