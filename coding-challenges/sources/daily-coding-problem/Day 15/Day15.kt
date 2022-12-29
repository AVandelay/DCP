import java.util.Random

fun main() {
    val stream = sequenceOf(1, 2, 3, 4, 5)
    val randomElement = pickRandomElement(stream)
    println(stream.contains(randomElement))
}

fun pickRandomElement(stream: Sequence<Any>): Any? {
    var reservoir: Any? = stream.first() // initialize the reservoir to be the first element in the stream
    var n = 1 // initialize the count of elements seen to 1
    for(x in stream) {
        n += 1
        val p = Random().nextDouble() // generate a random number between 0 and 1
        if (p <= 1.0 / n) { // with probability 1/n, set reservoir to x
            reservoir = x
        }
    }
    
    return reservoir
}