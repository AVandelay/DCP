

fileprivate func isAnagram(_ s: String, t: String) -> Bool {
    guard s.count == t.count else { return false }

    let frequencyS = s.reduce(into: [:]) { (counts, char) in
        counts[char, default: 0] += 1
    }

    let frequencyT = t.reduce(into: frequencyS) { (counts, char) in
        counts[char, default: 0] -= 1
    }

    return frequencyT.values.allSatisfy { $0 == 0 }
}

import XCTest

final class ValidAnagramTests: XCTestCase {
    func test() {
        XCTAssertTrue(isAnagram("anagram", t: "nagaram"))
        XCTAssertFalse(isAnagram("rat", t: "car"))
    }
}
