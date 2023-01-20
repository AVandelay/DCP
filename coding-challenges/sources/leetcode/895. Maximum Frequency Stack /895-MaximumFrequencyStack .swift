

fileprivate final class FreqStack {
    // Keeps track of the frequency of each element in the stack
    var freqMap = [Int: Int]()
    // 2D array where each index represents a frequency and the
    // array at that index contains the elements that have that
    // frequency
    var stacks = [[Int]]()

    /**
     Initializes an empty frequency stack
     */
    init() { }

    /**
     Pushes an integer val onto the top of the stack
     - Parameter val: The integer to be pushed onto the stack
     - Time Complexity: `O(1)`
     */
    func push(_ val: Int) {
        // get the frequency of val
        let freq = freqMap[val, default: 0]
        // increment the frequency of val
        freqMap[val] = freq + 1

        // if frequency of val is not yet represented in the stack,
        // add an empty array at that index
        if freq == stacks.count {
            stacks.append([])
        }
        // add the element to the array at the index of its frequency
        stacks[freq].append(val)
    }

    /**
     Removes and returns the most frequent element in the stack
     If there is a tie for the most frequent element, the element closest to the stack's top is removed and returned.
     - Returns: The most frequent element in the stack, or nil if the stack is empty
     Time complexity: O(1)
     */
    func pop() -> Int? {
        // Get the last element of the stacks
        var freqStack = stacks.last!

        // remove the last element from the stacks
        let val = freqStack.removeLast()
        // decrement the frequency of the removed element
        freqMap[val, default: 0] -= 1

        // if the freqStack is empty remove the last element
        if freqStack.isEmpty {
            stacks.removeLast()
        } else {
            // update the last element if it isn't empty
            stacks[stacks.count - 1] = freqStack
        }

        return val
    }
}

import XCTest

class FreqStackTests: XCTestCase {
    func test() {
        let stack = FreqStack()
        stack.push(5)
        stack.push(7)
        stack.push(5)
        stack.push(7)
        stack.push(4)
        stack.push(5)
        XCTAssertEqual(stack.pop(), 5)
        XCTAssertEqual(stack.pop(), 7)
        XCTAssertEqual(stack.pop(), 5)
        XCTAssertEqual(stack.pop(), 4)
    }
}
