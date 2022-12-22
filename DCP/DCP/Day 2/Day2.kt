fun main() {
    println(productArray(listOf(1, 2, 3, 4, 5)) == listOf(120, 60, 40, 30, 24))
    println(productArray(listOf(3, 2, 1)) == listOf(2, 3, 6))
}

fun productArray(numbers: List<Int>): List<Int> {
    val prefixProducts = numbers.foldIndexed(MutableList(numbers.size) { 1 }) { i, acc, x ->
        acc[i] = if (i == 0) x else acc[i - 1] * x
        acc
    } 
    
    val suffixProducts = numbers.foldRightIndexed(MutableList(numbers.size) { 1 }) { i, x, acc ->
        acc[i] = if (i == numbers.lastIndex) x else acc[i + 1] * x
        acc
    }
    
    return numbers.foldIndexed(MutableList(numbers.size) { 1 }) { i, acc, _ ->
        acc[i] = if (i == 0) {
            suffixProducts[i + 1] 
        } else if (i == numbers.lastIndex) {
            prefixProducts[i - 1]
        } else {
            prefixProducts[i - 1] * suffixProducts[i + 1]
        }
        acc
    }
}