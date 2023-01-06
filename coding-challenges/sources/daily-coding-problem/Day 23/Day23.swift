

/**
 Represents a coordinate on a matrix
 */
fileprivate struct Coordinate: Hashable {
    /// The x-coordinate
    let x: Int
    /// The y-coordinate
    let y: Int
}

/**
 Finds the minimum number of steps required to reach the end coordinate from the start coordinate in a matrix of booleans representing a board.

 Each True boolean represents a wall. Each False boolean represents a tile that can be walked on.

 - Parameters:
    - board: A 2D array of booleans representing the board.
    - start: The start coordinate.
    - end: The end coordinate.

 - Returns: The minimum number of steps required to reach the end coordinate from the start, or nil if there is no possible path.
 */
fileprivate func shortestPath(board: [[Bool]], start: Coordinate, end: Coordinate) -> Int? {
    // Edge cases: start or end coordinate is wall or out of bounds
    if  !isValidCoordinate(board, coordinate: start) ||
        !isValidCoordinate(board, coordinate: end) ||
        isWall(board, coordinate: start) ||
        isWall(board, coordinate: end) {
        return nil
    }

    // Queue for storing unexplored coordinates
    var queue = [start]

    // Dictionary to store the number of steps required to reach each coordinate
    var distances: [Coordinate: Int] = [start: 0]

    // Set for storing visited coordinates
    var visited = Set<Coordinate>()


    let directions: [Coordinate] = [
        Coordinate(x: -1, y: 0),
        Coordinate(x: 1, y: 0),
        Coordinate(x: 0, y: -1),
        Coordinate(x: 0, y: 1)
    ]

    while !queue.isEmpty {
        let current = queue.removeFirst()

        // Check if we have reached the end coordinate
        if current == end {
            return distances[end]
        }

        // Mark the current coordinate as visited
        visited.insert(current)

        // Explore all directions of the current coordinate
        for direction in directions {
            let neighbor = Coordinate(x: current.x + direction.x, y: current.y + direction.y)
            // Skip the neighbor if it is not a valid coordinate or has already been visited
            if !isValidCoordinate(board, coordinate: neighbor) ||
                visited.contains(neighbor) {
                continue
            }
            // Skip the neighbor if it is a wall
            if isWall(board, coordinate: neighbor) {
                continue
            }
            // Update the number of steps required to reach the neighbor
            distances[neighbor] = distances[current, default: 0] + 1
            queue.append(neighbor)
        }
    }

    // We have explored all of the reachable coordinates and have not found the end coordinate
    return nil
}

/**
 Returns whether the given coordinate is a wall on the board.

 - Parameters:
    - board: A 2D array of booleans representing the board.
    - coordinate: The coordinate to check.

 - Returns: True if the coordinate is a wall, False otherwise.
 */
fileprivate func isWall(_ board: [[Bool]], coordinate: Coordinate) -> Bool {
    board[coordinate.x][coordinate.y]
}

/**
 Returns whether the given coordinate is a valid coordinate on the board.

 - Parameters:
    - board: A 2D array of booleans representing the board.
    - coordinate: The coordinate to check.

 - Returns: True if the coordinate is a valid coordinate on the board, False otherwise.
 */
fileprivate func isValidCoordinate(_ board: [[Bool]], coordinate: Coordinate) -> Bool {
    let rows = board.count
    let cols = board[0].count
    return coordinate.x >= 0 && coordinate.x < rows && coordinate.y >= 0 && coordinate.y < cols
}

import XCTest

final class Day23: XCTestCase {
    func testShortestPath() {
        let board: [[Bool]] = [[false, false, false, false],
                               [true, true, false, true],
                               [false, false, false, false],
                               [false, false, false, false]]

        let start = Coordinate(x: 3, y: 0)
        let end = Coordinate(x: 0, y: 0)

        let steps = shortestPath(board: board, start: start, end: end)
        XCTAssertEqual(steps, 7)
    }

    func testShortestPathNoPath() {
        let board: [[Bool]] = [[true, true, true, true],
                               [true, true, true, true],
                               [true, true, true, true],
                               [true, true, true, true]]

        let start = Coordinate(x: 0, y: 0)
        let end = Coordinate(x: 3, y: 3)

        let steps = shortestPath(board: board, start: start, end: end)
        XCTAssertNil(steps)
    }

    func testShortestPathStartIsWall() {
        let board: [[Bool]] = [[true, false, false, false],
                               [true, true, false, true],
                               [false, false, false, false],
                               [false, false, false, false]]

        let start = Coordinate(x: 0, y: 0)
        let end = Coordinate(x: 3, y: 3)

        let steps = shortestPath(board: board, start: start, end: end)
        XCTAssertNil(steps)
    }

    func testShortestPathEndIsWall() {
        let board: [[Bool]] = [[false, false, false, false],
                               [true, true, false, true],
                               [false, false, false, false],
                               [false, false, false, true]]

        let start = Coordinate(x: 0, y: 0)
        let end = Coordinate(x: 3, y: 3)

        let steps = shortestPath(board: board, start: start, end: end)
        XCTAssertNil(steps)
    }

    func testShortestPathStartOutOfBounds() {
        let board: [[Bool]] = [[false, false, false, false],
                               [true, true, false, true],
                               [false, false, false, false],
                               [false, false, false, false]]

        let start = Coordinate(x: -1, y: -1)
        let end = Coordinate(x: 3, y: 3)

        let steps = shortestPath(board: board, start: start, end: end)
        XCTAssertNil(steps)
    }

    func testShortestPathEndOutOfBounds() {
        let board: [[Bool]] = [[false, false, false, false],
                               [true, true, false, true],
                               [false, false, false, false],
                               [false, false, false, false]]

        let start = Coordinate(x: 0, y: 0)
        let end = Coordinate(x: 4, y: 4)

        let steps = shortestPath(board: board, start: start, end: end)
        XCTAssertNil(steps)
    }
}
