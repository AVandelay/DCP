

fileprivate func isRectangleOverlap(_ rec1: [Int], _ rec2: [Int]) -> Bool {
    return !(rec1[2] <= rec2[0] ||  // left
             rec1[3] <= rec2[1] ||  // bottom
             rec1[0] >= rec2[2] ||  // right
             rec1[1] >= rec2[3])    // top
}

import XCTest

final class RectangleOverlapTests: XCTestCase {
    func test() {
        var rec1 = [0, 0, 2, 2]
        var rec2 = [1, 1, 3, 3]
        XCTAssertTrue(isRectangleOverlap(rec1, rec2))

        rec1 = [0, 0, 1, 1]
        rec2 = [1, 0, 2, 1]
        XCTAssertFalse(isRectangleOverlap(rec1, rec2))

        rec1 = [0, 0, 1, 1]
        rec2 = [2, 2, 3, 3]
        XCTAssertFalse(isRectangleOverlap(rec1, rec2))
    }
}
