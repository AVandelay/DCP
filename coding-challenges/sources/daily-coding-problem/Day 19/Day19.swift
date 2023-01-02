

func buildHouses(_ matrix: [[Int]]) -> Int {
    // Initialize variables
    var lowestCost = 0
    var lowestCostIndex = -1
    var secondLowestCost = 0

    // Iterate through rows of the matrix
    for row in matrix {
        // Initialize variables for new minimum cost, new lowest cost index, and new second lowest cost
        var newLowestCost = Int.max
        var newLowestCostIndex = -1
        var newSecondLowestCost = Int.max

        // Iterate through the columns of the current row
        for (c, val) in row.enumerated() {
            // Calculate the cost of painting the current house with the current color
            let prevLowestCost = (c == lowestCostIndex) ? secondLowestCost : lowestCost
            let cost = prevLowestCost + val

            // Update the minimum, second minimum, and index variables
            if cost < newLowestCost {
                newSecondLowestCost = newLowestCost
                newLowestCost = cost
                newLowestCostIndex = c
            } else if cost < newSecondLowestCost {
                newSecondLowestCost = cost
            }
        }

        // Update the main minimum, second minimum, and index variables
        lowestCost = newLowestCost
        lowestCostIndex = newLowestCostIndex
        secondLowestCost = newSecondLowestCost
    }

    // Return the minimum cost of painting the last house
    return lowestCost
}

import XCTest

final class Day19: XCTestCase {
    func test() {
        // Test 1
        let matrix1 = [
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9]
        ]
        let expected1 = 13
        let result1 = buildHouses(matrix1)
        XCTAssertEqual(result1, expected1)

        // Test 2
        let matrix2 = [
            [10, 11, 12],
            [13, 14, 15],
            [16, 17, 18]
        ]
        let expected2 = 40
        let result2 = buildHouses(matrix2)
        XCTAssertEqual(result2, expected2)

        // Test 3
        let matrix3 = [
            [1, 2, 3],
            [4, 5, 6]
        ]
        let expected3 = 6
        let result3 = buildHouses(matrix3)
        XCTAssertEqual(result3, expected3)

        // Test 4
        let matrix4 = [[1, 2, 3]]
        let expected4 = 1
        let result4 = buildHouses(matrix4)
        XCTAssertEqual(result4, expected4)
    }

}


