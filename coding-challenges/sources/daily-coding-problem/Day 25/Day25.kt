fun main() {
    val string = "ray"
    val pattern = "ra."
    println(match(string, pattern)) // true

    val string2 = "raymond"
    val pattern2 = "ra."
    println(match(string2, pattern2)) // false

    val string3 = "chat"
    val pattern3 = ".*at"
    println(match(string3, pattern3)) // true

    val string4 = "chats"
    val pattern4 = ".*at"
    println(match(string4, pattern4)) // false
}

/**
 * Returns `true` if `string` matches `pattern`, `false` otherwise.
 *
 * @param string The string to be matched.
 * @param pattern The regular expression pattern.
 *
 * @specialCharacters
 * - `.`: Matches any single character.
 * - `*`: Matches zero or more of the preceding element.
 *
 * @example
 *
 *     match("ray", "ra.")  // true
 *     match("raymond", "ra.")  // false
 *     match("chat", ".*at")  // true
 *     match("chats", ".*at")  // false
 */
fun match(string: String, pattern: String): Boolean {
    // base case
    if (pattern.isEmpty()) return string.isEmpty()

    // check if the current characters match, taking into account the special character `.`
    val charMatch = !string.isEmpty() && (string[0] == pattern[0] || pattern[0] == '.')

    // pattern has at least 2 chars and second char is the special character `*`
    if (pattern.length >= 2 && pattern[1] == '*') {
        // the `*` matches zero or more occurrences of the preceding element in string after first character and pattern after second character
        return match(string, pattern.substring(2)) || (charMatch && match(string.substring(1), pattern))
    } else {
        // no `*` present, so we just check if the characters match in string after first character and pattern after second character
        return charMatch && match(string.substring(1), pattern.substring(1))
    }
}
