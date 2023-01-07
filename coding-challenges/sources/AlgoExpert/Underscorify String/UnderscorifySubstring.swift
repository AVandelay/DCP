

// Define a named tuple to represent the intervals of the substring
typealias SubstringInterval = (start: Int, end: Int)

func underscorifySubstring(string: String, substring: String) -> String {
    // Collect the intervals of the substring within the main string
    let intervals = string.enumerated().reduce([SubstringInterval](), { (intervals, enumeratedChar) -> [SubstringInterval] in
        let (i, _) = enumeratedChar
        if i + substring.count > string.count {
            return intervals
        }
        let startIndex = string.index(string.startIndex, offsetBy: i)
        let endIndex = string.index(string.startIndex, offsetBy: i + substring.count - 1)
        let currentSubstring = String(string[startIndex...endIndex])
        if currentSubstring == substring {
            return intervals + [(start: i, end: i + substring.count)]
        }
        return intervals
    })

    // If the main string does not contain the substring, return the main string as is
    if intervals.isEmpty {
        return string
    }

    // Merge the overlapping intervals
    let mergedIntervals = intervals.reduce([SubstringInterval](), { (mergedIntervals, interval) -> [SubstringInterval] in
        if mergedIntervals.isEmpty {
            return [interval]
        }
        let lastInterval = mergedIntervals.last!
        if interval.start <= lastInterval.end {
            let newInterval = (start: lastInterval.start, end: max(lastInterval.end, interval.end))
            return Array(mergedIntervals[0..<mergedIntervals.count-1]) + [newInterval]
        }
        return mergedIntervals + [interval]
    })
    // Initialize the output string
    var output = ""

    // Iterate over the merged intervals and add underscores around them
    var currentIndex = string.startIndex
    for interval in mergedIntervals {
        let start = interval.0
        let end = interval.1
        // Add the characters in the main string before the current interval
        output += String(string[currentIndex..<string.index(string.startIndex, offsetBy: start)])
        // Add an opening underscore
        output += "_"
        // Add the characters in the current interval
        output += String(string[string.index(string.startIndex, offsetBy: start)..<string.index(string.startIndex, offsetBy: end)])
        // Add a closing underscore
        output += "_"
        // Update the current index to the end of the current interval
        currentIndex = string.index(string.startIndex, offsetBy: end)
    }
    // Add the remaining characters in the main string after the last interval
    output += String(string[currentIndex...])

    return output
}

import XCTest

final class UnderscorifySubstringTests: XCTestCase {
    func test() {
        let string = "testthis is a testtest to see if testestest it works"
        let substring = "test"
        XCTAssertEqual(underscorifySubstring(string: string, substring: substring), "_test_this is a _testtest_ to see if _testestest_ it works")
    }
}
