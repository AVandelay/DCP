

/**
 #Introduction
 The 2-SAT (2-Satisfiability) algorithm is a popular algorithm for solving the Boolean satisfiability (SAT) problem when the input is in conjunctive normal form (CNF) with exactly 2 literals per clause, that is, the input has the form (a OR b) AND (c OR d) AND .... It is a fast and efficient algorithm that can solve problems with a large number of variables and clauses. In this blog post, we will explore the 2-SAT algorithm and how it works.

 #Background
 The Boolean satisfiability problem is a well-known problem in computer science. It is the problem of determining whether there exists an assignment of truth values (i.e., true or false) to variables in a Boolean formula such that the formula evaluates to true. For example, the formula a AND (NOT b) OR c is satisfiable if we assign a=true, b=false, and c=true, since the formula evaluates to true under this assignment.

 The 2-SAT problem is a restricted form of the Boolean satisfiability problem where the input is a CNF formula with exactly 2 literals per clause. The 2-SAT problem has important applications in various areas, including scheduling, planning, and optimization.

 #The Algorithm
 The 2-SAT algorithm consists of 4 main steps:

 1. Build the implication graph and its reverse.
 An implication graph is a directed graph that represents the logical implications of the input formula. Each variable in the formula corresponds to two nodes in the graph, one for the positive literal and one for the negation. For each clause (a OR b) in the input formula, we add two directed edges to the graph: NOT a => b and NOT b => a. We also build the reverse graph, which has the same edges as the original graph but with the direction of each edge reversed.

 2. Compute the strongly connected components of the reverse graph.
 A strongly connected component is a subgraph of the graph where every node is reachable from every other node in the subgraph. We can compute the strongly connected components of the reverse graph using a depth-first search (DFS) algorithm. We visit the nodes in the reverse graph in reverse topological order (i.e., in the order produced by a topological sort of the reverse graph) and assign each node to a component. Each component corresponds to a set of nodes that mutually imply each other. We assign each node in a strongly connected component the same component number.

 3. Compute the truth values of the nodes in the implication graph.
 We perform another DFS on the original graph, but we start with the nodes in decreasing order of their component number. For each node, we assign it a truth value based on its component number. If the node is in a component with a higher number than its negation, we assign it the value true; otherwise, we assign it the value false. If a node and its negation are in the same component, the formula is unsatisfiable.

 4. Check the satisfiability of the formula.
 We check the satisfiability of the formula by verifying that no variable and its negation are both assigned the value true.
 */

/**
 * Determine whether the given 2-CNF formula is satisfiable, and if so, return a set of truth values that satisfies it.
 *
 * - Parameters:
 *   - formula: An array of integers representing the variables in the formula.
 *   - variables: A variable number of tuples representing the clauses of the formula.
 *
 * - Returns: A set of boolean values that satisfy the formula, or `false` if the formula is unsatisfiable.
 */
func satisfy2CNF(_ formula: [(Int, Int)], variables: [Int]) -> Set<Int>? {
    var graph: [Int: [Int]] = [:]

    // Build the graph and its reverse.
    for (a, b) in formula {
        graph[negate(a), default: []].append(b)
        graph[negate(b), default: []].append(a)
    }

    // Get the ordered nodes using topological sort.
    let orderedNodes = topologicalSort(graph: graph)

    // Get the transpose of the graph.
    let transpose = getTranspose(graph)

    // Get the strongly connected components of the graph.
    let components = getStronglyConnectedComponents(graph: transpose, order: orderedNodes)

    // Check if the formula is unsatisfiable.
    if variables.contains(where: { components[$0] == components[negate($0)] }) {
        return nil
    }

    // Get the truth values for the variables.
    return Set(variables.map { variable in
        let negatedVariable = negate(variable)
        let maxVariable = [variable, negatedVariable].max(by: { components[$0]! < components[$1]! })!
        return maxVariable
    })
}


/// Performs a depth-first search on the graph and appends visited nodes to a given order array.
///
/// - Parameters:
///   - node: The starting node for the search.
///   - graph: The graph to be searched in reverse.
///   - visited: A set of visited nodes.
///   - order: An array containing the order of visited nodes.
private func dfs(node: Int, graph: [Int: [Int]], visited: inout Set<Int>, order: inout [Int]) {
    visited.insert(node)

    for nextNode in graph[node, default: []] {
        if !visited.contains(nextNode) {
            dfs(node: nextNode, graph: graph, visited: &visited, order: &order)
        }
    }

    order.append(node)
}

/**
 Topologically sorts the given directed acyclic graph (DAG).

 - Parameter graph: The graph to sort. This should be a dictionary where the keys are nodes and the values are arrays of nodes representing the outgoing edges of the key node.
 - Returns: The nodes in the graph sorted in topological order. If the graph contains a cycle, returns an empty array.
 */
private func topologicalSort(graph: [Int: [Int]]) -> [Int] {
    var visited = Set<Int>()
    var ordering = [Int]()

    for node in graph.keys {
        if !visited.contains(node) {
            dfs(node: node, graph: graph, visited: &visited, order: &ordering)
        }
    }

    // If the graph has a cycle, the ordering will be less than the number of nodes in the graph.
    return ordering.count == graph.count ? ordering.reversed() : []
}

/// Compute the transpose of a given graph, where all edges are reversed.
///
/// - Parameters:
///     - graph: The input graph.
///
/// - Returns: The transpose of the input graph.
private func getTranspose(_ graph: [Int: [Int]]) -> [Int: [Int]] {
    var transpose: [Int: [Int]] = [:]

    // Reverse all edges in the input graph.
    for (key, values) in graph {
        for v in values {
            transpose[v, default: []].append(key)
        }
    }

    return transpose
}

/**
 Performs depth-first search on the transpose of a graph, assigning a component number to each node. Each node is also visited and marked.

 - Parameters:
   - node: The node currently being searched.
   - graph: The transpose of the graph to search.
   - visited: A dictionary of nodes and whether or not they have been visited.
   - components: A dictionary of node component numbers.
   - componentNumber: The current component number.

 - Complexity: O(V + E), where V is the number of nodes in the graph and E is the number of edges.
*/
private func dfsAssignComponents(
    node: Int,
    graph: [Int: [Int]],
    visited: inout [Int: Bool],
    components: inout [Int: Int],
    componentNumber: Int
) {
    visited[node] = true
    components[node] = componentNumber
    if let neighbors = graph[node] {
        for neighbor in neighbors {
            if visited[neighbor] == false {
                dfsAssignComponents(node: neighbor, graph: graph, visited: &visited, components: &components, componentNumber: componentNumber)
            }
        }
    }
}

/**
 Calculates the strongly connected components of a graph. A strongly connected component is a subset of the graph's nodes where each node is reachable from every other node.

 - Parameters:
   - graph: The graph to calculate the strongly connected components of.
   - order: The order in which the strongly connected components should be assigned.

 - Returns: A dictionary of node component numbers.

 - Complexity: O(V + E), where V is the number of nodes in the graph and E is the number of edges.
*/
private func getStronglyConnectedComponents(graph: [Int: [Int]], order: [Int]) -> [Int: Int] {
    var transpose: [Int: [Int]] = [:]
    for (key, values) in graph {
        for v in values {
            transpose[v, default: []].append(key)
        }
    }

    var visited: [Int: Bool] = [:]
    var components: [Int: Int] = [:]
    var componentNumber = -1

    for node in order {
        if visited[node] == false {
            componentNumber += 1
            dfsAssignComponents(node: node, graph: transpose, visited: &visited, components: &components, componentNumber: componentNumber)
        }
    }

    return components
}


/// Returns the negated version of the given variable.
///
/// If the variable is already negated, the negation is removed. Otherwise, a negation is added.
///
/// - Parameter variable: The variable to negate.
/// - Returns: The negated version of the variable.
func negate(_ variable: Int) -> Int {
    if variable < 0 {
        return abs(variable)
    } else {
        return -variable
    }
}

import XCTest

final class Day330: XCTestCase {
    func testSatisfy2CNF() {
        let formula = [
            (-3, 2),
            (2, 3),
            (-2, 3),
            (-3, -1)
        ]
        let variables = [1, 2, 3, 4]
        let expectedSolution: Set<Int> = [3, -1, -2]

        guard let solution = satisfy2CNF(formula, variables: variables) else {
            XCTFail("Formula is unsatisfiable")
            return
        }

        XCTAssertEqual(solution, expectedSolution)
    }
}
