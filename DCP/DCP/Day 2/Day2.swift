

func products(_ nums: [Int]) -> [Int] {
    let prefixProducts = nums
        .reduce(into: [Int]()) { array, value in
            if let last = array.last {
                array.append(last * value)
            } else {
                array.append(value)
            }
        }

    let suffixProducts = Array(nums
        .reversed()
        .reduce(into: [Int]()) { array, value in
            if let last = array.last {
                array.append(last * value)
            } else {
                array.append(value)
            }
        }
        .reversed())

    let result = nums
        .indices
        .reduce(into: [Int]()) { array, index in
            if index == 0 {
                array.append(suffixProducts[index + 1])
            } else if index == nums.count - 1 {
                array.append(prefixProducts[index - 1])
            } else {
                array.append(prefixProducts[index - 1] * suffixProducts[index + 1])
            }
        }

    return result
}

import XCTest

final class Day2: XCTestCase {

    func test() {
        XCTAssertEqual(products([1, 2, 3, 4, 5]), [120, 60, 40, 30, 24])
        XCTAssertEqual(products([3, 2, 1]), [2, 3, 6])
    }
}
