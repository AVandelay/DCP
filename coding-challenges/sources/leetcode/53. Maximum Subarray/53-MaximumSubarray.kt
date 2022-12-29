fun main() {
    println(maxSubarray(intArrayOf(-2,1,-3,4,-1,2,1,-5,4)) == 6)
    println(maxSubarray(intArrayOf(1)) == 1)
    println(maxSubarray(intArrayOf(5,4,-1,7,8)) == 23)
}

fun maxSubarray(nums: IntArray): Int {
    if (nums.isEmpty()) return 0
    if (nums.size == 1) return nums.first()
    
    var currentMax = nums.first()
    var globalMax = currentMax
    for (num in nums.drop(1)) {
        currentMax = maxOf(num, currentMax + num)
        globalMax = maxOf(globalMax, currentMax)
    }
    return globalMax
}