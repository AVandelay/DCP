

import Foundation

fileprivate extension Double {
    func pow(_ exponent: Int) -> Double {
        return Foundation.pow(self, Double(exponent))
    }
}

fileprivate func estimatePi(iterations: Int) -> Double {
    // Radius of the unit circle
    let radius = 1.0
    // Coordinates for the center of unit circle
    let circleX = 0.5
    let circleY = 0.5
    // Square of the radius to check if points fall within unit circle
    let radiusSquared = radius.pow(2)

    // Sequence of random points in unit square
    let points = (0..<iterations).map{ _ in
        (Double.random(in: -1..<1), Double.random(in: -1..<1))
    }
    // Filter points to those that are within unit circle
    let pointsInCircle = points.filter { (x, y) in (x - circleX) * (x - circleX) + (y - circleY) * (y - circleY) < radiusSquared }

    // Calculate the fraction of points that fall within the circle
    let fractionInside = Double(pointsInCircle.count) / Double(iterations)

    // Return the estimate of π according to the formula: π = 4 * (number of points in circle / total number of points)
    return 4.0 * fractionInside
}

import Combine

fileprivate func piEstimatePublisher(iterations: Int) -> AnyPublisher<Double, Never> {
    // Radius of the unit circle
    let radius = 1.0
    // Coordinates for the center of unit circle
    let circleX = 0.5
    let circleY = 0.5
    // Square of the radius to check if points fall within unit circle
    let radiusSquared = radius.pow(2)

    // Create a sequence of random points in the unit square.
    let points = (0..<iterations).publisher
        .flatMap { _ -> AnyPublisher<(Double, Double), Never> in
            // Generate a random point.
            let x = Double.random(in: -1..<1)
            let y = Double.random(in: -1..<1)
            // Return a publisher that emits the point.
            return Just((x, y)).eraseToAnyPublisher()
        }
    // Filter the points to only include those that fall within the unit circle.
    let pointsInCircle = points
        .flatMap { (x, y) -> AnyPublisher<Bool, Never> in
            // Check if the point falls within the unit circle.
            if (x - circleX).pow(2) + (y - circleY).pow(2) < radiusSquared {
                // Return a publisher that emits `true`.
                return Just(true).eraseToAnyPublisher()
            } else {
                // Return a publisher that emits `false`.
                return Just(false).eraseToAnyPublisher()
            }
        }
        .map { _ in 1 }
        .scan(0, +)
        .eraseToAnyPublisher()
    // Calculate the fraction of points that fall within the circle
    let fractionInside = pointsInCircle
        .map { Double($0) / Double(iterations) }
    // Return the estimate of π according to the formula: π = 4 * (number of points in circle / total number of points)
    return fractionInside
        .map { 4.0 * $0 }
        .eraseToAnyPublisher()
}
import XCTest

final class Day14: XCTestCase {
    let iterations = 1000000
    let expectedPi = 3.141
    let piTolerance = 0.001

    func _test_estimatePi() {
        let pi = estimatePi(iterations: iterations)
        let roundedPi = (pi * 1000).rounded() / 1000
        XCTAssertEqual(roundedPi, expectedPi, accuracy: piTolerance)
    }

    func _test_estimatePiPublisher() {
        let piEstimate = piEstimatePublisher(iterations: iterations)
          .sink(receiveCompletion: { completion in
            if case .failure(let error) = completion {
                XCTFail("Publisher completed with error: \(error)")
            }
          }, receiveValue: { pi in
            // Round the estimate of pi to 3 decimal places.
            let roundedPi = (pi * 1000).rounded() / 1000
              XCTAssertEqual(roundedPi, self.expectedPi, accuracy: self.piTolerance)
          })
        // Wait for the publisher to complete.
        let expectation = XCTestExpectation(description: "Publisher completed")
        piEstimate.cancel()
        expectation.fulfill()
        wait(for: [expectation], timeout: 1)
    }
}
