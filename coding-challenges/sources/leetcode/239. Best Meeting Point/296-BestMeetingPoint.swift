

/// Returns the minimum total distance from each house to a single meeting point on a grid.
///
/// This function finds the best meeting point by calculating the median coordinates of the houses.
/// It uses bucket sort to sort the coordinates in linear time, leveraging the discrete integer
/// coordinates within a limited range.
///
/// - Parameter grid: A 2D grid representing the locations of houses (1) and empty spaces (0).
/// - Returns: The minimum total distance from each house to the meeting point.
fileprivate func bestMeetingPoint(_ grid: [[Int]]) -> Int {
    var houseX = [Int]()
    var houseY = [Int]()

    // Iterate through the grid and store x and y coordinates of houses
    for i in 0..<grid.count {
        for j in 0..<grid[0].count {
            if grid[i][j] == 1 {
                houseX.append(i)
                houseY.append(j)
            }
        }
    }

    // Bucket sort the x and y coordinates
    let sortedX = bucketSort(houseX, gridSize: grid.count)
    let sortedY = bucketSort(houseY, gridSize: grid[0].count)

    // Find the median x and y coordinates
    let medianX = findMedian(sortedX)
    let medianY = findMedian(sortedY)

    // Calculate the total minimum distance using the median coordinates
    var minDistance = 0
    for i in 0..<houseX.count {
        minDistance += abs(houseX[i] - medianX) + abs(houseY[i] - medianY)
    }

    return minDistance
}

/// Sorts an array of integer coordinates using bucket sort.
///
/// - Parameter coordinates: An array of integer coordinates.
/// - Returns: A sorted array of integer coordinates.
private func bucketSort(_ coordinates: [Int], gridSize: Int) -> [Int] {
    var buckets = [Int](repeating: 0, count: gridSize)
    coordinates.forEach { buckets[$0] += 1 }

    return buckets.enumerated().flatMap { index, count in
        Array(repeating: index, count: count)
    }
}

/// Finds the median value of a sorted array of integer coordinates.
///
/// - Parameter sortedCoordinates: A sorted array of integer coordinates.
/// - Returns: The median value of the coordinates.
private func findMedian(_ sortedCoordinates: [Int]) -> Int {
    let n = sortedCoordinates.count
    if n % 2 == 0 {
        return (sortedCoordinates[n / 2 - 1] + sortedCoordinates[n / 2]) / 2
    } else {
        return sortedCoordinates[n / 2]
    }
}

import XCTest

final class BestMeetingPointTests: XCTestCase {
    func test() {
        let grid = [[1,0,0,0,1],[0,0,0,0,0],[0,0,1,0,0]]
        XCTAssertEqual(bestMeetingPoint(grid), 6)
    }
}
