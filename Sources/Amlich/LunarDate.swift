//
//  LunarDate.swift
//  
//
//  Created by Mac Van Anh on 8/18/20.
//

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
    public func toSolar(with timeZone: Double) -> SolarDate {
        return Amlich.toSolar(of: self, with: timeZone)
    }
    
    public static func of(solar date: SolarDate, with timeZone: Double) -> LunarDate {
        return Amlich.toLunar(of: date, with: timeZone)
    }
}

extension LunarDate: CustomStringConvertible {
    public var description: String {
        return "Lunar Date: day: \(day), month: \(month), year: \(year), isLeep: \(isLeap)"
    }
}
