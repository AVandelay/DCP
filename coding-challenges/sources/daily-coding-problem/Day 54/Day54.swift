

/**
 A class for solving Sudoku puzzles.

 A Sudoku puzzle is a 9x9 grid of cells, where each cell can contain a digit from 1 to 9.
 The puzzle is solved by filling in all the cells such that each row, column, and box
 (3x3 subgrid) contains all the digits from 1 to 9. A cell containing the digit 0 is considered empty.
 */
fileprivate class SudokuSolver {
    /// The current state of the Sudoku board.
    var board: [[Int]]

    /**
     Initializes a new Sudoku solver with the given board.

     - Parameter board: The 9x9 array representing the Sudoku puzzle, where each cell contains an integer from 0 to 9 (0 represents an empty cell).
     */
    init(board: [[Int]]) {
        self.board = board
    }

    /**
     Attempts to solve the Sudoku puzzle using backtracking.

     - Returns: `true` if a solution is found, `false` otherwise.
     If a solution is found, the `board` property is updated with the solved puzzle.
     */
    func solve() -> Bool {
        guard let emptyCell = findEmptyCell() else {
            return true // the board is solved
        }

        let row = emptyCell.row
        let col = emptyCell.col

        for value in 1...9 {
            if isValidMove(row: row, col: col, value: value) {
                board[row][col] = value

                if solve() {
                    return true
                }

                board[row][col] = 0 // backtrack
            }
        }

        return false // no valid move found
    }

    /**
     Finds the next empty cell on the board.

     - Returns: A tuple containing the row and column indices of the next empty cell, or `nil` if no empty cell is found.
     */
    func findEmptyCell() -> (row: Int, col: Int)? {
        for row in 0..<9 {
            for col in 0..<9 {
                if board[row][col] == 0 {
                    return (row: row, col: col)
                }
            }
        }
        return nil
    }

    /**
     Checks whether a given digit can be placed in a given cell without violating the row, column, and box constraints.

     - Parameters:
     - row: The row index of the cell to check.
     - col: The column index of the cell to check.
     - value: The digit to check.
     - Returns: `true` if the digit can be placed in the cell without violating the constraints, `false` otherwise.
     */
    func isValidMove(row: Int, col: Int, value: Int) -> Bool {
        // check row and column constraints
        for i in 0..<9 {
            if board[row][i] == value {
                return false
            }
            if board[i][col] == value {
                return false
            }
        }

        // check box constraint
        let boxRow = (row / 3) * 3
        let boxCol = (col / 3) * 3
        for i in 0..<3 {
            for j in 0..<3 {
                if board[boxRow + i][boxCol + j] == value {
                    return false
                }
            }
        }

        return true
    }

    /**
     Prints the current state of the Sudoku board to the console.

     Each row is printed on a separate line, with the digits separated by spaces. Empty cells are represented by a period (.).
     */
    func printBoard() {
        for row in 0..<9 {
            if row % 3 == 0 && row != 0 {
                // print horizontal line to separate boxes
                print("+-------+-------+-------+")
            }
            for col in 0..<9 {
                if col % 3 == 0 && col != 0 {
                    // print vertical bar to separate boxes
                    print("| ", terminator: "")
                }
                let digit = board[row][col]
                let str = digit == 0 ? "." : String(digit)
                print(str, terminator: " ")
            }
            print("")
        }
    }
}

import XCTest

final class Day54: XCTestCase {

    func testEasyPuzzle() {
        let board: [[Int]] = [
            [5, 3, 0, 0, 7, 0, 0, 0, 0],
            [6, 0, 0, 1, 9, 5, 0, 0, 0],
            [0, 9, 8, 0, 0, 0, 0, 6, 0],
            [8, 0, 0, 0, 6, 0, 0, 0, 3],
            [4, 0, 0, 8, 0, 3, 0, 0, 1],
            [7, 0, 0, 0, 2, 0, 0, 0, 6],
            [0, 6, 0, 0, 0, 0, 2, 8, 0],
            [0, 0, 0, 4, 1, 9, 0, 0, 5],
            [0, 0, 0, 0, 8, 0, 0, 7, 9],
        ]
        let solver = SudokuSolver(board: board)
        print("Initial board:")
        solver.printBoard()
        print("Solving...")
        _ = solver.solve()
        print("Solution:")
        solver.printBoard()
    }

    func testHardPuzzle() {
        let board: [[Int]] = [
            [0, 0, 0, 0, 0, 0, 0, 1, 7],
            [0, 2, 0, 0, 0, 7, 0, 5, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 9, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 4, 0, 0],
            [4, 7, 0, 0, 0, 0, 0, 0, 0],
            [0, 5, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
        ]
        var solver = SudokuSolver(board: board)
        print("Initial board:")
        solver.printBoard()
        print("Solving...")
        solver.solve()
        print("Solution:")
        solver.printBoard()
    }
}
