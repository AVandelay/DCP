

fileprivate func maxProfit(prices: [Int]) -> Int {
    guard prices.count > 1 else { return 0 }

    var minPrice = prices.first!
    var maxProfit = 0

    for price in prices[1...] {
        minPrice = min(minPrice, price)
        maxProfit = max(maxProfit, price - minPrice)
    }

    return maxProfit
}

import XCTest

final class BestTimeToBuyAndSellStock: XCTestCase {
    func test() {
        XCTAssertEqual(maxProfit(prices: [7,1,5,3,6,4]), 5)
        XCTAssertEqual(maxProfit(prices: [7,6,4,3,1]), 0)
    }
}
