fun main() {
    println(threeSum(intArrayOf(-1,0,1,2,-1,-4)))
    println(threeSum(intArrayOf(0,1,1)))
}

fun threeSum(nums: IntArray): List<List<Int>> {
    if (nums.size < 3) return emptyList()
    
    val sortedNums = nums.sorted()
    
    val triplets = mutableListOf<List<Int>>()
    val tripletSet = mutableSetOf<List<Int>>()
    
    for (i in 0 until (sortedNums.size - 2)) {
        var left = i + 1
        var right = sortedNums.size - 1
        
        while (left < right) {
            val currentSum = sortedNums[i] + sortedNums[left] + sortedNums[right]
            
            when (currentSum) {
                0 -> {
                    val triplet = listOf(sortedNums[i], sortedNums[left], sortedNums[right])
                    if (!tripletSet.contains(triplet)) {
                        triplets.add(triplet)
                        tripletSet.add(triplet)
                    }
                    left++
                }
                in Int.MIN_VALUE..0 -> left++
                else -> right--
            }
        }
    }
    
    return triplets
}