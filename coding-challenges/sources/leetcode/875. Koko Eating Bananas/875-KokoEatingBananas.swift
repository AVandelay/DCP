

fileprivate func minEatingSpeed(_ piles: [Int], _ h: Int) -> Int {
    // Check if it's possible to eat all bananas within h hours with speed speed
    func isPossibleToEatAllBananas(withEatingSpeed speed: Int) -> Bool {
        // Calculate the number of hours needed to eat all bananas with speed speed
        let hoursNeeded = piles.reduce(0) { (hours, pile) in
            hours + (pile - 1) / speed + 1
        }
        // Return true if hoursNeeded is less than or equal to H, false otherwise
        return hoursNeeded <= h
    }

    var left = 1
    var right = piles.max()!

    // Use binary search to find the minimum integer k such that she can eat all the bananas within H hours
    while left < right {
        let mid = (left + right) / 2
        if isPossibleToEatAllBananas(withEatingSpeed: mid) {
            // If it's possible to eat all bananas within h hours with speed mid, update right to mid
            right = mid
        } else {
            // If it's not possible to eat all bananas within H hours with speed mid, update left to mid + 1
            left = mid + 1
        }
    }

    // Return the minimum integer speed such that Koko can eat all the bananas within H hours
    return left
}

import XCTest

final class KokoEatingBananasTests: XCTestCase {
    func test() {
        var piles = [3, 6, 7, 11]
        var h = 8
        XCTAssertEqual(minEatingSpeed(piles, h), 4)

        piles = [30, 11, 23, 4, 20]
        h = 5
        XCTAssertEqual(minEatingSpeed(piles, h), 30)

        piles = [30, 11, 23, 4, 20]
        h = 6
        XCTAssertEqual(minEatingSpeed(piles, h), 23)
    }
}
