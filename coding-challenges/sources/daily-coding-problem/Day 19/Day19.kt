fun main() {
    // Test 1
    val matrix1 = arrayOf(
        intArrayOf(1, 2, 3),
        intArrayOf(4, 5, 6),
        intArrayOf(7, 8, 9)
    )
    val expected1 = 13
    val result1 = buildHouses(matrix1)
    println(result1 == expected1)

    // Test 2
    val matrix2 = arrayOf(
        intArrayOf(10, 11, 12),
        intArrayOf(13, 14, 15),
        intArrayOf(16, 17, 18)
    )
    val expected2 = 40
    val result2 = buildHouses(matrix2)
    println(result1 == expected1)

    // Test 3
    val matrix3 = arrayOf(
        intArrayOf(1, 2, 3),
        intArrayOf(4, 5, 6)
    )
    val expected3 = 6
    val result3 = buildHouses(matrix3)
    println(result3 == expected3)

    // Test 4
    val matrix4 = arrayOf(intArrayOf(1, 2, 3))
    val expected4 = 1
    val result4 = buildHouses(matrix4)
    println(result4 == expected4)
}

fun buildHouses(matrix: Array<IntArray>): Int {
    var lowestCost: Int = 0
    var lowestCostIndex: Int = -1
    var secondLowestCost: Int = 0
    
    for (row in matrix) {
        var newLowestCost: Int = Int.MAX_VALUE
        var newLowestCostIndex: Int = -1
        var newSecondLowestCost: Int = Int.MAX_VALUE
        
        for ((c, value) in row.withIndex()) {
            val prevLowestCost: Int = if (c == lowestCostIndex) secondLowestCost else lowestCost
            val cost: Int = prevLowestCost + value
            if (cost < newLowestCost) {
                newSecondLowestCost = newLowestCost
                newLowestCost = cost
                newLowestCostIndex = c
            } else if (cost < newSecondLowestCost) {
                newSecondLowestCost = cost
            }
        }
        
        lowestCost = newLowestCost
        lowestCostIndex = newLowestCostIndex
        secondLowestCost = newSecondLowestCost
    }
    
    return lowestCost
}


