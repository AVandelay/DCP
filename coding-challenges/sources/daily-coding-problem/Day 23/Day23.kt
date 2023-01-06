import java.util.Queue
import java.util.LinkedList

fun main() {
    test()
}

data class Coordinate(val x: Int, val y: Int)

/**
 * Finds the minimum number of steps required to reach the end coordinate from the start coordinate in a matrix of booleans representing a board.
 *
 * Each True boolean represents a wall. Each False boolean represents a tile that can be walked on.
 *
 * @param board A 2D array of booleans representing the board.
 * @param start The start coordinate.
 * @param end The end coordinate.
 *
 * @return The minimum number of steps required to reach the end coordinate from the start, or null if there is no possible path.
 */
fun shortestPath(board: Array<BooleanArray>, start: Coordinate, end: Coordinate): Int? {
    // Edge cases: start or end coordinate is out of bounds, or start or end coordinate is a wall
    if (!isValidCoordinate(board, coordinate = start) || 
        !isValidCoordinate(board, coordinate = end) ||
        isWall(board, coordinate = start) || 
        isWall(board, coordinate = end)) {
            return null
        }
    
    // Initialize a queue for storing the unexplored coordinates
    val queue: Queue<Coordinate> = LinkedList()
    queue.add(start)
    
    // Initialize a dictionary to store the number of steps required to reach each coordinate
    val distances: MutableMap<Coordinate, Int> = mutableMapOf(start to 0)
    
    // Initialize a set for storing the visited coordinates
    val visited: MutableSet<Coordinate> = mutableSetOf()
    
    val directions = listOf(
        Coordinate(-1, 0),
        Coordinate(1, 0), 
        Coordinate(0, -1), 
        Coordinate(0, 1)
    )
    
    while (queue.isNotEmpty()) {
        val current = queue.peek()
        // Check if we have reached the end coordinate
        if (current == end) {
            return distances[end]
        }
        // Mark the current coordinate as visited
        visited.add(queue.poll())
        // Explore all the neighbors of the current coordinate
        for (direction in directions) {
            val neighbor = Coordinate(current.x + direction.x, current.y + direction.y)
            // Skip the neighbor if it is not a valid coordinate or has already been visited
            if (!isValidCoordinate(board, coordinate = neighbor) || neighbor in visited) {
                continue
            }
            // Skip the neighbor if it is a wall
            if (isWall(board, coordinate = neighbor)) {
                continue
            }
            // Update the number of steps required to reach the neighbor
            distances[neighbor] = distances[current]!! + 1
            queue.add(neighbor)
        }
    }
    
    // Return null if the end coordinate was not reached
    return null
}

/**
 * Returns whether the given coordinate is a valid coordinate on the board.
 *
 * @param board A 2D array of booleans representing the board.
 * @param coordinate The coordinate to check.
 *
 * @return True if the coordinate is a valid coordinate on the board, False otherwise.
 */
fun isValidCoordinate(board: Array<BooleanArray>, coordinate: Coordinate): Boolean {
    val rows = board.size
    val cols = board[0].size
    return coordinate.x >= 0 && coordinate.x < rows && coordinate.y >= 0 && coordinate.y < cols
}

/**
 * Returns whether the given coordinate is a wall on the board.
 *
 * @param board A 2D array of booleans representing the board.
 * @param coordinate The coordinate to check.
 *
 * @return True if the coordinate is a wall on the board, False otherwise.
 */
fun isWall(board: Array<BooleanArray>, coordinate: Coordinate): Boolean {
    return board[coordinate.x][coordinate.y]
}

fun test() {
    
    fun testShortestPath() {
        val board = arrayOf(
            booleanArrayOf(false, false, false, false),
            booleanArrayOf(true, true, false, true),
            booleanArrayOf(false, false, false, false),
            booleanArrayOf(false, false, false, false)
        )
        val start = Coordinate(3, 0)
        val end = Coordinate(0, 0)
        
        println(shortestPath(board, start, end) == 7)
    }
    
    fun testShortestPathNoPath() {
        val board = arrayOf(
            booleanArrayOf(true, true, true, true),
            booleanArrayOf(true, true, true, true),
            booleanArrayOf(true, true, true, true),
            booleanArrayOf(true, true, true, true)
        )
        val start = Coordinate(0, 0)
        val end = Coordinate(3, 3)
        
        println(shortestPath(board, start, end) == null)
    }
    
    fun testShortestPathStartIsWall() {
        val board = arrayOf(
            booleanArrayOf(true, false, false, false),
            booleanArrayOf(true, true, false, true),
            booleanArrayOf(false, false, false, false),
            booleanArrayOf(false, false, false, false)
        )
        val start = Coordinate(0, 0)
        val end = Coordinate(3, 3)
        
        println(shortestPath(board, start, end) == null)
    }
    
    fun testShortestPathEndIsWall() {
        val board = arrayOf(
            booleanArrayOf(true, false, false, false),
            booleanArrayOf(true, true, false, true),
            booleanArrayOf(false, false, false, false),
            booleanArrayOf(false, false, false, false)
        )
        val start = Coordinate(0, 0)
        val end = Coordinate(3, 3)
        
        println(shortestPath(board, start, end) == null)
    }
    
    fun testShortestPathStartOutOfBounds() {
        val board = arrayOf(
            booleanArrayOf(true, false, false, false),
            booleanArrayOf(true, true, false, true),
            booleanArrayOf(false, false, false, false),
            booleanArrayOf(false, false, false, false)
        )
        val start = Coordinate(-1, -1)
        val end = Coordinate(3, 3)
        
        println(shortestPath(board, start, end) == null)
    }
    
    fun testShortestPathEndOutOfBounds() { 
        val board = arrayOf(
            booleanArrayOf(true, false, false, false),
            booleanArrayOf(true, true, false, true),
            booleanArrayOf(false, false, false, false),
            booleanArrayOf(false, false, false, false)
        )
        val start = Coordinate(0, 0)
        val end = Coordinate(4, 4)
        
        println(shortestPath(board, start, end) == null)
    }
    
    testShortestPath()
    testShortestPathNoPath()
    testShortestPathStartIsWall()
    testShortestPathEndIsWall()
    testShortestPathStartOutOfBounds()
    testShortestPathEndOutOfBounds()
}