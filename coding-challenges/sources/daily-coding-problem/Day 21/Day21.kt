import java.util.PriorityQueue

fun main() {
    test()
}

fun minimumRooms(intervals: List<Pair<Int, Int>>): Int {
    // Sort the intervals by their start time
    val sortedIntervals = intervals.sortedBy { it.first }
    
    // Initialize a priority queue to track the end times of the intervals in each room
    val rooms = PriorityQueue<Int>()
    
    // Iterate through the sorted intervals
    for (interval in sortedIntervals) {
        // If the earliest end time is before the start time of the current interval,
        // remove it from the priority queue and add the end time of the current interval
        if (rooms.isNotEmpty() && rooms.peek() <= interval.first) {
            rooms.poll()
        }
        // Add the end time of the current interval to the priority queue
        rooms.add(interval.second)
    }
    
    // Return the number of rooms in the priority queue
    return rooms.size
}

fun test() {
    val testCases = listOf(
        Pair(listOf(Pair(30, 75), Pair(0, 50), Pair(60, 150)), 2),
        Pair(listOf(Pair(0, 10), Pair(10, 20)), 1),
        Pair(listOf(Pair(0, 10), Pair(5, 15), Pair(5, 20)), 3)
    )
    
    for ((intervals, expected) in testCases) {
        println(minimumRooms(intervals) == expected)
    }
}