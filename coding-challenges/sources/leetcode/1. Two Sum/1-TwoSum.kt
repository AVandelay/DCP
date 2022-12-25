fun main() {
    println(twoSum(listOf(2,7,11,15), 9))
}

fun twoSum(nums: List<Int>, target: Int): IntArray {
    var map = mutableMapOf<Int, Int>()
    for ((i, x) in nums.withIndex()) {
        val complement = target - x
        if (complement in map) {
            return intArrayOf(map[complement]!!, i)
        }
        
        map[x] = i 
    }
    throw IllegalArgumentException("No two sum solution")
}