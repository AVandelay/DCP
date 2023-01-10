fun main(args: Array<String>) {
    test()
}

fun isBalanced(bracketString: String): Boolean {
    val brackets = mapOf(')' to '(', ']' to '[', '}' to '{')
    val stack = mutableListOf<Char>()
    for (c in bracketString) {
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

fun test() {
    val testCases = listOf(
        Pair("([])[]({})", true),
        Pair("([)]", false),
        Pair("((()", false)
    )
    
    for ((bracketString, expectation) in testCases) {
        println(isBalanced(bracketString) == expectation)
    }
}