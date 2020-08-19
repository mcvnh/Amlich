//
//  LunarDate.swift
//
//
//  Created by Mac Van Anh on 8/18/20.
//


import XCTest
@testable import Amlich

final class AmlichTestCase: XCTestCase {
    func test_fromDate() {
        let date = SolarDate(day: 4, month: 10, year: 1582)
        XCTAssertEqual(Amlich.fromDate(date), 2299160)
    }

    func test_toDay() {
        let date = Amlich.toDate(jd: 2299160)
        XCTAssertEqual(date.day, 4)
        XCTAssertEqual(date.month, 10)
        XCTAssertEqual(date.year, 1582)
    }

    func test_newMoon() {
        XCTAssertEqual(Amlich.newMoon(of: 10), 2415316.060423006)
    }

    func test_sunLongitude() {
        XCTAssertEqual(Amlich.sunLongitude(of: 10), 4.45054572657682)
        XCTAssertEqual(Amlich.sunLongitude(of: 10, with: 7), 8)
    }

    func test_sunLongitudeAsAngle() {
        XCTAssertEqual(Amlich.sunLongitudeAsAngle(of: 2459080.2083333335), 146.19908004776426)
    }

    func test_newMoonDay() {
        XCTAssertEqual(Amlich.newMoonDay(of: 10, with: 7), 2415316)
    }
    
    func test_lunarMonth11() {
        XCTAssertEqual(Amlich.lunarMonth11(of: 2020, with: 7), 2459198)
    }

    func test_leapMonthOffset() {
        XCTAssertEqual(Amlich.leapMonthOffset(of: 100, with: 7), 10)
    }
    
    func test_toLunar() {
        let solarDate = SolarDate(day: 18, month: 8, year: 2020)
        let lunarDate = Amlich.toLunar(of: solarDate, with: +7)

        XCTAssertEqual(lunarDate.day, 29)
        XCTAssertEqual(lunarDate.month, 6)
        XCTAssertEqual(lunarDate.year, 2020)
        XCTAssertEqual(lunarDate.isLeap, false)
        
        let anotherSolarDate = SolarDate(day: 18, month: 8, year: 2025)
        let anotherLunarDate = Amlich.toLunar(of: anotherSolarDate, with: +7)
        
        XCTAssertEqual(anotherLunarDate.day, 25)
        XCTAssertEqual(anotherLunarDate.month, 6)
        XCTAssertEqual(anotherLunarDate.year, 2025)
        XCTAssertEqual(anotherLunarDate.isLeap, true)

    }
    
    func test_toSolar() {
        let lunarDate = LunarDate(day: 29, month: 6, year: 2020, isLeap: false)
        let solarDate = Amlich.toSolar(of: lunarDate, with: +7)

        XCTAssertEqual(solarDate.day, 18)
        XCTAssertEqual(solarDate.month, 8)
        XCTAssertEqual(solarDate.year, 2020)
    }
}
