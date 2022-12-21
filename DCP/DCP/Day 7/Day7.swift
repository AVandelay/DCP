

fileprivate func encodingsCount(input: String) -> Int {
    let characters = Array(input)
    var cache = Array(repeating: 0, count: characters.count)

    for i in 0..<cache.count {
        // consider 1 digit
        if characters[i] != "0" {
            cache[i] += (i >= 1) ? cache[i-1] : 1
        }

        // consider 2 digits
        if i >= 1 {
            guard let combined = Int(
                characters[i-1...i]
                    .map(String.init)
                    .joined()
            ) else {
                fatalError()
            }

            if 10...26 ~= combined {
                cache[i] += (i >= 2) ? cache[i-2] : 1
            }

        }
    }

    return cache.last ?? 0
}

import XCTest

final class Day7: XCTestCase {
    func test() {
        XCTAssertEqual(encodingsCount(input: "111"), 3)
        XCTAssertEqual(encodingsCount(input: "001"), 0)
    }
}
