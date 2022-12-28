fun main() {
    println(estimatePi(100000))
}

fun estimatePi(iterations: Int): Double {
    val radius = 1.0
    val circleX = 0.5
    val circleY = 0.5
    val radiusSquared = radius * radius
    
    var inside = 0
    for (i in 0 until iterations) {
        val x = Math.random()
        val y = Math.random()
        val distanceSquared = (x - circleX) * (x - circleX) + (y - circleY) * (y - circleY)
        if (distanceSquared < radiusSquared) {
            inside++
        }
    }
    
    val fractionInside = inside.toDouble() / iterations.toDouble()
    return 4.0 * fractionInside
}