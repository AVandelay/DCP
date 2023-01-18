

/**
 LRUCache is a data structure that follows the constraints of a Least Recently Used (LRU) cache.
 It has a fixed capacity and when the capacity is reached, the least recently used key is evicted.
 The class has the following methods:
 - `init(_ capacity: Int)` Initialize the LRU cache with positive size capacity.
 - `get(_ key: Int) -> Int` Return the value of the key if the key exists, otherwise return -1.
 - `put(_ key: Int, _ value: Int)` Update the value of the key if the key exists. Otherwise, add the key-value pair to the cache. If the number of keys exceeds the capacity from this operation, evict the least recently used key.
 All the methods have an average time complexity of O(1)
 */
fileprivate final class LRUCache {

    // MARK: - Types

    /**
     Node class is a private class that is used to store the key-value pairs in the LRUCache.
     Each node has a key, a value, and references to the previous and next nodes in the doubly linked list.
     */
    private class Node {
        var key: Int
        var value: Int
        var prev: Node?
        var next: Node?

        /**
         Initializes a new Node instance with a key and a value.
         - Parameters
            - key: The key
            - value: The value
         */
        init(key: Int, value: Int) {
            self.key = key
            self.value = value
        }
    }

    // MARK: - Private Properties

    private var capacity: Int
    private var cache: [Int: Node] = [:]
    private var head: Node?
    private var tail: Node?

    // MARK: - Initializers

    /**
     Initialize the LRU cache with positive size capacity
     - Parameter capacity: The capacity of the cache
     */
    init(capacity: Int) {
        self.capacity = capacity
    }

    // MARK: - Public Methods

    /**
     Return the value of the key if the key exists, otherwise return -1.
     - Parameter key: The key
     - Returns: the value of the key if the key exists, otherwise return -1
     - Complexity
        - Time: `O(1)`
        - Space: `O(n)` The class uses a dictionary (cache) to store the key-value pairs and a doubly linked list (head and tail) to keep track of the access order
     */
    func get(_ key: Int) -> Int {
        guard let node = cache[key] else { return -1 }

        remove(node)
        addToHead(node)
        return node.value
    }

    /**
     Update the value of the key if the key exists. Otherwise, add the key-value pair to the cache.
     If the number of keys exceeds the capacity from this operation, evict the least recently used key.
     - Parameters
        - key: The key
        - value: The value
     - Complexity
        - Time: `O(1)`
        - Space: `O(n)` The class uses a dictionary (cache) to store the key-value pairs and a doubly linked list (head and tail) to keep track of the access order
     */
    func put(_ key: Int, _ value: Int) {
        if let node = cache[key] {
            node.value = value
            remove(node)
            addToHead(node)
        } else {
            let node = Node(key: key, value: value)
            if cache.count == capacity {
                cache.removeValue(forKey: tail!.key)
                remove(tail!)
            }
            addToHead(node)
            cache[key] = node
        }
    }

    // MARK: - Private Helpers

    /**
     Removes a node from the doubly linked list
     - Parameter node: The node to be removed
     */
    private func remove(_ node: Node) {
        if node.prev != nil {
            node.prev!.next = node.next
        } else {
            head = node.next
        }

        if node.next != nil {
            node.next!.prev = node.prev
        } else {
            tail = node.prev
        }
    }

    /**
     Add a node to the head of the doubly linked list.
     - Parameter node: The node to be added
     */
    private func addToHead(_ node: Node) {
        node.next = head
        node.prev = nil
        if head != nil {
            head!.prev = node
        }
        head = node
        if tail == nil {
            tail = head
        }
    }
}

import XCTest

final class LRUCacheTests: XCTestCase {
    func testLRUCache() {
        let cache = LRUCache(capacity: 2)

        cache.put(1, 1)
        XCTAssertEqual(cache.get(1), 1)

        cache.put(2, 2)
        XCTAssertEqual(cache.get(1), 1)
        XCTAssertEqual(cache.get(2), 2)

        cache.put(3, 3)
        XCTAssertEqual(cache.get(1), -1)
        XCTAssertEqual(cache.get(2), 2)
        XCTAssertEqual(cache.get(3), 3)
    }
}
