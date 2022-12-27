fun main() {
    println(isAnagram("anagram", "nagaram") == true)
    println(isAnagram("rat", "car") == false)
}

fun isAnagram(s: String, t: String): Boolean {
    // Return false if the two strings have different lengths
    if (s.length != t.length) return false
    
    // Sort the characters in both strings
    val sSorted = s.toCharArray().sorted()
    val tSorted = t.toCharArray().sorted()
    
    // Return true if the sorted arrays are equal, false otherwise
    return sSorted == tSorted
}