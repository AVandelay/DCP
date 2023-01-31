

fileprivate struct Request {
    var currentFloor: Int
    var desiredFloor: Int
    var elevatorState: ElevatorState
    var requestedFrom: RequestLocation
}

fileprivate enum ElevatorState {
    case up
    case down
    case idle
}

fileprivate enum RequestLocation {
    case inside
    case outside
}

fileprivate final class Elevator {
    private(set) var currentFloor: Int
    private(set) var elevatorState: ElevatorState
    private var upQueue: [Request]
    private var downQueue: [Request]

    init(currentFloor: Int) {
        self.currentFloor = currentFloor
        self.elevatorState = .idle
        self.upQueue = []
        self.downQueue = []
    }

    func requested(up request: Request) {
        if case .outside = request.requestedFrom {
            upQueue.append(Request(currentFloor: request.currentFloor,
                                   desiredFloor: request.currentFloor,
                                   elevatorState: .up,
                                   requestedFrom: .outside))
            print("Append up request going to floor \(request.currentFloor).")
        }

        upQueue.append(request)
        print("Append up request going to floor \(request.desiredFloor).")
    }

    func requested(down request: Request) {
        if case .outside = request.requestedFrom {
            downQueue.append(Request(currentFloor: request.currentFloor,
                                     desiredFloor: request.currentFloor,
                                     elevatorState: .down,
                                     requestedFrom: .outside))
            print("Append down request going to floor \(request.currentFloor).")
        }

        downQueue.append(request)
        print("Append down request going to floor \(request.desiredFloor).")
    }

    func run() {
        while !upQueue.isEmpty || !downQueue.isEmpty {
            processingRequests()
        }
        print("Finished all requests.")
        self.elevatorState = .idle
    }

    private func processingRequests() {
        if elevatorState == .up || elevatorState == .idle {
            processingRequestUp()
            processingRequestDown()
        } else {
            processingRequestDown()
            processingRequestUp()
        }
    }

    private func processingRequestUp() {
        while !upQueue.isEmpty {
            let upRequest = upQueue.removeFirst()
            currentFloor = upRequest.desiredFloor
            print("Processing up requests. Elevator stopped at floor \(currentFloor).")
        }
        if !downQueue.isEmpty {
            elevatorState = .down
        } else {
            elevatorState = .idle
        }
    }

    private func processingRequestDown() {
        while !downQueue.isEmpty {
            let downRequest = downQueue.removeFirst()
            currentFloor = downRequest.desiredFloor
            print("Processing down requests. Elevator stopped at floor \(currentFloor).")
        }
        if !upQueue.isEmpty {
            elevatorState = .up
        } else {
            elevatorState = .idle
        }
    }
}
