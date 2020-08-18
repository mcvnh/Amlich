import XCTest
@testable import Amlich

final class AmlichTests: XCTestCase {
    func test_jdFromDate() {
        let date = SolarDate(day: 4, month: 10, year: 1582)
        XCTAssertEqual(Amlich.jdFromDate(date), 2299160)
    }

    func test_jdToDay() {
        let date = Amlich.jdToDate(jd: 2299160)
        XCTAssertEqual(date.day, 4)
        XCTAssertEqual(date.month, 10)
        XCTAssertEqual(date.year, 1582)
    }

    func test_toLunar() {
        let solarDate = SolarDate(day: 18, month: 8, year: 2020)
        let lunarDate = Amlich.toLunar(of: solarDate, with: +7)

        XCTAssertEqual(lunarDate.day, 29)
        XCTAssertEqual(lunarDate.month, 6)
        XCTAssertEqual(lunarDate.year, 2021)
    }

    func test_toSonar() {
        let lunarDate = LunarDate(day: 29, month: 6, year: 2020, leapYear: true)
        let sonarDate = Amlich.toSolar(of: lunarDate, with: +7)

        XCTAssertEqual(sonarDate.day, 18)
        XCTAssertEqual(sonarDate.month, 8)
        XCTAssertEqual(sonarDate.year, 2020)
    }
}
