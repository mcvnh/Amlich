//
//  File.swift
//  
//
//  Created by Mac Van Anh on 8/19/20.
//

import XCTest
@testable import Amlich

final class SolarTermTestCase: XCTestCase {
    func test_totalTerms() {
        XCTAssertEqual(SolarTerm.allCases.count, 24)
    }

    func test_of() {
        let solarDate = SolarDate(day: 19, month: 8, year: 2020)
        let hour = (hh: 0, mm: 0)

        XCTAssertEqual(SolarTerm.of(solar: solarDate, in: hour, with: 7), SolarTerm.summerSolstice)
    }
}
