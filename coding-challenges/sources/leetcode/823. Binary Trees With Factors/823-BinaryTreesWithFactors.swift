

/**
 * Given an array of unique integers, this function returns the number of possible binary trees that can be created using the integers.
 * Each non-leaf node's value should be equal to the product of the values of its children.
 *
 * - Parameter arr: An array of unique integers where each integer `arr[i]` is strictly greater than 1.
 * - Returns: The number of binary trees that can be created using the integers in arr.
 */
func numFactoredBinaryTrees(arr: [Int] /* = [2, 4, 5, 10]*/) -> Int {
    let mod = 1_000_000_007
    let sorted = arr.sorted()
    // Create a dictionary to store the number of binary trees for each element
    var dp = [Int: Int]()
    // Initialize the dictionary
    for i in sorted {
        dp[i] = 1
    } // dp = [2: 1, 4: 1, 5: 1, 10: 1]

    // Loop through each element in the array
    for (i, val) in sorted.enumerated() {
        // Loop through the previous elements in the array
        for j in 0..<i {
            let remainder = val % sorted[j]
            let quotient = val/sorted[j]                       // loop through
            if remainder == 0,                                 // 2 -> val
               dp[quotient] != nil {                           // 4 -> 2*2
                dp[val]! += dp[sorted[j]]! * dp[quotient]!     // 5 -> val
                dp[val]! %= mod                                // 10 -> 2*5, 5*2
            }
        }
    }

    return dp.values.reduce(0, +) % mod
}
