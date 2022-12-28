fun main() {
    println(isValid("()") == true)
    println(isValid("()[]{}") == true)
    println(isValid("(]") == false)
}

fun isValid(s: String): Boolean {
    val brackets = mapOf(')' to '(', ']' to '[', '}' to '{')
    val stack = mutableListOf<Char>()
    for (c in s) {
        if (c in brackets.values) {
            stack.add(c)
        } else if (c in brackets) {
            if (stack.isEmpty() || stack.last() != brackets[c]) {
                return false
            }
            stack.removeAt(stack.size - 1)
        }
    }
    
    return stack.isEmpty()
}