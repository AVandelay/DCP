fileprivate struct Autocomplete {
    let trie = Trie()

    func insert(_ word: String) {
        trie.insert(word)
    }

    func autocomplete(prefix: String) -> [String] {
        return trie.autocomplete(prefix: prefix)
    }
}

fileprivate final class TrieNode {
    var children = [Character: TrieNode]()
    var isEnd = false
    var word: String?
}

fileprivate final class Trie {
    let root = TrieNode()

    func insert(_ word: String) {
        var node = root
        for char in word {
            if node.children[char] == nil {
                node.children[char] = TrieNode()
            }
            node = node.children[char]!
        }
        node.isEnd = true
        node.word = word
    }

    func autocomplete(prefix: String) -> [String] {
        var node = root
        for char in prefix {
            if let child = node.children[char] {
                node = child
            } else {
                return []
            }
        }
        var result = [String]()
        var queue = [TrieNode]()
        queue.append(node)

        while !queue.isEmpty {
            let current = queue.removeFirst()
            if current.isEnd {
                result.append(current.word!)
            }
            for child in current.children.values {
                queue.append(child)
            }
        }

        return result
    }
}



import XCTest

final class Day11: XCTestCase {
    func test() {
        let words = ["dog", "deer", "deal"]
        let autocomplete = Autocomplete()
        for word in words {
            autocomplete.insert(word)
        }
        let result = autocomplete.autocomplete(prefix: "de")
        XCTAssertTrue(result.contains("deal"))
        XCTAssertTrue(result.contains("deer"))
    }
}
