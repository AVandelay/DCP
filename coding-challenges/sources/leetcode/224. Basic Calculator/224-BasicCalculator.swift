

fileprivate func calculate(expression: String) -> Int {
    // initialize variables
    var currentValue = 0
    var number = 0
    var sign: Character = "+"
    let characters = Array(expression)
    var index = 0
    var stack = [(currentValue: Int, sign: Character)]()

    func resetValues() {
        // reset currentValue, number, and sign
        currentValue = 0
        number = 0
        sign = "+"
    }

    while index < characters.endIndex {
        let char = characters[index]

        switch char {
        case "(":
            stack.append((currentValue, sign))
            currentValue = 0
            number = 0
            sign = "+"
        case ")":
            let prev = stack.removeLast()
            currentValue = sign == "+" ? currentValue + number : currentValue - number
            currentValue = prev.sign == "+" ? prev.currentValue + currentValue : prev.currentValue - currentValue

            number = 0
            sign = "+"
        case "+", "-":
            currentValue = sign == "+" ? currentValue + number : currentValue - number
            number = 0
            sign = char
            sign = char
        case "0"..."9":
            number = number * 10 + Int(String(char))!
        default:
            break
        }

        index += 1
    }

    currentValue = sign == "+" ? currentValue + number : currentValue - number
    return currentValue
}

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
fileprivate func calculate(_ s: String) -> Int {

    // return the evaluated reverse polish notation expression
    var queue = shuntingYard(s)
    return evaluateRPN(values: &queue)
}

/**
 *  Shunting Yard Algorithm to convert infix notation to reverse polish notation
 *
 *   - Parameters:
 *       - s: String representing the infix notation
 *
 *   - Returns: An array of strings representing the reverse polish notation
 *
 *   - Complexity: O(n) where n is the length of the input string
*/
private func shuntingYard(_ s: String) -> [String] {
    // queue to store the values in reverse polish notation
    var rpnQueue = [String]()
    // stack to store the operators
    var operatorsStack = [Character]()
    // track whether the next operator is treated as a unary operator
    // i.e. an operation with only one operand (+ and -)
    var isUnary = true

    // iterate through the tokens
    for token in tokenize(s) {
        // check if the operator is unary
        if isUnary {
            isUnary = false
            // if the operator is + or -, add a 0 to the rpnQueue
            if token == "+" || token == "-" {
                rpnQueue.append("0")
            }
        }

        // if the token is a number, append it to the rpnQueue
        if Int(token) != nil {
            rpnQueue.append(token)
        }

        // if the token is an opening parenthesis, set the isUnary flag to true and push the parenthesis to the operator stack
        else if token == "(" {
            isUnary = true
            operatorsStack.append(token.first!)
        }

        // if the token is a closing parenthesis, pop operators from the stack and add them to the rpnQueue
        // until an opening parenthesis is foun
        else if token == ")" {
            while operatorsStack.last != "(" {
                // remove the opening parenthesis from the stack
                rpnQueue.append(String(operatorsStack.removeLast()))
            }
            operatorsStack.removeLast()
        }

        else {
            // while the operator stack is not empty, the top element is not an opening parenthesis
            // and the precedence of the current token is less than or equal to the precedence of the top element
            while !operatorsStack.isEmpty,
                  operatorsStack.last != "(",
                  precedenceValue(of: token.first!) <= precedenceValue(of: operatorsStack.last!) {
                // pop the top element from the operator stack and add it to the rpnQueue
                rpnQueue.append(String(operatorsStack.removeLast()))
            }
            // push the current token to the operator stack
            operatorsStack.append(token.first!)
        }
    }

    while !operatorsStack.isEmpty {
        // pop the remaining operators from the operatorsStack
        rpnQueue.append(String(operatorsStack.removeLast()))
    }

    return rpnQueue
}

/**
 *  Helper function that takes in a string and an index, and returns the next token and the new index.
 *  - Parameters:
 *      - s: The input string.
 *      - index: The current index in the string.
 *  - Returns:
 *      - A tuple containing the next token and the new index.
 *  - Complexity: O(n) where n is the length of the token.
 */
private func nextToken(_ s: String, _ index: inout Int) -> (token: String, index: Int) {
    // store the starting index of the token
    let startIndex = index
    // check if the current character is a number
    if s[s.index(s.startIndex, offsetBy: index)].isNumber {
        // if it is a number, iterate through the string until we reach a non-number character
        while index < s.count,
              s[s.index(s.startIndex, offsetBy: index)].isNumber {
            index += 1
        }
    } else {
        // if it is not a number, increment the index by one
        index += 1
    }
    // create a token from the current index to the new index
    let token = String(s[s.index(s.startIndex, offsetBy: startIndex)..<s.index(s.startIndex, offsetBy: index)])
    // return the token and the new index
    return (token, index)
}

/**
 *  Helper function that takes in a string and tokenizes it into an array of strings.
 *   - Parameters:
 *       - s: The input string.
 *   - Returns:
 *       - An array of strings, each representing a token.
 *  - Complexity: O(n) where n is the length of the input string.
*/
private func tokenize(_ s: String) -> [String] {
    // remove any spaces from the string
    let s = s.replacingOccurrences(of: " ", with: "")
    // start index at 0
    var index = 0
    // array to store the tokens
    var tokens = [String]()
    // iterate through the string
    while index < s.count {
        // get the next token and the new index
        let (token, newIndex) = nextToken(s, &index)
        // update the index to the new index
        index = newIndex
        // append the token to the tokens array
        tokens.append(token)
    }

    return tokens
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
private func evaluateRPN(values queue: inout [String]) -> Int {
    // Arithmetic Logic Unit
    let alu: [String: (Int, Int) -> Int] = [
        "+": { x, y in x + y },
        "-": { x, y in x - y },
        "*": { x, y in x * y },
        "/": { x, y in x / y }
    ]

    // stack to store the digits of the RPN expression
    var digitsStack = [Int]()

    var first = 0
    var second = 0

    // iterate through the outputQueue
    while !queue.isEmpty {
        let token = queue.removeFirst()
        if let operation = alu[token] {
            // if the token is an operator, pop the last two numbers from the digitsStack
            second = digitsStack.removeLast()
            first = digitsStack.removeLast()
            digitsStack.append(operation(first, second))
        } else {
            // if the token is a number, append it to the digitsStack
            digitsStack.append(Int(token)!)
        }
    }

    // return the final result which is the last element in the digitsStack
    return digitsStack.removeLast()
}

import XCTest

final class BasicCalculatorTests: XCTestCase {
    func test() {
        XCTAssertEqual(calculate(expression: "1 + 1"), 2)
        XCTAssertEqual(calculate(expression: " 2-1 + 2 "), 3)
        XCTAssertEqual(calculate(expression: "(1+(4+5+2)-3)+(6+8)"), 23)
        XCTAssertEqual(calculate("1 + 1"), 2)
        XCTAssertEqual(calculate(" 2-1 + 2 "), 3)
        XCTAssertEqual(calculate("(1+(4+5+2)-3)+(6+8)"), 23)
    }
}
