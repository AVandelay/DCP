fileprivate func closestCost(baseCosts: [Int], toppingCosts: [Int], target: Int) -> Int {
    var bestCost = Int.max

    // Recursive function to calculate the closest possible cost
    func dfs(_ i: Int, _ sum: Int) {
        // Check if the current cost is closer to the target
        if abs(target - sum) < abs(bestCost - target) ||
           (abs(target - sum) == abs(bestCost - target) && sum < bestCost) {
            bestCost = sum
        }

        // If the current sum is already greater than target or all toppings have been considered
        if sum > target || i == toppingCosts.count {
            return
        }

        // Recursively call dfs without adding the current topping
        dfs(i+1, sum)
        // Recursively call dfs with adding one unit of the current topping
        dfs(i+1, sum + toppingCosts[i])
        // Recursively call dfs with adding two units of the current topping
        dfs(i+1, sum + 2*toppingCosts[i])
    }

    // Loop through each base flavor
    for base in baseCosts {
        dfs(0, base)
    }

    return bestCost
}

import XCTest

final class ClosestDessertCostTests: XCTestCase {
    func test() {
        var baseCosts = [1,7]
        var toppingCosts = [3,4]
        var target = 10
        XCTAssertEqual(closestCost(baseCosts: baseCosts, toppingCosts: toppingCosts, target: target), 10)

        baseCosts = [2,3]
        toppingCosts = [4,5,100]
        target = 18
        XCTAssertEqual(closestCost(baseCosts: baseCosts, toppingCosts: toppingCosts, target: target), 17)
    }
}
