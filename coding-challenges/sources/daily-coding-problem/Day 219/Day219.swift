

/// Connect4 game model.
///
/// A class that represents a Connect 4 game. Contains methods to play the game and check the status of the game.
fileprivate class Connect4 {

    /// Enum representing the players in the game
    enum Player {
        case red
        case black
    }

    /// A 2D array representing the game grid
    var grid: [[Player?]] = Array(repeating: Array(repeating: nil, count: 7), count: 6)

    /// Drops a disc of the specified player into the specified column.
    ///
    /// - Parameters:
    ///   - player: The player who is making the move.
    ///   - column: The column in which to drop the disc.
    ///
    /// - Returns: The row in which the disc was dropped, or nil if the column is full.
    func dropDisc(player: Player, inColumn column: Int) -> Int? {
        for row in 0..<grid.count {
            if grid[row][column] == nil {
                grid[row][column] = player
                return row
            }
        }
        return nil
    }

    /// Check if the game has ended.
    ///
    /// - Parameters:
    ///   - board: 2D array representing the game board.
    ///
    /// - Returns:
    ///   Tuple containing a boolean value indicating if the game has ended and the color of the winning player (if there is one).
    ///
    /// - Complexity: O(n), where n is the total number of cells in the board.
    func gameEnded(grid: [[Player?]]) -> (Bool, Player?) {
        if checkHorizontalWin(for: .red) || checkVerticalWin(for: .red) || checkDiagonalWin(for: .red) {
            return (true, .red)
        } else if checkHorizontalWin(for: .black) || checkVerticalWin(for: .black) || checkDiagonalWin(for: .black) {
            return (true, .black)
        } else if isDraw() {
            return (true, nil)
        } else {
            return (false, nil)
        }
    }

    /// Helper function to check if a player has won the game by creating a line of four consecutive discs of their color horizontally.
    ///
    /// - Parameter player: The player to check for a win.
    /// - Returns: True if the player has won, False otherwise.
    private func checkHorizontalWin(for player: Player) -> Bool {
        for row in grid {
            for i in 0..<row.count-3 {
                if row[i] == player,
                   row[i+1] == player,
                   row[i+2] == player,
                   row[i+3] == player {
                    return true
                }
            }
        }
        return false
    }
    /// Helper function to check if a player has won the game by creating a line of four consecutive discs of their color vertically.
    ///
    /// - Parameter player: The player to check for a win.
    /// - Returns: True if the player has won, False otherwise.
    private func checkVerticalWin(for player: Player) -> Bool {
        for col in 0..<grid[0].count {
            for i in 0..<grid.count-3 {
                if grid[i][col] == player,
                   grid[i+1][col] == player,
                   grid[i+2][col] == player,
                   grid[i+3][col] == player {
                    return true
                }
            }
        }
        return false
    }

    /// Helper function to check if a player has won the game by creating a line of four consecutive discs of their color diagonally.
    ///
    /// - Parameter player: The player to check for a win.
    /// - Returns: True if the player has won, False otherwise.
    private func checkDiagonalWin(for player: Player) -> Bool {
        // Check for diagonal win from top left to bottom right
        for i in 0..<grid.count-3 {
            for j in 0..<grid[0].count-3 {
                if grid[i][j] == player,
                   grid[i+1][j+1] == player,
                   grid[i+2][j+2] == player,
                   grid[i+3][j+3] == player {
                    return true
                }
            }
        }

        // Check for diagonal win from bottom left to top right
        for i in 3..<grid.count {
            for j in 0...3 {
                if grid[i][j] == player,
                   grid[i-1][j+1] == player,
                   grid[i-2][j+2] == player,
                   grid[i-3][j+3] == player {
                    return true
                }
            }
        }

        return false
    }

    /// Check if the game is a draw.
    ///
    /// - Parameters:
    ///   - board: 2D array representing the game board.
    ///
    /// - Returns:
    ///   Boolean value indicating if the game is a draw.
    private func isDraw() -> Bool {
        for col in grid[0] {
            if col == nil {
                return false
            }
        }
        return true
    }
}
