

fileprivate enum Orientation: Int {
    case zero = 0
    case ninety = 1
    case oneEighty = 2
    case twoSeventy = 3
}

fileprivate struct PuzzlePiece {
    let id: Int
    let edges: [Bool]
    var orientation: Orientation

    init(id: Int, edges: [Bool], orientation: Orientation = .zero) {
        self.id = id
        self.edges = edges
        self.orientation = orientation
    }
}

fileprivate class JigsawPuzzle {
    var pieces: [[PuzzlePiece]]
    var solved = false

    init(pieces: [[PuzzlePiece]]) {
        self.pieces = pieces
    }

    func solve() {
        var queue = [(x: Int, y: Int, orientation: Orientation)]()
        queue.append((x: 0, y: 0, orientation: .zero))

        while !queue.isEmpty {
            let (x, y, orientation) = queue.removeFirst()

            var piece = pieces[x][y]

            if piece.id == -1 {
                continue
            }

            piece.orientation = orientation

            if x > 0 {
                addTopPiece(x: x, y: y, orientation: orientation, queue: &queue)
            }

            if x < pieces.count - 1 {
                addBottomPiece(x: x, y: y, orientation: orientation, queue: &queue)
            }

            if y > 0 {
                addLeftPiece(x: x, y: y, orientation: orientation, queue: &queue)
            }

            if y < pieces[x].count - 1 {
                addRightPiece(x: x, y: y, orientation: orientation, queue: &queue)
            }

            if x == pieces.count - 1 && y == pieces[x].count - 1 {
                solved = true
                return
            }
        }
    }

    // Helper function to add the top piece to the queue
    private func addTopPiece(x: Int, y: Int, orientation: Orientation, queue: inout [(x: Int, y: Int, orientation: Orientation)]) {
        let topPiece = pieces[x - 1][y]
        let topMatch = pieceMatches(piece1: pieces[x][y], orientation1: orientation, piece2: topPiece, orientation2: .zero)

        if topPiece.id != -1 && topMatch {
            queue.append((x: x - 1, y: y, orientation: rotateOrientation(orientation: orientation)))
        }
    }

    // Helper function to add the bottom piece to the queue
    private func addBottomPiece(x: Int, y: Int, orientation: Orientation, queue: inout [(x: Int, y: Int, orientation: Orientation)]) {
        let bottomPiece = pieces[x + 1][y]
        let bottomMatch = pieceMatches(piece1: pieces[x][y], orientation1: orientation, piece2: bottomPiece, orientation2: .twoSeventy)

        if bottomPiece.id != -1 && bottomMatch {
            queue.append((x: x + 1, y: y, orientation: rotateOrientation(orientation: orientation)))
        }
    }

    // Helper function to add the left piece to the queue
    private func addLeftPiece(x: Int, y: Int, orientation: Orientation, queue: inout [(x: Int, y: Int, orientation: Orientation)]) {
        let leftPiece = pieces[x][y - 1]
        let leftMatch = pieceMatches(piece1: pieces[x][y], orientation1: orientation, piece2: leftPiece, orientation2: .oneEighty)

        if leftPiece.id != -1 && leftMatch {
            queue.append((x: x, y: y - 1, orientation: rotateOrientation(orientation: orientation)))
        }
    }

    // Helper function to add the right piece to the queue
    private func addRightPiece(x: Int, y: Int, orientation: Orientation, queue: inout [(x: Int, y: Int, orientation: Orientation)]) {
        let rightPiece = pieces[x][y + 1]
        let rightMatch = pieceMatches(piece1: pieces[x][y], orientation1: orientation, piece2: rightPiece, orientation2: .ninety)

        if rightPiece.id != -1 && rightMatch {
            queue.append((x: x, y: y + 1, orientation: rotateOrientation(orientation: orientation)))
        }
    }

    // Helper function to check if two pieces match
    private func pieceMatches(piece1: PuzzlePiece, orientation1: Orientation, piece2: PuzzlePiece, orientation2: Orientation) -> Bool {
        let edge1 = piece1.edges[orientation1.rawValue % 4]
        let edge2 = piece2.edges[orientation2.rawValue % 4]

        return edge1 == edge2
    }

    // Helper function to rotate the orientation of a piece
    private func rotateOrientation(orientation: Orientation) -> Orientation {
        return Orientation(rawValue: (orientation.rawValue + 1) % 4)!
    }
}
