

fileprivate func cons<A, B>(_ a: A, _ b: B) -> (() -> (A, B)) {
    return { () -> (A, B) in
        return (a, b)
    }
}

fileprivate func car<A, B>(_ f: () -> (A, B)) -> A {
    let (a, _) = f()
    return a
}

fileprivate func cdr<A, B>(_ f: () -> (A, B)) -> B {
    let (_, b) = f()
    return b
}

import XCTest

final class Day5: XCTestCase {
    func test() {
        XCTAssertEqual(car(cons(3, 4)), 3)
        XCTAssertEqual(cdr(cons(3, 4)), 4)
    }
}
