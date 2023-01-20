

import Foundation


fileprivate class Reader4 {
    /**
    *   - Parameter buf: Destination buffer
    *   - Return:  The number of characters read
    */
    func read4(_ buf4: inout [Character]) -> Int {
        // implementation logic to read 4 characters from file and store them in buf4
        // for example:
        let file = FileHandle.init(forReadingAtPath: "file.txt")
        guard let data = file?.readData(ofLength: 4) else { return 0 }
        let readString = String(data: data, encoding: .utf8)
        buf4 = Array(readString!)
        return readString!.count

        // or using any other method of reading file
        // return the number of actual characters read
    }
}

fileprivate class Solution: Reader4 {
    /// buffer to store the characters read by read4
    private var buffer = [Character](repeating: " ", count: 4)
    /// buffer index to keep track of how many characters have been consumed
    private var bufferIndex = 0
    /// buffer size to keep track of how many characters have been read by read4
    private var bufferSize = 0

    /**
     * - Parameters
     *      - buf: Destination buffer
     *      - n: Number of characters to read
     *  - Returns the number of actual characters read
     *  - Complexity
     *      - Time: `O(n)` where n is the number of characters to be read. We may
     *       call read4() multiple times but as the maximum number of characters read
     *       by read4 is 4, so maximum number of calls to read4 will be ceil(n/4)
     *      - Space: `O(1)` as we are using a fixed size buffer of 4 characters to store the
     *       characters read by read4
     *
     *  The function uses a while loop that continues until total characters have been read
     *  or until read4 returns 0, indicating the end of the file has been reached. In each iteration,
     *  the method reads four characters into buffer using read4 if bufferIndex is at the end of
     *  the current buffer, and then copies characters from buffer into the buf argument until n
     *  characters have been read or buffer is fully consumed. The function returns the number
     *  of actual characters read.
     */
    func read(_ buf: inout [Character], _ n: Int) -> Int {
        var total = 0
        while total < n {
            if bufferIndex >= bufferSize {
                bufferSize = read4(&buffer)
                bufferIndex = 0
            }
            if bufferSize == 0 {
                break
            }
            while bufferIndex < bufferSize && total < n {
                buf[total] = buffer[bufferIndex]
                bufferIndex += 1
                total += 1
            }
        }
        return total
    }

}
