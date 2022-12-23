

fileprivate func cons<A, B>(_ a: A, _ b: B) -> (() -> (A, B)) {
    return { () -> (A, B) in
        return (a, b)
    }
}

fileprivate func car<A, B>(pair: () -> (A, B)) -> A {
    let (a, _) = pair()
    return a
}

fileprivate func cdr<A, B>(pair: () -> (A, B)) -> B {
    let (_, b) = pair()
    return b
}

import XCTest

final class Day5: XCTestCase {
    func test() {
        let pair = cons(3, 4)
        XCTAssertEqual(car(pair: pair), 3)
        XCTAssertEqual(cdr(pair: pair), 4)
    }
}
