//
//  main.swift
//  DCP
//
//  Created by  ¯\_(ツ)_/¯ on 12/15/22.
//

import Foundation

func assert<T: Equatable>(_ message: String, _ actual: T, _ expectation: T, function: String = #function) {
    if actual == expectation {
        print("✅ \(function) \(message) actual: \(actual) matches expectation: \(expectation)")
    } else {
        print("❌ \(function) \(message) actual: \(actual) does not match expectation: \(expectation)")
    }
}

/// Day 1
assert("Day 1", day1([10, 15, 3, 7], k: 17), true)
assert("Day 1 binary search", day1_binarySearch([10, 15, 3, 7], k: 17), true)

/// Day 2
assert("Day 2", day2([1, 2, 3, 4, 5]), [120, 60, 40, 30, 24])
assert("Day 2", day2([3, 2, 1]), [2, 3, 6])
