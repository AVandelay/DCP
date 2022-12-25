import Combine
import Foundation

fileprivate final class JobScheduler {
    private let queue = DispatchQueue(label: "com.example.JobScheduler")

    func schedule(f: @escaping () -> Void, after n: Int) {
        queue.asyncAfter(deadline: .now() + .milliseconds(n)) {
            f()
        }
    }

    func combineSchedule(f: @escaping () -> Void, after n: Int) -> AnyCancellable {
        return Timer
            .publish(every: TimeInterval(n), on: RunLoop.main, in: .common)
            .autoconnect()
            .sink { _ in
                f()
            }
    }
}

fileprivate extension Task where Success == Never, Failure == Never {
    static func schedule(f: @escaping () -> Void, after n: Int) async throws {
        try await Task.sleep(until: .now + .milliseconds(n), clock: .continuous)
    }
}

import XCTest

final class Day10: XCTestCase {
    fileprivate let scheduler = JobScheduler()

    func test_asyncAfter() {
        let start = CFAbsoluteTimeGetCurrent()

        scheduler.schedule(f: {
            let diff = CFAbsoluteTimeGetCurrent() - start
            XCTAssertEqual(diff, 1, accuracy: 1.0)
        }, after: 1000)
    }

    func test_combine() {
        let start = CFAbsoluteTimeGetCurrent()

        let cancellable = scheduler.combineSchedule(f: {
            let diff = CFAbsoluteTimeGetCurrent() - start
            XCTAssertEqual(diff, 1, accuracy: 1.0)
        }, after: 1000)

        cancellable.cancel()
    }

    func test_task() async {
        let start = CFAbsoluteTimeGetCurrent()

        try? await Task.schedule(f: {
            let diff = CFAbsoluteTimeGetCurrent() - start
            XCTAssertEqual(diff, 1, accuracy: 1.0)
        }, after: 1000)
    }


}
