

/**
 To determine whether an undirected graph is bipartite, we can use a modified version of graph coloring. Specifically, we can color each vertex in the graph either red or blue, such that no two adjacent vertices have the same color. If we are able to color all vertices in the graph in this way, then the graph is bipartite. Otherwise, it is not.

 We can use depth-first search (DFS) to traverse the graph and assign colors to vertices. We start by coloring the first vertex red, and then color all of its neighbors blue, and so on. If we come across a vertex that has already been colored, we check to see if its color matches the expected color. If it does not, then the graph is not bipartite. If we have successfully colored all vertices in the graph without finding any conflicts, then the graph is bipartite.
 */


/// Checks whether an undirected graph is bipartite.
///
/// A graph is bipartite if its vertices can be divided into two independent sets, U and V, such that no edge connects vertices of the same set.
///
/// - Parameter graph: The adjacency list representing the graph.
///
/// - Returns: A boolean indicating whether the graph is bipartite.
fileprivate func isBipartite(_ graph: [[Int]]) -> Bool {
    var colors = [Int](repeating: 0, count: graph.count)
    for node in 0..<graph.count {
        if colors[node] == 0 {
            if !bfs(graph, node, &colors) {
                return false
            }
        }
    }

    return true
}

/// Checks whether a connected component in an undirected graph is bipartite.
///
/// A graph is bipartite if its vertices can be divided into two independent sets, U and V, such that no edge connects vertices of the same set.
///
/// - Parameters:
///   - node: The current node being visited.
///   - graph: The adjacency list representing the graph.
///   - colors: An array representing the color of each node in the graph.
///
/// - Returns: A boolean indicating whether the connected component is bipartite.
private func bfs(_ graph: [[Int]], _ start: Int, _ colors: inout [Int]) -> Bool {
    var queue = [start]
    colors[start] = 1

    while !queue.isEmpty {
        let vertex = queue.removeFirst()

        for neighbor in graph[vertex] {
            if colors[neighbor] == 0 {
                colors[neighbor] = -colors[vertex]
                queue.append(neighbor)
            } else if colors[neighbor] == colors[vertex] {
                return false
            }
        }
    }

    return true
}


import XCTest

final class Day207: XCTestCase {
    func testIsBipartite() {
        let g1 = [[1, 2], [2, 3], [3, 4], [4, 1]]
        XCTAssertFalse(isBipartite(g1))

        let g2 = [[1, 2], [2, 3], [3, 4], [4, 5], [5, 1]]
        XCTAssertFalse(isBipartite(g2))

        let g3 = [[1, 2], [2, 3], [3, 1]]
        XCTAssertFalse(isBipartite(g3))

        let g4 = [[1, 2], [2, 3], [3, 4], [4, 1], [4, 5], [5, 2]]
        XCTAssertFalse(isBipartite(g4))

        let g5 = [[Int]]()
        XCTAssertTrue(isBipartite(g5))
    }
}
