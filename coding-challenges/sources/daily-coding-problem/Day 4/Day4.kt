fun main() {
    println(findFirstMissingPositive(intArrayOf(3, 4, -1, 1)) == 2)
    println(findFirstMissingPositive(intArrayOf(1, 2, 0) == 3))
}

fun findFirstMissingPositive(numbers: IntArray): Int {
    val set = HashSet<Int>()
    for (number in numbers) {
        if (number > 0) {
            set.add(number)
        }
    }
    
    var i = 1
    while (set.contains(i)) {
        i++
    }
    
    return i
}