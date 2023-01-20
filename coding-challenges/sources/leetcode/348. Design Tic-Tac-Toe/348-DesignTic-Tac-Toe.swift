

fileprivate class TicTacToe {
    private var board: [[Int]]
    private var n: Int

    /**
     Initializes the object with size of the board n.
     - Complexity: O(n^2)
     - Parameters:
     - n: The size of the board, a positive integer.
     */
    init(n: Int) {
        self.n = n
        self.board = Array(repeating: Array(repeating: 0, count: n), count: n)
    }

    /**
     Indicates that the player with id player plays at the cell (row, col) of the board.
     The move is guaranteed to be a valid move, and the two players alternate in making moves.
     - Complexity: O(n)
     - Parameters:
         - row: The row of the cell where the player plays, an integer between 0 and n-1.
         - col: The column of the cell where the player plays, an integer between 0 and n-1.
         - player: The id of the player, an integer between 1 and 2.
     - Returns:
         - 0 if there is no winner after the move,
         - 1 if player 1 is the winner after the move, or
         - 2 if player 2 is the winner after the move.
     */
    func move(row: Int, col: Int, player: Int) -> Int {
        board[row][col] = player
        if checkRows(player: player) || checkCols(player: player) || checkDiags(player: player) {
            return player
        }
        return 0
    }

    /**
     Checks if any row on the board contains all marks of the same player.
     - Complexity: O(n^2)
     - Parameters:
        - player: The id of the player, an integer between 1 and 2.
     - Returns:
        - true if a row contains all marks of the player,
        - false otherwise.
     */
    private func checkRows(player: Int) -> Bool {
        for row in board {
            if row.allSatisfy({ $0 == player }) {
                return true
            }
        }
        return false
    }

    /**
     Checks if any column on the board contains all marks of the same player.
     - Complexity: O(n^2)
     - Parameters:
        - player: The id of the player, an integer between 1 and 2.
     - Returns:
        - true if a column contains all marks of the player,
        - false otherwise.
     */
    private func checkCols(player: Int) -> Bool {
        for col in 0..<n {
            if (0..<n).allSatisfy({ board[$0][col] == player }) {
                return true
            }
        }
        return false
    }

    /**
     Checks if any diagonal on the board contains all marks of the same player.
     - Complexity: O(n)
     - Parameters:
        - player: The id of the player, an integer between 1 and 2.
     - Returns:
        - true if a diagonal contains all marks of the player,
        - false otherwise.
     */
    private func checkDiags(player: Int) -> Bool {
        if (0..<n).allSatisfy({ board[$0][$0] == player }) {
            return true
        }
        if (0..<n).allSatisfy({ board[$0][n-$0-1] == player }) {
            return true
        }
        return false
    }
}
