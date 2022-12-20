

fileprivate final class Node {
    var value: String
    var left: Node?
    var right: Node?

    init(_ value: String,
         _ left: Node? = nil,
         _ right: Node? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}

fileprivate func serialize(root: Node?) -> String {
    guard let root = root else { return "#" }

    return "\(root.value) \(serialize(root: root.left)) \(serialize(root: root.right))"
}

fileprivate func deserialize(data: String) -> Node? {
    func buildTree(_ serializedStrings: inout [String]) -> Node? {
        guard !serializedStrings.isEmpty else { return nil }

        let value = serializedStrings.removeLast()

        guard value != "#" else { return nil }
        
        let root = Node(value)
        root.left = buildTree(&serializedStrings)
        root.right = buildTree(&serializedStrings)
        return root
    }

    var serializedStrings = data.split(separator: " ")
        .reversed()
        .map(String.init)
    return buildTree(&serializedStrings)
}

import XCTest

final class Day3: XCTestCase {

    func test() {
        let node = Node("root", Node("left", Node("left.left")), Node("right"))
        let serializedString = serialize(root: node)
        XCTAssertEqual(deserialize(data: serializedString)!.left!.left!.value, "left.left")
    }
}
