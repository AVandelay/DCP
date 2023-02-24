

func maxAreaOfIsland(_ grid: [[Int]]) -> Int {
    var maxArea = 0
    var visited = Set<[Int]>()

    var explore: ((Int, Int) -> Int)!
    explore = { i, j in
        if i < 0 || i >= grid.count || j < 0 || j >= grid[0].count || grid[i][j] == 0 || visited.contains([i, j]) {
            return 0
        }

        visited.insert([i, j])

        let area = 1 + explore(i+1, j) + explore(i-1, j) + explore(i, j+1) + explore(i, j-1)

        return area
    }

    for i in 0..<grid.count {
        for j in 0..<grid[0].count {
            if grid[i][j] == 1 && !visited.contains([i, j]) {
                let area = explore(i, j)
                maxArea = max(maxArea, area)
            }
        }
    }

    return maxArea
}

import XCTest

final class MaxAreaOfIslandTests: XCTestCase {
    func testMaxAreaOfIsland() {
        let testCases: [(grid: [[Int]], expectation: Int)] =
        [
            (grid: [
                [0,0,1,0,0,0,0,1,0,0,0,0,0],
                [0,0,0,0,0,0,0,1,1,1,0,0,0],
                [0,1,1,0,1,0,0,0,0,0,0,0,0],
                [0,1,0,0,1,1,0,0,1,0,1,0,0],
                [0,1,0,0,1,1,0,0,1,1,1,0,0],
                [0,0,0,0,0,0,0,0,0,0,1,0,0],
                [0,0,0,0,0,0,0,1,1,1,0,0,0],
                [0,0,0,0,0,0,0,1,1,0,0,0,0]
            ],
             expectation: 6),
            (grid: [[0,0,0,0,0,0,0,0]], expectation: 0)
        ]

        for testCase in testCases {
            XCTAssertEqual(maxAreaOfIsland(testCase.grid), testCase.expectation)
        }
    }
}
