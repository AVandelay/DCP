fun main() {
    println(largestSum(listOf(2, 4, 6, 2, 5)) == 13)
    println(largestSum(listOf(5, 1, 1, 5)) == 10)
}

fun largestSum(numbers: List<Int>): Int {
    if (numbers.isEmpty()) return 0
    if (numbers.size == 1) return numbers[0]
    
    var prevMax = numbers[0]
    var currMax = maxOf(numbers[0], numbers[1])
    for (i in 2 until numbers.size) {
        val temp = currMax
        currMax = maxOf(currMax, prevMax + numbers[i])
        prevMax = temp
    }
    
    return currMax
}