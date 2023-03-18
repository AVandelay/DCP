

fileprivate class MaxStack {
    private var mainStack: [Int]
    private var maxStack: [Int]

    init() {
        mainStack = []
        maxStack = []
    }

    func push(_ x: Int) {
        mainStack.append(x) // Push x onto mainStack
        // If maxStack is empty or x >= top of maxStack, push x onto maxStack
        if let lastMax = maxStack.last {
            if x >= lastMax {
                maxStack.append(x)
            } else {
                maxStack.append(lastMax)
            }
        } else {
            maxStack.append(x)
        }
    }

    func pop() -> Int {
        // If top of mainStack == top of maxStack, pop from maxStack
        if let lastMain = mainStack.last, let lastMax = maxStack.last, lastMain == lastMax {
            maxStack.removeLast()
        }
        // Pop and return the top element from mainStack
        return mainStack.removeLast()
    }

    func top() -> Int {
        return mainStack.last! // Return the top element of mainStack
    }

    func peekMax() -> Int {
        return maxStack.last! // Return the top element of maxStack
    }

    func popMax() -> Int {
        guard !maxStack.isEmpty else { return Int() }

        let maxValue = maxStack.removeLast() // Store the top element of maxStack as maxValue
        var tempStack: [Int] = [] // Create a temporary stack
        // While top of mainStack != maxValue, pop from mainStack and push the popped elements onto tempStack
        while mainStack.last! != maxValue {
            tempStack.append(pop())
        }
        _ = pop() // Pop from mainStack and maxStack
        // While tempStack is not empty, pop from tempStack and push the popped elements back onto mainStack,
        // following the push operation logic
        while !tempStack.isEmpty {
            push(tempStack.removeLast())
        }
        return maxValue
    }
}

import XCTest

final class MaxStackTests: XCTestCase {
    func test() {
        let maxStack = MaxStack()
        maxStack.push(5)
        maxStack.push(1)
        maxStack.push(5)
        XCTAssertEqual(maxStack.top(), 5)
        XCTAssertEqual(maxStack.popMax(), 5)
        XCTAssertEqual(maxStack.top(), 1)
        XCTAssertEqual(maxStack.peekMax(), 5)
        XCTAssertEqual(maxStack.pop(), 1)
        XCTAssertEqual(maxStack.top(), 5)
    }
}
