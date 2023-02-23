

/// Converts a given column number to an alphabetical column ID.
///
/// - Parameter columnNumber: The column number to convert.
///
/// - Returns: The alphabetical column ID.
fileprivate func getColumnID(columnNumber: Int) -> String {
    var result = ""
    var number = columnNumber
    while number > 0 {
        let remainder = (number - 1) % 26
        let char = Character(UnicodeScalar(65 + remainder)!)
        result = String(char) + result
        number = (number - remainder) / 26
    }
    return result
}

import XCTest

final class Day212: XCTestCase {
    func testGetColumnID() {
        XCTAssertEqual(getColumnID(columnNumber: 1), "A")
        XCTAssertEqual(getColumnID(columnNumber: 26), "Z")
        XCTAssertEqual(getColumnID(columnNumber: 27), "AA")
    }
}
