

fileprivate func countDecodings(message: String) -> Int {
    var dp = Array(repeating: 0, count: message.count + 1)

    dp[0] = 1

    for i in 1...message.count {
        // if the current character is not '0', it can be decoded as a single character
        if message[message.index(message.startIndex, offsetBy: i - 1)] != "0" {
            dp[i] += dp[i - 1]
        }

        // if the message has at least 2 characters, and the current and previous characters form a valid encoding (i.e., between 1 and 26),
        // then they can be decoded as a single character
        if i >= 2 {
            let twoDigitEncoding = Int(String(message[message.index(message.startIndex, offsetBy: i - 2)...message.index(message.startIndex, offsetBy: i - 1)]))!
            if twoDigitEncoding >= 1 && twoDigitEncoding <= 26 {
                dp[i] += dp[i - 2]
            }
        }
    }

    return dp[message.count]
}

import XCTest

final class Day7: XCTestCase {
    func test() {
        XCTAssertEqual(countDecodings(message: "111"), 3)
        XCTAssertEqual(countDecodings(message: "001"), 0)
    }
}
