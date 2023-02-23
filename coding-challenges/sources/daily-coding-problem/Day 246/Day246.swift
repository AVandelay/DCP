

/// Determines whether a given list of words can be chained to form a circle. A word X can be placed in front of another word Y in a circle if the last character of X is the same as the first character of Y.
///
/// - Parameter words: The list of words to check.
///
/// - Returns: A boolean indicating whether the words can be chained to form a circle.
fileprivate func canChain(_ words: [String]) -> Bool {
    // Build the graph using the first and last characters of each word.
    let graph = makeGraph(words)

    // Check if the in-degree and out-degree of each node are equal.
    let degreesEqual = areDegreesEqual(graph)

    // Check if the graph is strongly connected.
    let connected = isConnected(graph)

    return degreesEqual && connected
}

/// Finds a component in a graph.
///
/// - Parameters:
///   - graph: The graph represented as a dictionary with a string key and an array of strings as the value.
///   - visited: The set of visited vertices.
///   - currentWord: The current word being visited.
///
/// - Returns: A set of vertices in the component.
private func findComponent(_ graph: [String: [String]], _ visited: inout Set<String>, _ currentWord: String) -> Set<String> {
    visited.insert(currentWord)

    for neighbor in graph[currentWord]! {
        if !visited.contains(neighbor) {
            _ = findComponent(graph, &visited, neighbor)
        }
    }

    return visited
}

/// Checks whether a graph is strongly connected.
///
/// A directed graph is strongly connected if there is a directed path between any two nodes in the graph.
///
/// - Parameter graph: The adjacency list representing the graph.
///
/// - Returns: A boolean indicating whether the graph is strongly connected.
private func isConnected(_ graph: [String: [String]]) -> Bool {
    // Find the first node in the graph
    guard let start = graph.keys.first else {
        return false
    }

    // Check if all nodes can be reached from the first node
    var visited = Set<String>()
    var component = findComponent(graph, &visited, start)
    var reversedGraph = reverseGraph(graph)
    visited.removeAll()
    var reversedComponent = findComponent(reversedGraph, &visited, start)
    return component == reversedComponent && component.count == graph.keys.count
}

/// Reverses the direction of all edges in the graph.
///
/// - Parameter graph: The adjacency list representing the graph.
///
/// - Returns: The reversed graph.
private func reverseGraph(_ graph: [String: [String]]) -> [String: [String]] {
    var reversedGraph = [String: [String]]()
    for (key, values) in graph {
        for v in values {
            reversedGraph[v, default: []].append(key)
        }
    }
    return reversedGraph
}

/// Determines if the in-degree of each vertex in the graph is equal to its out-degree.
///
/// - Parameter graph: The graph represented as a dictionary with a string key and an array of strings as the value.
///
/// - Returns: A boolean indicating if the in-degree of each vertex in the graph is equal to its out-degree.
private func areDegreesEqual(_ graph: [String: [String]]) -> Bool {
    var inDegree = [String: Int]()
    var outDegree = [String: Int]()

    for (key, values) in graph {
        // Calculate the out-degree for the current vertex
        outDegree[key, default: 0] += values.count
        for v in values {
            // Calculate the in-degree for the current vertex
            inDegree[v, default: 0] += 1
        }
    }

    // Check if the in-degree dictionary is equal to the out-degree dictionary
    return inDegree == outDegree
}

/// Builds a graph from a list of words where a word X can be placed in front of another word Y if the last character of X is the same as the first character of Y.
///
/// - Parameter words: A list of words.
///
/// - Returns: A graph represented as a dictionary with a string key and an array of strings as the value.
private func makeGraph(_ words: [String]) -> [String: [String]] {
    var graph = [String: [String]]()

    for word in words {
        graph[String(word.first!), default: []].append(String(word.last!))
    }

    return graph
}

import XCTest

final class Day246: XCTestCase {
    func testCanChain() {
        XCTAssertTrue(canChain(["chair", "height", "racket", "touch", "tunic"]))
    }
}
