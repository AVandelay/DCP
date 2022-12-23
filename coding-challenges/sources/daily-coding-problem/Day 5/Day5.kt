fun main() {
    val pair = cons(3, 4)
    println(car(pair) == 3)
    println(cdr(pair) == 4)
}

fun <A, B> cons(a: A, b: B): () -> Pair<A, B> {
    return { Pair(a, b) }
}

fun <A, B> car(pair: () -> Pair<A, B>): A {
    val (a, _) = pair()
    return a
}

fun <A, B> cdr(pair: () -> Pair<A, B>): B {
    val (_, b) = pair()
    return b
}