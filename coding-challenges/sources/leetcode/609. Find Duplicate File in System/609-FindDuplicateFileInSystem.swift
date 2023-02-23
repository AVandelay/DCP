

/**
 * Given a list of directory info strings `paths`, returns a list of groups of duplicate file paths.
 * A group of duplicate files consists of at least two files that have the same content.
 *
 * Parameter - paths: A list of directory info strings in the format `"root/d1/d2/.../dm f1.txt(f1_content) f2.txt(f2_content) ... fn.txt(fn_content)"`
 * Returns - A list of groups of duplicate file paths, where each group is a list of file paths in the format `"directory_path/file_name.txt"`
 *
 *  This implementation takes in a list of directory info strings `paths`, and returns a list of groups of duplicate file paths. It uses a dictionary to store file contents and paths, and iterates through each directory info string in `paths`. For each directory info string, it splits the string into the directory path and file info, and then iterates through each file in the directory. For each file, it splits the file info into the file name and content, and then adds the file path to the corresponding content in the `fileDict`.
 *   After iterating through all the files, it creates a list of file path groups for duplicate files by iterating through the values of the `fileDict` dictionary and appending any list of file paths that has more than one file path. Finally, it returns the list of file path groups.
 *
 */
fileprivate func findDuplicateFiles(_ paths: [String]) -> [[String]] {
    // create a dictionary to store file contents and paths
    var fileDict = [String: [String]]()

    // iterate through each directory info string in paths
    for path in paths {
        // split the string into directory path and file info
        let tokens = path.split(separator: " ")
        let dirPath = String(tokens[0])
        let fileInfo = Array(tokens[1...])

        // iterate through each file in the directory
        for file in fileInfo {
            // split the file info into name and content
            let fileTokens = file.split(separator: "(")
            let fileName = String(fileTokens[0])
            let fileContent = String(fileTokens[1].dropLast())

            // add the file path to the corresponding content in the dictionary
            let fullPath = "\(dirPath)/\(fileName)"
            if fileDict[fileContent] == nil {
                fileDict[fileContent] = [fullPath]
            } else {
                fileDict[fileContent]!.append(fullPath)
            }
        }
    }

    // create a list of file path groups for duplicate files
    var result = [[String]]()
    for paths in fileDict.values {
        if paths.count > 1 {
            result.append(paths)
        }
    }

    return result
}

/**
 * A brute force implementation of this problem would involve comparing every pair of files to determine whether they have the same content. Specifically, for each pair of files, we would read in the contents of each file and compare them byte by byte to determine whether they are the same.
 * The time complexity of this approach would be `O(N^2*M)`, where `N` is the number of directory info strings in paths and `M` is the average number of files in each directory. This is because we would need to compare every pair of files, and for each comparison we would need to read in the contents of each file. The space complexity would be `O(1)`, because we would only need to store the contents of two files at a time.
 */
fileprivate func findDuplicateFilesBruteForce(_ paths: [String]) -> [[String]] {
    var result = [[String]]()

    // iterate through each pair of files
    for i in 0..<paths.count {
        let path1 = paths[i]
        for j in (i+1)..<paths.count {
            let path2 = paths[j]

            // extract file contents from path1 and path2
            let fileContents1 = extractFileContents(path1)
            let fileContents2 = extractFileContents(path2)

            // compare file contents to see if they're the same
            if fileContents1 == fileContents2 {
                // if they're the same, add path1 and path2 to the result
                result.append([path1, path2])
            }
        }
    }

    return result
}

func extractFileContents(_ path: String) -> String {
    // extract the file contents from the path
    let tokens = path.split(separator: " ")
    let fileInfo = Array(tokens[1...])
    var contents = ""

    for file in fileInfo {
        let fileTokens = file.split(separator: "(")
        contents += String(fileTokens[1].dropLast())
    }

    return contents
}

