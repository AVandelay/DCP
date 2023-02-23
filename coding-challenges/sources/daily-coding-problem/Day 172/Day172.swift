

fileprivate func findSubstringIndices(s: String, words: [String]) -> [Int] {
    let wordLength = words[0].count
    let totalWords = words.count
    let totalLength = wordLength * totalWords
    var wordCounts = [String: Int]()
    var result = [Int]()

    // Store the counts of each word in a dictionary
    for word in words {
        wordCounts[word, default: 0] += 1
    }

    // Check each substring of length totalLength
    for i in 0...(s.count - totalLength) {
        var seenWords = [String: Int]()
        var j = i

        // Check each word of length wordLength
        while j < i + totalLength {
            let wordStartIndex = s.index(s.startIndex, offsetBy: j)
            let wordEndIndex = s.index(wordStartIndex, offsetBy: wordLength)
            let word = String(s[wordStartIndex..<wordEndIndex])

            if let count = wordCounts[word],
               count > (seenWords[word] ?? 0) {
                seenWords[word, default: 0] += 1
                j += wordLength
            } else {
                // The current word is not in words or has already been seen too many times
                break
            }
        }

        if seenWords == wordCounts {
            result.append(i)
        }
    }

    return result
}

import XCTest

final class Day172: XCTestCase {
    func testFindSubstringIndices() {
        let s1 = "dogcatcatcodecatdog"
        let words1 = ["cat", "dog"]
        let result1 = findSubstringIndices(s: s1, words: words1)
        XCTAssertEqual(result1, [0, 13])

        let s2 = "barfoobazbitbyte"
        let words2 = ["dog", "cat"]
        let result2 = findSubstringIndices(s: s2, words: words2)
        XCTAssertEqual(result2, [])

        let s3 = "foobarbazbarbaz"
        let words3 = ["bar", "baz"]
        let result3 = findSubstringIndices(s: s3, words: words3)
        XCTAssertEqual(result3, [3, 6, 9])

        let s4 = "abababab"
        let words4 = ["ab"]
        let result4 = findSubstringIndices(s: s4, words: words4)
        XCTAssertEqual(result4, [0, 2, 4, 6])

        let s5 = "aabbccddeeffgghh"
        let words5 = ["xx", "bb", "cc", "dd", "ee", "ff"]
        let result5 = findSubstringIndices(s: s5, words: words5)
        XCTAssertEqual(result5, [])
    }

}
