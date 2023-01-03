fun main() {
    println(containsNearbyDuplicate(intArrayOf(1, 2, 3, 1), 3) == true)
    println(containsNearbyDuplicate(intArrayOf(1, 0, 1, 1), 1)  == true)
    println(containsNearbyDuplicate(intArrayOf(1, 2, 3, 4), 2) == false)
}

fun containsNearbyDuplicate(nums: IntArray, k: Int): Boolean {
    // create an empty set
    var seen = mutableSetOf<Int>()
    // iterate over the elements of the array
    nums.forEachIndexed { i, num ->
        // if the element exists in the set
        if (num in seen) return true
        // add the element to the set
        seen.add(num)
        // if the size of the set exceeds k, remove the oldenst element
        if (i >= k) seen.remove(nums[i - k])
    }
    // no such elements were found
    return false
}