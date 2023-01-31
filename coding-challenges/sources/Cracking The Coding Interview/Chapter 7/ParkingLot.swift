

enum PaymentMethod {
    case creditCard
    case cash
}

enum SpotType {
    case regular
    case designated
}

struct Spot {
    var spotType: SpotType
    var occupied: Bool
}

class Floor {
    var spots: [Spot]

    init(spots: [Spot]) {
        self.spots = spots
    }
}

class Gate {
    var floor: Floor

    init(floor: Floor) {
        self.floor = floor
    }

    func enter(paymentMethod: PaymentMethod) {
        // implementation for entering the ParkingLot
    }

    func exit() {
        // implementation for leaving the ParkingLot
    }
}

class PassHolder {
    var hasValidPass: Bool

    init(hasValidPass: Bool) {
        self.hasValidPass = hasValidPass
    }
}

class OneTimeUser {
    var paymentMethod: PaymentMethod

    init(paymentMethod: PaymentMethod) {
        self.paymentMethod = paymentMethod
    }
}

class ParkingLot {
    var floors: [Floor]
    var gates: [Gate]
    var passHolders: [PassHolder]
    var oneTimeUsers: [OneTimeUser]

    init(floors: [Floor], gates: [Gate], passHolders: [PassHolder], oneTimeUsers: [OneTimeUser]) {
        self.floors = floors
        self.gates = gates
        self.passHolders = passHolders
        self.oneTimeUsers = oneTimeUsers
    }
}
