fun main() {
    testMaxOfSubarrays()
}

fun maxOfSubarrays(arr: List<Int>, k: Int) {
    // Initialize deque to store the indices of the elements in the window
    val dq = ArrayDeque<Int>()
    for ((i, element) in arr.withIndex()) {
        // Remove elements from the deque that are outside the current window
        while (dq.isNotEmpty() && dq.first() <= i - k) {
            dq.removeFirst()
        }
        // Remove elements from the deque that are smaller than the current element
        while (dq.isNotEmpty() && element >= arr[dq.last()]) {
            dq.removeLast()
        }
        // Add the current element to the deque
        dq.addLast(i)
        
        // If we have processed at leasst k elements, print the maximum element in the window
        if (i >= k - 1) {
            print("${arr[dq.first()]} ")
        }
    }
    println()
}

fun testMaxOfSubarrays() {
    val arr1 = listOf(10, 5, 2, 7, 8, 7)
    val k1 = 3
    // expected output: 10 7 8 8
    maxOfSubarrays(arr1, k1)
    
    val arr2 = listOf(1, 2, 3, 4, 5, 6)
    val k2 = 4
    // expected output: 4 5 6
    maxOfSubarrays(arr2, k2)
    
    val arr3 = listOf(6, 5, 4, 3, 2, 1)
    val k3 = 2
    // expected output: 6 5 4 3 2
    maxOfSubarrays(arr3, k3)
    
    val arr4 = listOf(1)
    val k4 = 1
    // expected output: 1
    maxOfSubarrays(arr4, k4)
    
    val arr5 = listOf(1, 2, 3, 4, 5, 6)
    val k5 = 6
    // expected output: 6
    maxOfSubarrays(arr5, k5)
}
