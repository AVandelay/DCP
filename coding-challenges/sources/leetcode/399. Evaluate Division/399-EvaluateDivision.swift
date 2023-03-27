

private class Graph {
    private var adjacencyList = [String: [(String, Double)]]()

    // Add an edge between nodes u and v with the given weight and its reciprocal
    func addEdge(_ u: String, _ v: String, _ weight: Double) {
        if adjacencyList[u] == nil {
            adjacencyList[u] = []
        }
        adjacencyList[u]?.append((v, weight))

        if adjacencyList[v] == nil {
            adjacencyList[v] = []
        }
        adjacencyList[v]?.append((u, 1 / weight))
    }

    // Get the neighbors of the given node
    func getNeighbors(_ node: String) -> [(String, Double)]? {
        return adjacencyList[node]
    }
}

fileprivate func calcEquation(_ equations: [[String]], _ values: [Double], _ queries: [[String]]) -> [Double] {
    let graph = Graph()

    // Build the graph from the equations and values
    for (index, equation) in equations.enumerated() {
        graph.addEdge(equation[0], equation[1], values[index])
    }

    // Map the queries to their result using the traverseGraph
    return queries.map { query in
        traverseGraph(graph, query[0], query[1])
    }
}

private func traverseGraph(_ graph: Graph, _ source: String, _ target: String) -> Double {
    // Check if both source and target nodes are present in the graph
    guard graph.getNeighbors(source) != nil,
          graph.getNeighbors(target) != nil else {
        return -1.0
    }

    var visited = Set<String>()
    var queue: [(String, Double)] = [(source, 1.0)]

    // BFS traversal
    while !queue.isEmpty {
        let (currentNode, currentProduct) = queue.removeFirst()

        // If the target node is found, return the current product
        if currentNode == target {
            return currentProduct
        }

        // If the current node has not been visited yet, process the neighbors
        if !visited.contains(currentNode) {
            visited.insert(currentNode)

            if let neighbors = graph.getNeighbors(currentNode) {
                for (neighbor, weight) in neighbors {
                    if !visited.contains(neighbor) {
                        queue.append((neighbor, currentProduct * weight))
                    }
                }
            }
        }
    }

    // No path found
    return -1.0
}

import XCTest

final class EvaluateDivisionTests: XCTestCase {
    func test() {
        var equations = [["a","b"], ["b","c"]]
        var values = [2.0, 3.0]
        var queries = [["a","c"],["b","a"],["a","e"],["a","a"],["x","x"]]
        var expectation = [6.0, 0.5, -1.0, 1.0, -1.0]
        XCTAssertEqual(calcEquation(equations, values, queries), expectation)

        equations = [["a","b"],["b","c"],["bc","cd"]]
        values = [1.5,2.5,5.0]
        queries = [["a","c"],["c","b"],["bc","cd"],["cd","bc"]]
        expectation = [3.75,0.4,5.0,0.2]
        XCTAssertEqual(calcEquation(equations, values, queries), expectation)

        equations = [["a","b"]]
        values = [0.5]
        queries = [["a","b"],["b","a"],["a","c"],["x","y"]]
        expectation = [0.5,2.0,-1.0,-1.0]
        XCTAssertEqual(calcEquation(equations, values, queries), expectation)
    }
}
