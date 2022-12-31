fun main() {
    println(longestAbsolutePath("") == 0)
    println(longestAbsolutePath("dir\n\tsubdir1\n\tsubdir2") == 0)
    println(longestAbsolutePath("dir\n\tfile.txt") == 12)
    println(longestAbsolutePath("dir\n\tsubdir1\n\t\tfile.txt") == 20)
    println(longestAbsolutePath("dir\n\tsubdir1\n\t\tfile1.txt\n\t\tsubsubdir1\n\tsubdir2\n\t\tsubsubdir2\n\t\t\tfile2.txt") == 32)
}

fun longestAbsolutePath(fileSystem: String): Int {
    // Split the file system string into lines
    val lines = fileSystem.split("\n")
    // Initialize a stack to store the path lengths for each depth level
    val pathLengths = mutableListOf(0)
    // Initialize a variable to store the maximum length
    var maxLength = 0
    // Iterate through the lines
    for (line in lines) {
        // Count the number of leading tabs to determine the depth of the file or directory
        val depth = line.count { it == '\t' }
        // Remove the leading tabs from the line to get the name of the file or directory
        val name = line.replace("\t", "")
        // If the name contains a period, it's a file
        if (name.contains(".")) {
            // Calculate the length of the path to the file using the path lengths stack
            val length = pathLengths[depth] + name.length
            // Update the maximum length if necessary
            maxLength = maxOf(maxLength, length)
        }
        // If the name doesn't contain a period, it's a directory
        else {
            // Make sure the stack is long enough to store the path length for the current depth level
            while (pathLengths.size <= depth + 1) pathLengths.add(0)
            // Update the path length for the current depth level
            pathLengths[depth + 1] = pathLengths[depth] + name.length + 1
        }
    }
    // Return the maximum length
    return maxLength
}
