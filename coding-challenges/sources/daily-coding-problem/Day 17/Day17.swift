

func longestAbsolutePath(fileSystem: String) -> Int {
    // Split the file system into lines
    let lines = fileSystem.split(separator: "\n")
    // Initialize a dictionary to store the path lengths for each depth level
    var pathLengths = [0: 0]
    // Filter the lines to only keep the ones that represent files
    let lengths = lines.filter { line -> Bool in
        // Trim the leading tabs from the line to get the name of the file or directory
        let name = line.trimmingCharacters(in: ["\t"])
        // Calculate the depth of the file or directory
        let depth = line.count - name.count
        if name.contains(".") {
            // If the name contains a period, it's a file.
            // Return true to keep the line
            return true
        } else {
            // If the name doesn't contain a period, it's a directory.
            // Update the path length for the next depth level and return false to discard the line
            pathLengths[depth + 1] = pathLengths[depth, default: 0] + name.count + 1
            return false
        }
    }.map { line -> Int in
        // Trim the leading tabs from the line to get the name of the file
        let name = line.trimmingCharacters(in: ["\t"])
        // Calculate the depth of the file
        let depth = line.count - name.count
        // Calculate the length of the path to the file using the path lengths dictionary
        return pathLengths[depth, default: 0] + name.count
    }

    return lengths.max() ?? 0
}

import XCTest

final class Day17: XCTestCase {
    func testEmptyString() {
        XCTAssertEqual(longestAbsolutePath(fileSystem: ""), 0)
    }

    func testNoFiles() {
        XCTAssertEqual(longestAbsolutePath(fileSystem: "dir\n\tsubdir1\n\tsubdir2"), 0)
    }

    func testSingleFile() {
        XCTAssertEqual(longestAbsolutePath(fileSystem: "dir\n\tfile.txt"), 12)
    }

    func testSingleDirectory() {
        XCTAssertEqual(longestAbsolutePath(fileSystem: "dir\n\tsubdir1\n\t\tfile.txt"), 20)
    }

    func testMultipleFiles() {
        XCTAssertEqual(longestAbsolutePath(fileSystem: "dir\n\tsubdir1\n\t\tfile1.txt\n\t\tsubsubdir1\n\tsubdir2\n\t\tsubsubdir2\n\t\t\tfile2.txt"), 32)
    }
}
