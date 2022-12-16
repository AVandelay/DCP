//
//  main.swift
//  DCP
//
//  Created by  ¯\_(ツ)_/¯ on 12/15/22.
//

import Foundation

func assert<T: Equatable>(actual: T, expectation: T) {
    if actual == expectation {
        print("✅ actual: \(actual) matches expectation: \(expectation)")
    } else {
        print("❌ actual: \(actual) does not match expectation: \(expectation)")
    }
}


