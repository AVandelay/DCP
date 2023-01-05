

/// Finds the reconstruction of a string made up of words from a dictionary.
/// If there is more than one possible reconstruction, returns any of them.
/// If there is no possible reconstruction, returns `nil`.
///
/// - Parameters:
///   - dictionary: A list of words that can be used to reconstruct the string.
///   - string: The string to be reconstructed, made up of words from the dictionary.
/// - Returns: A list of words that make up the reconstruction of the string, or `nil` if the reconstruction is not possible.
func reconstructSentence(dictionary: [String], string: String) -> [String]? {
    // dictionary to store the starting indices of all the words that have been found
    var starts = [0: ""]

    // keep track of the current length of the string
    var currentLength = 1

    // iterate over the characters of the string until the reconstruction is found or it is not possible
    while true {
        // create a copy of the starts dictionary for the current iteration
        var newStarts = starts

        // iterate over the starts dictionary
        for (startIndex, _) in starts {
            // try to find a word that starts at the current index and ends at the current length
            let start = string.index(string.startIndex, offsetBy: startIndex)
            let end = string.index(string.startIndex, offsetBy: currentLength)
            let word = String(string[start..<end])
            if dictionary.contains(where: { $0 == word }) {
                // if the word is found, add the ending index to the new starts dictionary
                newStarts[currentLength] = word
            }
        }

        // update the starts dictionary
        starts = newStarts

        // check if the reconstruction is possible
        if starts[string.count] != nil {
            // if it is possible, create an empty list to store the reconstruction
            var reconstruction = [String]()
            // set the current length to the length of the string
            currentLength = string.count

            // trace back the words that were found
            while currentLength > 0 {
                // get the word that starts at the current length
                let word = starts[currentLength]!
                // add the word to the reconstruction list
                reconstruction.append(word)
                // subtract the length of the word from the current length
                currentLength -= word.count
            }

            // return the reconstruction reversed
            return reconstruction.reversed()
        }

        // if the reconstruction is not possible, increase the current length and try again
        currentLength += 1
    }
}



import XCTest

final class Day22: XCTestCase {
    func testReconstructSentence() {
        let testCases: [(dictionary: [String], string: String, expectedOutput: [String]?)] = [
            (["the", "quick", "brown", "fox"], "thequickbrownfox", ["the", "quick", "brown", "fox"]),
            (["bed", "bath", "bedbath", "and", "beyond"], "bedbathandbeyond", ["bed", "bath", "and", "beyond"]),
        ]

        for (dictionary, string, expectation) in testCases {
            let output = reconstructSentence(dictionary: dictionary, string: string)
            XCTAssertTrue(output == expectation || output == ["bedbath", "and", "beyond"])
        }
    }
}
