//
//  LunarDateTestCase.swift
//  
//
//  Created by Mac Van Anh on 8/18/20.
//

import XCTest
@testable import Amlich

final class LunarDateTestCase: XCTestCase {
    func test_of() {
        let solarDate = SolarDate(day: 18, month: 8, year: 2020)
        let hanoiTimeZone: Double = +7
        let lunarDate = LunarDate.of(solar: solarDate, with: hanoiTimeZone)
                
        XCTAssertEqual(lunarDate.day, 29)
        XCTAssertEqual(lunarDate.month, 6)
        XCTAssertEqual(lunarDate.year, 2020)
        XCTAssertFalse(lunarDate.isLeap)
        
        print(lunarDate.description)
    }

    func test_toSonar() {
        let lunarDate = LunarDate(day: 29, month: 6, year: 2020, isLeap: false)
        let hanoiTimeZone = +7.0
        let solarDate = lunarDate.toSolar(with: hanoiTimeZone);
        
        XCTAssertEqual(solarDate.day, 18)
        XCTAssertEqual(solarDate.month, 8)
        XCTAssertEqual(solarDate.year, 2020)
    }
    
    func test_comparable() {
        let lunarDate1 = LunarDate(day: 10, month: 10, year: 2020, isLeap: false)
        let lunarDate2 = LunarDate(day: 11, month: 10, year: 2020, isLeap: false)
        
        XCTAssertTrue(lunarDate1 < lunarDate2)
        XCTAssertTrue(lunarDate1 <= lunarDate2)
        XCTAssertTrue(lunarDate2 > lunarDate1)
        XCTAssertTrue(lunarDate2 >= lunarDate1)

        XCTAssertFalse(lunarDate2 == lunarDate1)
    }
    
    func test_equalable() {
        let lunarDate1 = LunarDate(day: 10, month: 10, year: 2020, isLeap: false)
        let lunarDate2 = LunarDate(day: 10, month: 10, year: 2020, isLeap: false)
        
        XCTAssertFalse(lunarDate1 < lunarDate2)
        XCTAssertFalse(lunarDate2 > lunarDate1)

        XCTAssertTrue(lunarDate1 <= lunarDate2)
        XCTAssertTrue(lunarDate2 >= lunarDate1)
        XCTAssertTrue(lunarDate2 == lunarDate1)
        
        let lunarDate3 = LunarDate(day: 10, month: 10, year: 2020, isLeap: false)
        let lunarDate4 = LunarDate(day: 10, month: 10, year: 2020, isLeap: true)

        XCTAssertFalse(lunarDate3 == lunarDate4)
    }

}
