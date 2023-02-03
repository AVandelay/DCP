

/// The `KeyValue` struct represents a key-value pair in a HashMap.
///
/// The struct is initialized with the key and value as parameters.
/// The `key` property is stored as a constant `Int` while the `value` property is a variable `Int`.
fileprivate struct KeyValue {

    /// Key stored as a constant `Int`
    let key: Int

    /// Value stored as a variable `Int`
    var value: Int

    /// Initializes a new `KeyValue` struct with the given `key` and `value`.
    ///
    /// - Parameters:
    ///   - key: The key as an `Int` to be stored in the `KeyValue` struct.
    ///   - value: The value as an `Int` to be stored in the `KeyValue` struct.
    init(_ key: Int, _ value: Int) {
        self.key = key
        self.value = value
    }
}

/// The Bucket class is used to store KeyValue pairs in the MyHashMap implementation.
fileprivate class Bucket {
    /// An array of KeyValue structs that represent the key-value mappings stored in this bucket.
    var values: [KeyValue]

    /// Initializes a new empty bucket.
    init() {
        self.values = []
    }

    /// Retrieves the value associated with the given key.
    /// - Parameter key: The key to look up.
    /// - Returns: The value associated with the key, or -1 if the key is not found in the bucket.
    func get(key: Int) -> Int {
        // Loop through the values array to find the KeyValue with given key
        for kv in values {
            if kv.key == key {
                return kv.value
            }
        }
        // If key is not found, return -1
        return -1
    }

    /// Updates the value associated with the given key. If the key is not found in the bucket,
    /// a new KeyValue with the given key and value is added to the values array.
    /// - Parameters:
    ///   - key: The key to update.
    ///   - value: The new value to associate with the key.
    func update(key: Int, value: Int) {
        // Loop through the values array to find the KeyValue with given key
        for i in 0..<values.count {
            if values[i].key == key {
                values[i].value = value
                return
            }
        }
        // If key is not found, add a new KeyValue with given key and value to the values array
        values.append(KeyValue(key, value))
    }

    /// Removes the KeyValue associated with the given key from the values array.
    /// - Parameter key: The key to remove.
    func remove(key: Int) {
        // Loop through the values array to find the KeyValue with given key
        for i in 0..<values.count {
            if values[i].key == key {
                // Remove the KeyValue from the values array
                values.remove(at: i)
                return
            }
        }
    }
}

/// MyHashMap is a class that implements a hash map data structure.
fileprivate class MyHashMap {
    let keySpace: Int // Key space for the hash function
    var hashTable: [Bucket] // Array of Buckets to hold the key-value mappings

    /// Initializes a new instance of the class.
    init() {
        self.keySpace = 2069
        self.hashTable = Array(repeating: Bucket(), count: keySpace)
    }

    /// Adds a key-value mapping to the hash map.
    ///
    /// - Parameters:
    ///   - key: The key to add.
    ///   - value: The value to add.
    func put(key: Int, value: Int) {
        // Calculates the hash key using the key and keySpace
        let hashKey = key % keySpace
        // Updates the Bucket at hashKey index with the given KeyValue
        hashTable[hashKey].update(key: key, value: value)
    }

    /// Gets the value associated with the specified key.
    ///
    /// - Parameter key: The key to search for.
    /// - Returns: The value associated with the specified key, or -1 if the key is not found.
    func get(key: Int) -> Int {
        // Calculates the hash key using the key and keySpace
        let hashKey = key % keySpace
        // Gets the value of the given key from the Bucket at hashKey index
        return hashTable[hashKey].get(key: key)
    }

    /// Removes the key-value mapping with the specified key from the hash map.
    ///
    /// - Parameter key: The key to remove.
    func remove(key: Int) {
        // Calculates the hash key using the key and keySpace
        let hashKey = key % keySpace
        // Removes the key-value mapping from the hashTable
        hashTable[hashKey].remove(key: key)
    }
}

import XCTest

final class DesignHashMapTests: XCTestCase {
    func test() {
        let myHashMap = MyHashMap()
        myHashMap.put(key: 1, value: 1)
        myHashMap.put(key: 2, value: 2)
        XCTAssertEqual(myHashMap.get(key: 1), 1)
        XCTAssertEqual(myHashMap.get(key: 3), -1)
        myHashMap.put(key: 2, value: 1)
        XCTAssertEqual(myHashMap.get(key: 2), 1)
        myHashMap.remove(key: 2)
        XCTAssertEqual(myHashMap.get(key: 2), -1)
    }
}
