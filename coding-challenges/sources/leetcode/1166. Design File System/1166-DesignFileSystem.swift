

fileprivate class TrieNode {
    var name: String
    var value: Int
    var children: [String: TrieNode]

    init(name: String, value: Int = -1, children: [String : TrieNode] = [:]) {
        self.name = name
        self.value = value
        self.children = children
    }
}

fileprivate class Trie {
    var root: TrieNode

    init() {
        root = TrieNode(name: "/")
    }

    func insert(path: String, value: Int) -> Bool {
        var currentNode = root

        guard currentNode.value == -1 else { return false }

        let components = path.split(separator: "/").map { String($0) }
        guard !components.isEmpty else { return false }

        for component in components {
            if currentNode.children[component] == nil {

                guard component == components.last else { return false }
                let newNode = TrieNode(name: component)
                currentNode.children[component] = newNode

            }

            currentNode = currentNode.children[component]!
        }

        currentNode.value = value
        return true
    }

    func contains(path: String) -> Int {
        var currentNode = root

        let components = path.split(separator: "/").map { String($0) }
        guard !components.isEmpty else { return -1 }

        for component in components {

            guard let nextNode = currentNode.children[component] else { return -1 }
            currentNode = nextNode

        }

        return currentNode.value
    }
}

fileprivate class FileSystem {

    private var trie = Trie()

    func createPath(_ path: String, _ value: Int) -> Bool {
        trie.insert(path: path, value: value)
    }

    func get(_ path: String) -> Int {
        trie.contains(path: path)
    }
}

import XCTest

final class DesignFileSystemTests: XCTestCase {
    func test() {
        var fileSystem = FileSystem()
        XCTAssertTrue(fileSystem.createPath("/a", 1))
        XCTAssertEqual(fileSystem.get("/a"), 1)

        fileSystem = FileSystem()
        XCTAssertTrue(fileSystem.createPath("/leet", 1))
        XCTAssertTrue(fileSystem.createPath("/leet/code", 2))
        XCTAssertEqual(fileSystem.get("/leet/code"), 2)
        XCTAssertFalse(fileSystem.createPath("/c/d", 1))
        XCTAssertEqual(fileSystem.get("/c"), -1)
    }
}
