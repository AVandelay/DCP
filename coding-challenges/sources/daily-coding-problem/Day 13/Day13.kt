fun main() {
    println(longestSubstring("abcba", 2))
}

fun longestSubstring(s: String, k: Int): Int {
    val counts = mutableMapOf<Char, Int>()
    var maxLength = 0
    var left = 0
    var right = 0
    while (right < s.length) {
        counts[s[right]] = counts.getOrDefault(s[right], 0) + 1
        while (counts.size > k) {
            counts[s[left]] = counts[s[left]]!! - 1
            if (counts[s[left]] == 0) {
                counts.remove(s[left])
            }
            left++
        }
        maxLength = kotlin.math.max(maxLength, right - left + 1)
        right++
    }
    
    return maxLength
}