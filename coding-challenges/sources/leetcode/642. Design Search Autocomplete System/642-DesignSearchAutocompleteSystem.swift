

fileprivate class TrieNode {
    var children: [Character: TrieNode] = [:]
    var sentences: [String: Int] = [:]
}

fileprivate class Trie {
    var root: TrieNode

    init() {
        root = TrieNode()
    }

    func insert(_ sentence: String, _ times: Int) {
        var node = root
        for c in sentence {
            if node.children[c] == nil {
                node.children[c] = TrieNode()
            }
            node = node.children[c]!
            node.sentences[sentence, default: 0] += times
        }
    }

    func search(_ prefix: String) -> [String] {
        var node = root
        for c in prefix {
            guard let nextNode = node.children[c] else {
                return []
            }
            node = nextNode
        }
        let sortedSentences = node.sentences.sorted {
            $0.value > $1.value || ($0.value == $1.value && $0.key < $1.key)
        }
        return sortedSentences.prefix(3).map { $0.key }
    }
}
fileprivate class AutocompleteSystem {
    var trie: Trie
    var currentPrefix: String

    init(_ sentences: [String], _ times: [Int]) {
        trie = Trie()
        currentPrefix = ""

        for (sentence, time) in zip(sentences, times) {
            trie.insert(sentence, time)
        }
    }

    func input(_ c: Character) -> [String] {
        if c == "#" {
            trie.insert(currentPrefix, 1)
            currentPrefix = ""
            return []
        } else {
            currentPrefix.append(c)
            return trie.search(currentPrefix)
        }
    }
}

import XCTest

import XCTest

class AutocompleteSystemTests: XCTestCase {

    func testAutocompleteSystem() {
        let sentences = ["i love you", "island", "iroman", "i love leetcode"]
        let times = [5, 3, 2, 2]
        let autocomplete = AutocompleteSystem(sentences, times)

        XCTAssertEqual(autocomplete.input("i"), ["i love you", "island", "i love leetcode"])

        XCTAssertEqual(autocomplete.input(" "), ["i love you", "i love leetcode"])

        XCTAssertEqual(autocomplete.input("a"), [])

        XCTAssertEqual(autocomplete.input("#"), [])

    }

}

