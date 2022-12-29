
/// [Reservoir sampling](https://en.wikipedia.org/wiki/Reservoir_sampling)
///  1. Initialize a variable reservoir to be the first element in the stream.
///  2. Iterate through the stream, keeping track of the current element and the number of elements seen so far (starting at 1). Let the current element be x and the number of elements seen be n.
///  3. Generate a random number p between 0 and 1.
///  4. If p is less than or equal to 1/n, set reservoir to be x.
///  5. Repeat steps 2-4 for each element in the stream.
func pickRandomElement<T>(stream: AnySequence<T>) -> T? {
    var reservoir: T?
    stream.enumerated().forEach { (n, x) in
        let p = Double.random(in: 0..<1)
        // with probability 1/n, set reservoir to x
        if p <= 1/Double(n) {
            reservoir = x
        }
    }

    return reservoir
}

import XCTest

final class Day15: XCTestCase {
    func test() {
        let stream = [1, 2, 3, 4, 5]
        let randomElement = pickRandomElement(stream: AnySequence(stream))
        XCTAssert(stream.contains(randomElement!))
    }
}
