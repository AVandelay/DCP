fun main() {
    val log = OrderLog(3)
    
    for (i in 1..4) {
        log.record(i)
    }
    
    println(log.getLast(1) == 4)
    println(log.getLast(2) == 3)
    println(log.getLast(3) == 2)
}

class OrderLog(val n: Int) {
    // Circular buffer to store the order IDs
    private val orders = IntArray(n)
    // Index of the first element in the buffer
    private var start = 0
    // Index of the next element to be added to the buffer
    private var end = 0
    
    // Adds an order ID to the log.
    fun record(orderId: Int) {
        // Add the order ID to the end of the buffer.
        orders[end] = orderId
        // Update the end index.
        end = (end + 1) % n
        // If the buffer is full, remove the oldest element
        if (end == start) {
            start = (start + 1) % n
        }
    }
    
    // Returns the ith last element from the log
    fun getLast(i: Int): Int {
        // Compute the index of the element in the buffer.
        return orders[(end - i + n) % n]
    }
}