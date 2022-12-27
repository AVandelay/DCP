

/// Represents a brick in a brick wall.
struct Brick: Hashable {
    /// The row index of the brick.
    let row: Int
    /// The column index of the brick.
    let column: Int
}


/// Finds the bricks in a wall that are no longer attached to the ground after a brick is removed.
/// - Parameters:
///   - wall: A 2D array representing the space in which the brick wall is built. Each element in the array
///           can contain either a 1 to indicate that there is a brick at that location, or a 0 to indicate
///           that the cell is empty. The bottom row of the array represents the ground.
///   - bricks: A set of `Brick` objects representing the bricks in the wall.
///   - removedBrickRow: The row index of the brick being removed.
///   - removedBrickColumn: The column index of the brick being removed.
///   - toppledBricks: A set of `Brick` objects representing the bricks that are already marked as toppled.
/// - Returns: A set of `Brick` objects representing the bricks that are no longer attached to the ground
///            after the brick is removed.
fileprivate func findToppledBricks(wall: [[Int]], bricks: Set<Brick>, removedBrickRow: Int, removedBrickColumn: Int, toppledBricks: inout Set<Brick>) {
    // If the brick being removed is on the bottom row, return as there are no bricks beneath it to topple
    if removedBrickRow == wall.count - 1 {
        return
    }

    // Inner function to check if a brick is toppled
    func checkBrick(brick: Brick, visitedBricks: inout Set<Brick>) -> Bool {
        // If the brick is in the last row, it is not toppled
        if brick.row == wall.count - 1 {
            return false
        }
        // If the brick is on the first or last column, it is not toppled
        if brick.column == 0 || brick.column == wall[brick.row].count - 1 {
            return false
        }
        // If the brick has no bricks beneath it and to its left and right, it is toppled
        if wall[brick.row + 1][brick.column] == 0 && wall[brick.row][brick.column - 1] == 0 && wall[brick.row][brick.column + 1] == 0 {
            return true
        }
        // If the brick has a brick beneath it, check if that brick is toppled
        if wall[brick.row + 1][brick.column] == 1 {
            let beneathBrick = Brick(row: brick.row + 1, column: brick.column)
            if !visitedBricks.contains(beneathBrick) {
                visitedBricks.insert(beneathBrick)
                if checkBrick(brick: beneathBrick, visitedBricks: &visitedBricks) {
                    return true
                }
            }
        }
        // If the brick has a brick to its left, check if that brick is toppled
        if wall[brick.row][brick.column - 1] == 1 {
            let leftBrick = Brick(row: brick.row, column: brick.column - 1)
            if !visitedBricks.contains(leftBrick) {
                visitedBricks.insert(leftBrick)
                if checkBrick(brick: leftBrick, visitedBricks: &visitedBricks) {
                    return true
                }
            }
        }
        // If the brick has a brick to its right, check if that brick is toppled
        if wall[brick.row][brick.column + 1] == 1 {
            let rightBrick = Brick(row: brick.row, column: brick.column + 1)
            if !visitedBricks.contains(rightBrick) {
                visitedBricks.insert(rightBrick)
                if checkBrick(brick: rightBrick, visitedBricks: &visitedBricks) {
                    return true
                }
            }
        }
        return false
    }

    // Find the neighboring bricks of the brick being removed
    var neighbors: Set<Brick> = []
    for brick in bricks {
        if brick.row == removedBrickRow && brick.column == removedBrickColumn {
            continue
        }
        // A brick is considered a neighbor if it is immediately adjacent to the brick being removed
        if abs(brick.row - removedBrickRow) + abs(brick.column - removedBrickColumn) == 1 {
            neighbors.insert(brick)
        }
    }

    // If there are no neighbors, the brick being removed is toppled
    if neighbors.isEmpty {
        toppledBricks.insert(Brick(row: removedBrickRow, column: removedBrickColumn))
    }

    // Check the neighbors to see if they are toppled
    for brick in neighbors {
        // Remove the current brick from the bricks set to prevent it from being processed again
        let updatedBricks = bricks.subtracting(Set([brick]))
        var visitedBricks = Set<Brick>()
        for brick in bricks {
            if checkBrick(brick: brick, visitedBricks: &visitedBricks) {
                // If the brick is toppled, add it to the toppledBricks set
                toppledBricks.insert(brick)
            } else {
                // If the brick is not toppled, search its neighbors recursively
                findToppledBricks(wall: wall, bricks: updatedBricks, removedBrickRow: brick.row, removedBrickColumn: brick.column, toppledBricks: &toppledBricks)
            }
        }
    }
}

import XCTest

final class FindToppledBricksTests: XCTestCase {
    func test() {
        // Define the expectation
        let expectation = Set([ Brick(row: 2, column: 1),
                                Brick(row: 0, column: 0),
                                Brick(row: 0, column: 1),
                                Brick(row: 0, column: 2),
                                Brick(row: 0, column: 3),
                                Brick(row: 1, column: 3)
        ])
        // Define the wall as a 2D array
        let wall: [[Int]] = [    [1, 1, 1, 1],
                                 [0, 1, 0, 1],
                                 [0, 1, 0, 0],
                                 [0, 1, 0, 0]
        ]
        
        // Create a set of bricks from the wall array
        var bricks: Set<Brick> = []
        for (row, rowArray) in wall.enumerated() {
            for (column, value) in rowArray.enumerated() {
                if value == 1 {
                    bricks.insert(Brick(row: row, column: column))
                }
            }
        }

        // Initialize an empty set to store the toppled bricks
        var toppledBricks: Set<Brick> = []

        // Remove a brick from the wall and find the toppled bricks
        let removedBrickRow = 1
        let removedBrickColumn = 1
        bricks.remove(Brick(row: removedBrickRow, column: removedBrickColumn))
        findToppledBricks(
            wall: wall,
            bricks: bricks,
            removedBrickRow: removedBrickRow,
            removedBrickColumn: removedBrickColumn,
            toppledBricks: &toppledBricks)

        XCTAssertEqual(toppledBricks, expectation)
        
        // Print the toppled bricks
        print("Toppled bricks:")
        for brick in toppledBricks {
            print("Row: \(brick.row), Column: \(brick.column)")
        }

    }
}
