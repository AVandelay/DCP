import typing

class TicTacToe:

    def __init__(self, n: int):
        self.n = n
        self.board = [[0] * n for _ in range(n)]

    def move(self, row: int, col: int, player: int) -> int:
        self.board[row][col] = player
        if self.check_win(row, col, player):
            return player
        return 0

    def check_win(self, row: int, col: int, player: int) -> bool:
        # Check row
        if all(self.board[row][i] == player for i in range(self.n)):
            return True
        # Check column
        if all(self.board[i][col] == player for i in range(self.n)):
            return True
        # Check diagonal
        if row == col and all(self.board[i][i] == player for i in range(self.n)):
            return True
        # Check anti-diagonal
        if row + col == self.n - 1 and all(self.board[i][self.n - i - 1] == player for i in range(self.n)):
            return True
        return False