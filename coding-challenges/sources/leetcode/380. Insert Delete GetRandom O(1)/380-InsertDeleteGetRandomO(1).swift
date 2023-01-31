

fileprivate class RandomizedSet {

    // MARK: Properties

    var elementToIndexMap = [Int: Int]()
    var elements = [Int]()

    /**
     *  Inserts an item val into the set if not present.
     *
     *  - Parameter val:value to be inserted into the set.
     *  - Returns true if the item was not present, false otherwise.
     *  - Complexity
     *      - Time: `O(1)`
     *
     *  This method first checks if the value is already present in `elementToIndexMap`.
     *  If it is present, it returns `false`, indicating that the item was not inserted. If the value is
     *  not present, the method adds the value to `elementToIndexMap` with its index in `elements`
     *  and appends the value to `elements`.
     */
    func insert(_ val: Int) -> Bool {
        guard elementToIndexMap[val] == nil else {
            return false
        }

        elementToIndexMap[val] = elements.count
        elements.append(val)
        return true
    }

    /**
     *  Removes an item val from the set if present.
     *
     *  - Parameter val: value to be removed from the set
     *  - Returns true if the item was present, false otherwise
     *  - Complexity
     *      - Time: `O(1)`
     *
     * This method first checks if the value is present in the `elementToIndexMap`. If it is not present,
     * it returns false, indicating that the item was not removed. If the value is present, the method
     * moves the last element in `elements` to the index of the element to be removed, updates
     * the index of the last element in the `elementToIndexMap`, and removes the last element from `elements`.
     */
    func remove(_ val: Int) -> Bool {
        guard let index = elementToIndexMap[val] else {
            return false
        }

        let last = elements.last!
        elementToIndexMap[last] = index
        elements[index] = last
        elementToIndexMap[val] = nil
        elements.removeLast()
        return true
    }

    /**
     *  Returns a random element from the current set of elements
     *  (it's guaranteed that at least one element exists when this method is called).
     *  Each element must have the same probability of being returned.
     *
     *  - Returns: random element from the set
     *  - Complexity:
     *      - Time: `O(1)`
     */
    func getRandom() -> Int {
        let randomIndex = Int.random(in: 0..<elements.count)
        return elements[randomIndex]
    }
}
