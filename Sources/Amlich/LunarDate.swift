//
//  LunarDate.swift
//  
//
//  Created by Mac Van Anh on 8/18/20.
//
import Foundation

public struct LunarDate: Equatable, Comparable {
    public let day: Int
    public let month: Int
    public let year: Int
    public let isLeap: Bool

    public init(day: Int, month: Int, year: Int, isLeap: Bool) {
        self.day = day
        self.month = month
        self.year = year
        self.isLeap = isLeap
    }

    public static func < (lhs: LunarDate, rhs: LunarDate) -> Bool {
        if lhs.year < rhs.year || lhs.month < rhs.month || lhs.day < rhs.day {
            return true
        }

        return false
    }
}

extension LunarDate {
    public func toSolar(with timeZone: Double = 0) -> SolarDate {
        return Amlich.toSolar(of: self, with: timeZone)
    }

    public func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy"

        return dateFormatter.date(from: "\(self.day) \(self.month) \(self.year)")
    }
    
    public static func of(solar date: SolarDate, with timeZone: Double = 0) -> LunarDate {
        return Amlich.toLunar(of: date, with: timeZone)
    }

    public static func of(_ date: Date, with timeZone: Double = 0) -> LunarDate {
        return Amlich.toLunar(of: SolarDate.from(date), with: timeZone)
    }

    public static func from(_ date: Date) -> LunarDate {
        let components = Calendar.current.dateComponents([.day, .month, .year], from: date)

        // TODO: calculate isLeap
        return LunarDate(day: components.day ?? 0, month: components.month ?? 0, year: components.year ?? 0, isLeap: false)
    }
}

extension LunarDate: CustomStringConvertible {
    public var description: String {
        return "Lunar Date: day: \(day), month: \(month), year: \(year), isLeep: \(isLeap)"
    }
}
