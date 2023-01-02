fun main() {
    println(twoSum(listOf(10, 15, 3, 7), 17) == true)
}

fun sumExists(numbers: List<Int>, k: Int): Boolean  {
    // Sort the list of numbers
    val sortedNumbers = numbers.sorted()
    
    // Iterate through the list of numbers
    for (i in sortedNumbers.indices) {
        // Calculate the difference between k and the current number
        val difference = k - sortedNumbers[i]
        
        // Use binary search to check if the difference is in the list of numbers
        if (sortedNumbers.binarySearch(difference) >= 0) {
            return true
        }
    }
    
    // If we reach this point, it means we have not found any pair that adds up to k
    return false
}