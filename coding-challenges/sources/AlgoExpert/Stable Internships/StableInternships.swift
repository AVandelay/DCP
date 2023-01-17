


/**
 *  The Gale-Shapley algorithm is a method for solving the stable matching problem
 *  in which two groups of elements, called agents, propose and accept proposals in order
 *  to form a stable matching.
 *
 *  This implementation of the Gale-Shapley algorithm is used to match interns with teams.
 *  Each intern has a list of teams ranked in order of preference, and each team has a list
 *  of interns ranked in order of preference. The function takes in these preferences and
 *  returns a stable matching in the format of [internIndex, teamIndex].
 *  - Parameters:
 *      - interns: List of lists representing the preferences of each intern, ranked from most preferable to least preferable.
 *      - teams: List of lists representing the preferences of each team, ranked from most preferable to least preferable.
 *  - Returns: A 2-dimensional list of matchings in the format `[internIndex, teamIndex]`
 *  - Complexity:
 *      - Time: O(n^2) where n is the number of interns or teams.
 *      - Space: O(n)
 *
 */
func stableInternships(interns: [[Int]], teams: [[Int]]) -> [[Int]] {
    var interns = interns
    // matchings is a dictionary which keeps track of the matchings of interns and teams
    var matchings = [Int: Int]()
    // availableInterns is an array which keeps track of the available interns
    var availableInterns = Array(repeating: true, count: interns.count)

    // Iterate until all interns are matched
    while availableInterns.contains(true) {
        // Find an available intern
        var intern: Int?
        for (index, isAvailable) in availableInterns.enumerated() {
            if isAvailable {
                intern = index
                break
            }
        }

        // Get the top preferred team for the intern
        let team = interns[intern!][0]
        // Remove the top preferred team from the intern's preference list
        interns[intern!].remove(at: 0)

        // Check if the team is available
        if matchings[team] == nil {
            // Assign the intern to the team
            matchings[team] = intern
            // Set the intern as matched
            availableInterns[intern!] = false
        } else {
            // Get the current intern matched to the team
            let currentIntern = matchings[team]
            // Check if the current intern is more preferred by the team than the new intern
            if teams[team].firstIndex(of: intern!)! < teams[team].firstIndex(of: currentIntern!)! {
                // Assign the new intern to the team
                matchings[team] = intern
                // Set the new intern as matched
                availableInterns[intern!] = false
                // Set the current intern as available
                availableInterns[currentIntern!] = true
            }
        }
    }
    // return the matchings in the format [[internIndex, teamIndex]]
    return matchings.map{ [$1, $0] }
}

import XCTest

final class StableInternshipsTests: XCTestCase {
    func testStableMatching() {
        let interns = [
            [0, 1, 2],
            [1, 0, 2],
            [1, 2, 0]
        ]

        let teams = [
            [2, 1, 0],
            [1, 2, 0],
            [0, 2, 1]
        ]

        let expectedMatches = [
            [0, 0],
            [1, 1],
            [2, 2]
        ]

        let matches = stableInternships(interns: interns, teams: teams)

        XCTAssertEqual(matches.count, expectedMatches.count)

        for match in matches {
            XCTAssertTrue(expectedMatches.contains(match))
        }
    }

    func testStableMatchingMultipleSolutions() {
        let interns = [
            [0, 1, 2],
            [1, 0, 2],
            [2, 1, 0]
        ]

        let teams = [
            [2, 1, 0],
            [1, 2, 0],
            [0, 2, 1]
        ]

        let expectedMatches = [
            [0, 0],
            [1, 1],
            [2, 2]
        ]

        let matches = stableInternships(interns: interns, teams: teams)

        XCTAssertEqual(matches.count, expectedMatches.count)

        for match in matches {
            XCTAssertTrue(expectedMatches.contains(match))
        }
    }

    func testStableMatchingDifferentSolutions() {
        let interns = [
            [0, 1, 2],
            [1, 0, 2],
            [2, 1, 0]
        ]

        let teams = [
            [1, 2, 0],
            [2, 1, 0],
            [0, 2, 1]
        ]

        let expectedMatches = [
            [0, 0],
            [1, 1],
            [2, 2]
        ]

        let matches = stableInternships(interns: interns, teams: teams)

        XCTAssertEqual(matches.count, expectedMatches.count)

        for match in matches {
            XCTAssertTrue(expectedMatches.contains(match))
        }
    }
}
