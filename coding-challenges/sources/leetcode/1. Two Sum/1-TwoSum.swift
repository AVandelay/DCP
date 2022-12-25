/**
 # [Two Sum](https://leetcode.com/problems/two-sum/)
 */

fileprivate func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var dic = [Int: Int]()
    return nums
        .enumerated()
        .reduce(into: [Int]()) { acc, seq in
            let num = seq.element
            let index = seq.offset
            let difference = target - num
            if let diff = dic[difference] {
                acc = [diff, index]
            }
            dic[num] = index
    }
}

import XCTest

final class TwoSum: XCTestCase {
    func test() {
        print(twoSum([2,7,11,15], 9))
    }
}

