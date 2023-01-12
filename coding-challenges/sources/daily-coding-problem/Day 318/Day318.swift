

/**
 *  Calculates the number of valid playlists given N, M, and B
 *  - Parameters:
 *      - N: the number of songs needed for the trip
 *      - M: the number of songs you have downloaded
 *      - B: the buffer of songs between repeats
 *  - Returns:
 *      - the number of valid playlists
 *  - Complexity
 *      - Time: `O(N*M)`
 *      - Space: `O(N*M)`
 *
 *  The function uses dynamic programming to find the number of valid playlists.
 *  It creates a 2D array `dp` to store the number of valid playlists where `dp[i][j]`
 *  represents the number of ways to pick `i` songs from  `M` songs while having `j`
 *  songs as buffer.
 */
fileprivate func validPlaylistCount(N: Int, M: Int, B: Int) -> Int {
    // initialize 2D dp array with N+1 rows, M+1 columns
    var dp = Array(Array(repeating: Array(Array(repeating: 0, count: M + 1)), count: N + 1))
    dp[0][0] = 1 // base case

    // Iterate over the number of songs required
    for i in 1...N { // i represents the number of songs that we select
        // Iterate over the number of songs downloaded
        for j in 1...M { // j represents the number of buffer songs
            // case 1: select a song and not using a buffer song
            let case1 = dp[i-1][j-1] * (M - (j - 1))
            // case 2: selecting a buffer song and not using a new song
            let case2 = dp[i - 1][j] * max((j - B), 0)
            dp[i][j] = case1 + case2
        }
    }

    return dp[N][M]
}

import XCTest

final class Day318: XCTestCase {
    func testValidPlaylistCount() {
        // Test case 1:
        var n = 6
        var m = 4
        var b = 2
        var expectation = 168
        XCTAssertEqual(validPlaylistCount(N: n, M: m, B: b), expectation)

        // Test case 2:
        n = 10
        m = 7
        b = 3
        expectation = 1764000
        XCTAssertEqual(validPlaylistCount(N: n, M: m, B: b), expectation)

        // Test case 3:
        n = 5
        m = 5
        b = 2
        expectation = 120
        XCTAssertEqual(validPlaylistCount(N: n, M: m, B: b), expectation)
    }
}
