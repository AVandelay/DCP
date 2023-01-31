

fileprivate enum Direction: Equatable {
    case up
    case down
    case left
    case right
}

fileprivate struct ManhattanHeuristic {
    let target: [[Int]]

    func manhattan(for tiles: [[Int]]) -> Int {
        var result = 0
        for row in 0..<tiles.count {
            for col in 0..<tiles[0].count {
                let value = tiles[row][col]
                let targetRow = (value - 1) / tiles[0].count
                let targetCol = (value - 1) % tiles[0].count
                result += abs(row - targetRow) + abs(col - targetCol)
            }
        }
        return result
    }
}

fileprivate struct Board: Hashable {
    private var blankIndex: (row: Int, col: Int) {
        for row in 0..<tiles.count {
            for col in 0..<tiles[row].count {
                if tiles[row][col] == 0 {
                    return (row, col)
                }
            }
        }
        return (0, 0)
    }

    let tiles: [[Int]]

    var heuristics: Int {
        ManhattanHeuristic(target: [[1, 2, 3], [4, 5, 6], [7, 8, 0]]).manhattan(for: tiles)
    }

    func getMoves() -> [Direction] {
        var moves = [Direction]()
        let row = blankIndex.row
        let col = blankIndex.col
        if row > 0 {
            moves.append(.up)
        }
        if row < tiles.count - 1 {
            moves.append(.down)
        }
        if col > 0 {
            moves.append(.left)
        }
        if col < tiles[row].count - 1 {
            moves.append(.right)
        }
        return moves
    }

    func move(direction: Direction) -> Board {
        var newTiles = tiles
        let row = blankIndex.row
        let col = blankIndex.col
        switch direction {
        case .up:
            newTiles[row][col] = newTiles[row-1][col]
            newTiles[row-1][col] = 0
        case .down:
            newTiles[row][col] = newTiles[row+1][col]
            newTiles[row+1][col] = 0
        case .left:
            newTiles[row][col] = newTiles[row][col-1]
            newTiles[row][col-1] = 0
        case .right:
            newTiles[row][col] = newTiles[row][col+1]
            newTiles[row][col+1] = 0
        }
        return Board(tiles: newTiles)
    }
}

fileprivate struct HeapItem: Equatable {
    let steps: Int
    let moves: Int
    let board: Board
    let path: [Direction]

    static func == (lhs: HeapItem, rhs: HeapItem) -> Bool {
        lhs.board.tiles == rhs.board.tiles
    }
}

fileprivate func search(start: Board, goal: Board) -> [Direction]? {
    var heap = [HeapItem(steps: start.heuristics, moves: 0, board: start, path: [])]
    var visited = [start: 0]

    while !heap.isEmpty {
        // Get the item with the lowest heuristics value
        let item = heap.min(by: { $0.steps < $1.steps })!

        // If the current board is the goal board, return the path to reach it
        if item.board == goal {
            return item.path
        }

        // Remove the item from the heap
        heap.removeAll { $0 == item }

        // Get the possible moves for the current board
        let moves = item.board.getMoves()

        // For each possible move, add the updated board to the heap
        for move in moves {
            let newBoard = item.board.move(direction: move)
            let newMoves = item.moves + 1
            let newSteps = newMoves + newBoard.heuristics

            // Check if the updated board has been visited with a lower number of moves
            if let previousMoves = visited[newBoard], previousMoves <= newMoves {
                continue
            }

            // Add the updated board to the heap and visited set
            heap.append(HeapItem(steps: newSteps, moves: newMoves, board: newBoard, path: item.path + [move]))
            visited[newBoard] = newMoves
        }
    }

    return nil
}

fileprivate func solve(start: Board, goal: Board) -> [Direction]? {
    let solution = search(start: start, goal: goal)
    return solution
}

import XCTest

final class Day319: XCTestCase {
    func test8SolvePuzzle() {
        let startTiles = [[1,2,3], [0,4,6], [7,5,8]]
        let goalTiles = [[1,2,3], [4,5,6], [7,8,0]]
        let start = Board(tiles: startTiles)
        let goal = Board(tiles: goalTiles)
        let solution = solve(start: start, goal: goal)
        XCTAssertNotNil(solution)
        XCTAssertEqual(solution!.count, 3)
        XCTAssertEqual(solution![0], .right)
        XCTAssertEqual(solution![1], .down)
        XCTAssertEqual(solution![2], .right)
    }

}
