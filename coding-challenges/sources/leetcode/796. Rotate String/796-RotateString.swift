

func rotateString(_ s: String, _ goal: String) -> Bool {
    guard s.count == goal.count else { return false }

    var shifted = s

    for _ in 0..<s.count {
        if shifted == goal {
            return true
        }
        shifted.append(shifted.removeFirst())
    }

    return false
}

import XCTest

final class RotateStringTests: XCTestCase {
    func testRotateString() {
        XCTAssertTrue(rotateString("abcde", "cdeab"))
        XCTAssertFalse(rotateString("abcde", "abced"))
    }
}
