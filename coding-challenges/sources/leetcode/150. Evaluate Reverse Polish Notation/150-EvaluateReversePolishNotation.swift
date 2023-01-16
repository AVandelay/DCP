

func evalRPN(_ tokens: [String]) -> Int {
    // Arithmetic Logic Unit
    let alu: [String: (Int, Int) -> Int] = [
        "+": { x, y in x + y },
        "-": { x, y in x - y },
        "*": { x, y in x * y },
        "/": { x, y in x / y }
    ]

    // stack to store the digits in the expression
    var stack = [Int]()

    var first = 0
    var second = 0
    var tokens = tokens

    // iterate through the tokens
    while !tokens.isEmpty {
        let token = tokens.removeFirst()
        if let operation = alu[token] {
            // if the token is an operator, pop the last two numbers from the digitsStack
            second = stack.removeLast()
            first = stack.removeLast()
            // perform the operation and append the results to the stack
            stack.append(operation(first, second))
        } else {
            // if the token is a number, append it to the stack
            stack.append(Int(token)!)
        }
    }

    // return the final result which is the last element of the stack
    return stack.removeLast()
}

import XCTest

final class EvaluateReversePolishNotationTests: XCTestCase {
    func test() {
        XCTAssertEqual(evalRPN(["2","1","+","3","*"]), 9)
    }
}
