

/**
 *
 *  Calculate function takes in an arithmetic expression as a string and returns the evaluated result as an int.
 *
 *  This function uses the Shunting Yard algorithm to convert the given infix expression to Reverse Polish Notation (RPN) and then uses a stack to evaluate the RPN expression.
 *
 *  - Parameters:
 *      - s: arithmetic expression as a string
 *  - Returns:
 *      - int representing the result of the evaluated arithmetic expression
 *  - Complexity:
 *      - Time: `O(n)` where n is the length of the input string
 *      - Space: `O(n)` where n is the length of the input string
 *
*/

func calculate(_ s: String) -> Int {
    // queue to store the output values in reverse polish notation
    var outputQueue = [String]()
    // stack to store the operators
    var operatorsStack = [Character]()
    // track whether the next operator is treated a unary operator
    var isUnary = true

    // loop through the input string
    var i = 0
    while i < s.count {
        // The current character
        let char = s[s.index(s.startIndex, offsetBy: i)]

        // ignore whitespaces
        guard !char.isWhitespace else { continue }

        if isUnary {
            // if the next operator is unary,
            // treat it as a positive integer
            isUnary = false
            if char == "+" || char == "-" {
                outputQueue.append("0")
            }
        }

        if char.isNumber {
            var num = String(char)
            // gather all the digits together
            while i + 1 < s.count,
                  s[s.index(s.startIndex, offsetBy: i + 1)].isNumber {
                num += String(s[s.index(s.startIndex, offsetBy: i + 1)])
                i += 1
            }
            // add the digits to the outputQueue
            outputQueue.append(num)
        }

        else if char == "(" {
            // if the character is an open parenthesis, push it to the operatorsStack
            isUnary = true
            operatorsStack.append(char)
        }

        else if char == ")" {
            // if the character is a close parenthesis, pop the operators from the operatorsStack
            // and adds it to the output queue until it finds an open parenthesis
            while operatorsStack.last != "(" {
                outputQueue.append(String(operatorsStack.removeLast()))
            }
            operatorsStack.removeLast()
        }

        else {
            // if the next character is an operator, it checks the operator precedence and pops operators
            // from the operatorsStack and adds them and adds it to the outputQueue until the stack is empty
            // or the operator at the top of the stack has lower precedence. It then pushes the current operator
            // to the operatorStack
            while !operatorsStack.isEmpty,
                  operatorsStack.last != "(",
                  precedenceValue(of: char) <= precedenceValue(of: operatorsStack.last!) {
                outputQueue.append(String(operatorsStack.removeLast()))
            }
            operatorsStack.append(char)
        }

        i += 1
    }

    while !operatorsStack.isEmpty {
        // pop the remaining operators from the operatorsStack
        outputQueue.append(String(operatorsStack.removeLast()))
    }

    // return the evaluated reverse polish notation expression
    return rpnCalculation(values: &outputQueue)
}

/**
 *  Helper function that returns the precedence of an operator
 *
 *  - Parameter operator: the operator to check the precedence of
 *  - Returns Int: the precedence of the operator (2 for multiplication/division, 1 for addition/subtraction
 *  - Complexity:
 *      - Time: `O(1)`
 *      - Space: `O(1)`
 */
private func precedenceValue(of `operator`: Character) -> Int {
    // Check the precedence of the operator.
    // Multiplication and division have higher precedence than addition and subtraction
    switch true {
    case `operator` == "*", `operator` == "/": return 2
    case `operator` == "+", `operator` == "-": return 1
    default: fatalError("Unknown operator")
    }
}

/**
 *  Helper function takes in an array of values in reverse polish notation and evaluates the expression
 *
 *  - Parameter outputQueue: the values in reverse polish notation
 *  - Returns Int: representing the evaluated value of the expression
 *  - Complexity:
 *      - Time: `O(n)` where n is the number of elements in the outputStack array.
 *      - Space: `O(n)` where n is the number of elements in the outputStack array.
 *
 *  The function uses an array to hold the values in the expression and an dictionary to hold the operations.
 *  It loops through the outputStack array, for each element it checks if it is an operation or a value.
 *  If it is a value, it pushes it onto the value array. If it is an operation, it pops the last two values off
 *  the value array, performs the operation and pushes the result back onto the value array.
 *  It continues this process until the outputStack array is empty.
 *  The final value in the value array is returned as the evaluated result.
 */
private func rpnCalculation(values outputQueue: inout [String]) -> Int {
    // dictionary to store the Arithmetic Logic Unit
    let alu: [String: (Int, Int) -> Int] = [
        "+": { x, y in x + y },
        "-": { x, y in x - y },
        "*": { x, y in x * y },
        "/": { x, y in x / y }
    ]

    // stack to store the numbers in the RPN expression
    var numStack = [Int]()

    var first = 0
    var second = 0

    // iterate through the outputQueue
    while !outputQueue.isEmpty {
        let token = outputQueue.removeFirst()
        if let operation = alu[token] {
            // if the token is an operator, pop the last two numbers from the numStack
            second = numStack.removeLast()
            first = numStack.removeLast()
            // perform the operation and append the result to the numStack
            numStack.append(operation(first, second))
        } else {
            // if the token is a number, append it to the numStack
            numStack.append(Int(token)!)
        }
    }
    // return the final result which is the last element in the numStack
    return numStack.removeLast()
}

import XCTest

final class BasicCalculatorIIITests: XCTestCase {
    func test() {
        XCTAssertEqual(calculate("1+1"), 2)
        XCTAssertEqual(calculate("6-4/2"), 4)
        XCTAssertEqual(calculate("2*(5+5*2)/3+(6/2+8)"), 21)
    }
}
