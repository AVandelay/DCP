fun main() {
    test()
}

fun nextGreaterElement(nums1: IntArray, nums2: IntArray): IntArray {
    val nextGreaterMap = HashMap<Int, Int>()
    val elementStack = mutableListOf<Int>()

    for (element in nums2) {
        while (elementStack.isNotEmpty() && elementStack.last() < element) {
            val smallerElement = elementStack.removeAt(elementStack.lastIndex)
            nextGreaterMap[smallerElement] = element
        }

        elementStack.add(element)
    }

    for (element in elementStack) {
        nextGreaterMap[element] = -1
    }

    val result = IntArray(nums1.size)
    for (i in nums1.indices) {
        result[i] = nextGreaterMap.getOrDefault(nums1[i], -1)
    }
    return result
}

fun test() {
    val testCases = listOf(
        Triple(intArrayOf(4, 1, 2), intArrayOf(1, 3, 4, 2), intArrayOf(-1, 3, -1)),
        Triple(intArrayOf(2, 4), intArrayOf(1, 2, 3, 4), intArrayOf(3, -1))
    )
    
    for ((nums1, nums2, expectation) in testCases) {
        val actualString = nextGreaterElement(nums1, nums2).joinToString(prefix = "actual: intArrayOf(", postfix = ")")
        val expectationString = expectation.joinToString(prefix = "expectation: intArrayOf(", postfix = ")")
        println("$actualString  $expectationString")
    }
}