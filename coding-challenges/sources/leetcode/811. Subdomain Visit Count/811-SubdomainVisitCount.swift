

fileprivate func subdomainVisitCount(_ cpdomains: [String]) -> [String] {
    // Create an empty dictionary to store the subdomain counts
    var subdomainCounts = [String: Int]()

    // Iterate over each input domain
    for cpdomain in cpdomains {
        // Split the input domain into its count and domain components
        let components = cpdomain.split(separator: " ")
        let count = Int(components[0])!
        var subdomain = String(components[1])

        // Iterate over each subdomain in the domain
        while !subdomain.isEmpty {
            // Add the count to the subdomain count in the dictionary
            subdomainCounts[subdomain, default: 0] += count

            // Remove the current subdomain from the domain and continue with the next subdomain
            if let range = subdomain.range(of: ".") {
                subdomain = String(subdomain[range.upperBound...])
            } else {
                subdomain = ""
            }
        }
    }

    // Convert the dictionary to an array of strings in the expected format
    return subdomainCounts.map { "\($0.value) \($0.key)" }
}

import XCTest

final class SubdomainVisitCountTests: XCTestCase {
    func test() {
        var cpdomains = ["9001 discuss.leetcode.com"]
        var expected = Set(["9001 discuss.leetcode.com", "9001 leetcode.com", "9001 com"])
        XCTAssertEqual(Set(subdomainVisitCount(cpdomains)), expected)

        cpdomains = ["900 google.mail.com", "50 yahoo.com", "1 intel.mail.com", "5 wiki.org"]
        expected = Set(["901 mail.com","50 yahoo.com","900 google.mail.com","5 wiki.org","5 org","1 intel.mail.com","951 com"])
        XCTAssertEqual(Set(subdomainVisitCount(cpdomains)), expected)
    }
}
