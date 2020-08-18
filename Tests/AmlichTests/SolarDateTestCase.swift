//
//  SolarDateTestCase.swift
//  
//
//  Created by Mac Van Anh on 8/18/20.
//

import XCTest
@testable import Amlich

final class SolarDateTestCase: XCTestCase {
    func test_of() {
        let lunarDate = LunarDate(day: 29, month: 6, year: 2020, isLeap: false)
        let hanoiTimeZone: Double = +7
        let solarDate = SolarDate.of(lunar: lunarDate, timeZone: hanoiTimeZone)
                
        XCTAssertEqual(solarDate.day, 18)
        XCTAssertEqual(solarDate.month, 8)
        XCTAssertEqual(solarDate.year, 2020)
    }
    
    func test_toLunar() {
        let solarDate = SolarDate(day: 18, month: 8, year: 2020)
        let hanoiTimeZone = +7.0
        let lunarDate = solarDate.toLunar(with: hanoiTimeZone);
        
        XCTAssertEqual(lunarDate.day, 29)
        XCTAssertEqual(lunarDate.month, 6)
        XCTAssertEqual(lunarDate.year, 2020)
    }
    
    func test_comparable() {
        let solarDate1 = SolarDate(day: 10, month: 10, year: 2020)
        let solarDate2 = SolarDate(day: 11, month: 10, year: 2020)
        
        XCTAssertTrue(solarDate1 < solarDate2)
        XCTAssertTrue(solarDate1 <= solarDate2)
        XCTAssertTrue(solarDate2 > solarDate1)
        XCTAssertTrue(solarDate2 >= solarDate1)

        XCTAssertFalse(solarDate2 == solarDate1)
    }
    
    func test_equalable() {
        let solarDate1 = SolarDate(day: 10, month: 10, year: 2020)
        let solarDate2 = SolarDate(day: 10, month: 10, year: 2020)
        
        XCTAssertFalse(solarDate1 < solarDate2)
        XCTAssertFalse(solarDate2 > solarDate1)

        XCTAssertTrue(solarDate1 <= solarDate2)
        XCTAssertTrue(solarDate2 >= solarDate1)
        XCTAssertTrue(solarDate2 == solarDate1)
    }
}
