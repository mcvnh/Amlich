//
//  Date.swift
//
//
//  Created by Mac Van Anh on 8/18/20.
//
//  This is the implementation in Swift of the original JS version
//  https://github.com/vanng822/amlich/blob/master/lib/amlich-aa98.js
//

import Foundation

struct Amlich {
    /*
     * Compute the (integral) Julian day number of day dd/mm/yyyy, i.e., the number
     * of days between 1/1/4713 BC (Julian calendar) and dd/mm/yyyy.
     * Formula from http://www.tondering.dk/claus/calendar.html
     */
    static func fromDate(_ date: SolarDate) -> Int {
        let (day, month, year) = (date.day, date.month, date.year)

        let a: Int = (14 - day) / 12
        let y: Int = year + 4800 - a
        let m: Int = month + 12 * a - 3

        var jd: Int = day + (153 * m + 2) / 5 + 365 * y + y / 4 - y / 100 + y / 400 - 32045

        if jd < 2299161 {
            jd = day + (153 * m + 2) / 5 + 365 * y + y / 4 - 32083
        }

        return jd
    }


    /*
     * Convert a Julian day number to day/month/year.
     */
    static func toDate(jd: Int) -> SolarDate {
        var a, b, c: Int

        if jd > 2299160 { // After 5/10/1582, Gregorian calendar
            a = jd + 32044
            b = (4 * a + 3) / 146097
            c = a - (b * 146097) / 4
        } else {
            b = 0
            c = jd + 32082
        }

        let d = (4 * c + 3) / 1461
        let e = c - (1461 * d) / 4
        let m = (5 * e + 2) / 153
        let day = e - (153 * m + 2) / 5 + 1
        let month = m + 3 - 12 * (m / 10)
        let year = b * 100 + d - 4800 + m / 10

        return SolarDate(day: day, month: month, year: year)
    }


    /*
     * Compute the time of the k-th new moon after the new moon of 1/1/1900 13:52 UCT
     * (measured as the number of days since 1/1/4713 BC noon UCT, e.g., 2451545.125 is 1/1/2000 15:00 UTC).
     * Returns a floating number, e.g., 2415079.9758617813 for k=2 or 2414961.935157746 for k=-2
     * Algorithm from: "Astronomical Algorithms" by Jean Meeus, 1998
     */
    static func newMoon(of k: Int) -> Double {
        let T: Double = Double(k) / 1236.85 // Time in Julian centuries from 1900 January 0.5
        let T2: Double = T * T
        let T3: Double = T2 * T
        let dr: Double = Double.pi / 180

        var Jd1: Double = 2415020.75933 + 29.53058868 * Double(k) + 0.0001178 * T2 - 0.000000155 * T3
        Jd1 = Jd1 + 0.00033 * sin((166.56 + 132.87 * T - 0.009173 * T2) * dr)       // Mean new moon

        let M: Double = 359.2242 + 29.10535608 * Double(k) - 0.0000333 * T2 - 0.00000347 * T3           // Sun's mean anomaly
        let Mpr: Double = 306.0253 + 385.81691806 * Double(k) + 0.0107306 * T2 + 0.00001236 * T3        // Moon's mean anomaly
        let F: Double = 21.2964 + 390.67050646 * Double(k) - 0.0016528 * T2 - 0.00000239 * T3           // Moon's argument of latitude
        var C1: Double = (0.1734 - 0.000393 * T) * sin(M * dr) + 0.0021 * sin(2 * dr * M)
        C1 = C1 - 0.4068 * sin(Mpr * dr) + 0.0161 * sin(dr * 2 * Mpr)
        C1 = C1 - 0.0004 * sin(dr * 3 * Mpr)
        C1 = C1 + 0.0104 * sin(dr * 2 * F) - 0.0051 * sin(dr * (M + Mpr))
        C1 = C1 - 0.0074 * sin(dr * (M - Mpr)) + 0.0004 * sin(dr * (2 * F + M))
        C1 = C1 - 0.0004 * sin(dr * (2 * F - M)) - 0.0006 * sin(dr * (2 * F + Mpr))
        C1 = C1 + 0.0010 * sin(dr * (2 * F - Mpr)) + 0.0005 * sin(dr * (2 * Mpr + M))

        var deltat: Double
        if T < -11 {
            deltat = 0.001 + 0.000839 * T + 0.0002261 * T2 - 0.00000845 * T3 - 0.000000081 * T * T3
        } else {
            deltat = -0.000278 + 0.000265*T + 0.000262 * T2
        }

        let JdNew: Double = Jd1 + C1 - deltat

        return JdNew
    }

    /*
     * Compute the longitude of the sun at any time.
     * Parameter: floating number jdn, the number of days since 1/1/4713 BC noon
     * Algorithm from: "Astronomical Algorithms" by Jean Meeus, 1998
     */
    static func sunLongtitude(of jdn: Double) -> Double {
        let T: Double = (jdn - 2451545.0 ) / 36525 // Time in Julian centuries from 2000-01-01 12:00:00 GMT
        let T2: Double = T*T
        let dr: Double = Double.pi / 180 // degree to radian
        let M: Double = 357.52910 + 35999.05030*T - 0.0001559*T2 - 0.00000048*T*T2 // mean anomaly, degree
        let L0: Double = 280.46645 + 36000.76983*T + 0.0003032*T2 // mean longitude, degree
        var DL: Double = (1.914600 - 0.004817*T - 0.000014*T2)*sin(dr*M)
        DL = DL + (0.019993 - 0.000101*T)*sin(dr*2*M) + 0.000290*sin(dr*3*M)
        var L: Double = L0 + DL // true longitude, degree
        L = L*dr
        
        L = L - Double.pi * 2 * Double(Int(floor(L/(Double.pi * 2)))) // Normalize to (0, 2*PI)
        return L
    }


    /*
     * Compute sun position at midnight of the day with the given Julian day number.
     * The time zone if the time difference between local time and UTC: 7.0 for UTC+7:00.
     * The function returns a number between 0 and 11.
     * From the day after March equinox and the 1st major term after March equinox, 0 is returned.
     * After that, return 1, 2, 3 ...
     */
    static func sunLongtitude(of dayNumber: Int, with timeZone: Double) -> Int {
        return Int(floor(self.sunLongtitude(of: Double(dayNumber) - 0.5 - timeZone / 24.0) / Double.pi * 6.0))
    }

    /*
     * Compute the day of the k-th new moon in the given time zone.
     * The time zone if the time difference between local time and UTC: 7.0 for UTC+7:00
     */
    static func newMoonDay(of k: Int, with timeZone: Double) -> Int {
        return Int(floor(self.newMoon(of: k) + 0.5 + timeZone / 24.0))
    }

    /*
     * Find the day that starts the luner month 11 of the given year for the given time zone
     */
    static func lunarMonth11(of year: Int, with timeZone: Double) -> Int {
        let off: Double = Double(self.fromDate(SolarDate(day: 31, month: 12, year: year))) - 2415021.076998695
        let k: Int = Int(floor(Double(off) / 29.530588853))
        var nm: Int = newMoonDay(of: k, with: timeZone)
        let sunLong: Int = self.sunLongtitude(of: nm, with: timeZone) / 30

        if sunLong >= 9 {
            nm = self.newMoonDay(of: k - 1, with: timeZone)
        }

        return nm
    }


    /*
     * Find the index of the leap month after the month starting on the day a11.
     */
    static func leapMonthOffset(of day: Int, with timeZone: Double) -> Int {
        let k: Int = Int(floor(0.5 + (Double(day) - 2415021.076998695) / 29.530588853))

        var last: Int
        var i = 1
        var arc: Int = self.sunLongtitude(of: self.newMoonDay(of: k + i, with: timeZone), with: timeZone)

        repeat {
            last = arc
            i += 1
            arc = self.sunLongtitude(of: self.newMoonDay(of: k + i, with: timeZone), with: timeZone)
        } while arc != last && i < 14

        return i - 1
    }

    /*
     * Conver solar day dd/mm/yyyy to the corersponding lunar day
     */
    static func toLunar(of solarDate: SolarDate, with timeZone: Double) -> LunarDate {
        var lunarDay, lunarMonth, lunarYear: Int
        var isLeap: Bool = false

        let dayNumber: Int = self.fromDate(solarDate)
        let k: Int = Int(floor((Double(dayNumber) - 2415021.076998695) / 29.530588853))

        var monthStart = newMoonDay(of: k + 1, with: timeZone)

        if monthStart > dayNumber {
            monthStart = newMoonDay(of: k, with: timeZone)
        }

        var a11 = lunarMonth11(of: solarDate.year, with: timeZone)
        var b11 = a11

        if a11 >= monthStart {
            lunarYear = solarDate.year
            a11 = lunarMonth11(of: solarDate.year - 1, with: timeZone)
        } else {
            lunarYear = solarDate.year + 1
            b11 = lunarMonth11(of: solarDate.year + 1, with: timeZone)
        }

        lunarDay = dayNumber - monthStart + 1
        let diff: Int = (monthStart - a11) / 29
        lunarMonth = diff + 11

        if b11 - a11 > 365 {
            let leapMonthDiff = leapMonthOffset(of: a11, with: timeZone)
            if diff >= leapMonthDiff {
                lunarMonth = diff + 10
                if diff == leapMonthDiff {
                    isLeap = true
                }
            }
        }

        if lunarMonth > 12 {
            lunarMonth -= 12
        }
        if lunarMonth >= 11 && diff < 4 {
            lunarYear -= 1
        }

        return LunarDate(day: lunarDay, month: lunarMonth, year: lunarYear, isLeap: isLeap)
    }

    /*
     * Convert a lunar date to the corresponding solar date
     */
    static func toSolar(of lunar: LunarDate, with timeZone: Double) -> SolarDate {
        var a11, b11: Int

        if (lunar.month < 11) {
            a11 = lunarMonth11(of: lunar.year - 1, with: timeZone)
            b11 = lunarMonth11(of: lunar.year, with: timeZone)
        } else {
            a11 = lunarMonth11(of: lunar.year, with: timeZone)
            b11 = lunarMonth11(of: lunar.year + 1, with: timeZone)
        }

        let k: Int = Int(floor(0.5 + (Double(a11) - 2415021.076998695) / 29.530588853))
        var off: Int = lunar.month - 11

        if off < 0 {
            off += 12
        }

        if b11 - a11 > 365 {
            let leapOff: Int = leapMonthOffset(of: a11, with: timeZone)
            var leapMonth: Int = leapOff - 2
            if leapMonth < 0 {
                leapMonth += 12
            }
            if lunar.isLeap && lunar.month != leapMonth {
                return SolarDate(day: 0, month: 0, year: 0)
            } else if lunar.isLeap || off >= leapOff {
                off += 1
            }
        }

        let monthStart = newMoonDay(of: k + off, with: timeZone)

        return self.toDate(jd: monthStart + lunar.day - 1)
    }
}
