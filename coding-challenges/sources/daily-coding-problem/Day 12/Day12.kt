fun main() {
    println(climbStaircase(4) == 5)
}

fun climbStaircase(steps: Int): Int {
    if (steps < 2) return 1
    
    var ways = IntArray(steps + 1) { 1 }
    for (i in 2 until ways.size) {
        ways[i] = ways[i - 1] + ways[i - 2]
    }
    return ways[steps]
}