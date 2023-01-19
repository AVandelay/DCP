

/**
 Finds all universal strings in words1.
 A string b is a subset of string a if every letter in b occurs in a including multiplicity.
 A string a from words1 is universal if for every string b in words2, b is a subset of a.

 - Parameters:
     - words1: The array of strings to check for universality
     - words2: The array of strings to use as subsets
 - Returns:
    An array of all the universal strings in words1. The order of the returned strings is not guaranteed.
 - Complexity:
    - Time: `O(n*m)`    Where n is the total number of letters in words1 and m is the total number of letters in words2.
                    The function iterates over words1, and for each word it iterates over words2. For each
                    word it counts the number of occurrences of each letter in the word. This is done using
                    the helper function `countLetterOccurrences` which has a Time Complexity of `O(n)` where
                    `n` is the length of the word.
    - Space: `O(n+m)`
 */
fileprivate func wordSubsets(_ words1: [String], _ words2: [String]) -> [String] {
    /**
     Counts the number of occurrences of each letter in a word
     - Parameters:
        - word: The word to count the letter occurrences for
     - Returns:
        A dictionary where the keys are letters and the values are the number of occurrences of that letter in the word
     - Complexity:
        - Time: `O(n)` where n is the length of the word
        - Space: `O(n)`
     */
    func countLetterOccurrences(in word: String) -> [Character: Int] {
        var letterFrequencies = [Character: Int]()
        for letter in word {
            letterFrequencies[letter, default: 0] += 1
        }

        return letterFrequencies
    }

    var maxCounts = [Character: Int]()
    for word in words2 {
        for (letter, count) in countLetterOccurrences(in: word) {
            // Finding the max count of each letter in all words in words2
            maxCounts[letter, default: 0] = max(maxCounts[letter, default: 0], count)
        }
    }

    var universalWords = [String]()
    for word in words1 {
        var isUniversal = true
        for (letter, count) in maxCounts {
            if count > (countLetterOccurrences(in: word)[letter] ?? 0) {
                isUniversal = false
                break
            }
        }
        if isUniversal {
            universalWords.append(word)
        }
    }

    return universalWords
}

import XCTest

final class WordSubsetsTests: XCTestCase {
    func test() {
        var words1 = ["amazon","apple","facebook","google","leetcode"]
        var words2 = ["e","o"]
        var expectation = ["facebook","google","leetcode"]
        XCTAssertEqual(wordSubsets(words1, words2), expectation)

        words1 = ["amazon","apple","facebook","google","leetcode"]
        words2 = ["l","e"]
        expectation = ["apple","google","leetcode"]
        XCTAssertEqual(wordSubsets(words1, words2), expectation)
    }
}
