//
//  SolarDate.swift
//  
//
//  Created by Mac Van Anh on 8/18/20.
//
import Foundation

public struct SolarDate: Equatable, Comparable {
    public let day: Int
    public let month: Int
    public let year: Int

    public init(day: Int, month: Int, year: Int) {
        self.day = day
        self.month = month
        self.year = year
    }

    public static func < (lhs: SolarDate, rhs: SolarDate) -> Bool {
        if lhs.year < rhs.year || lhs.month < rhs.month || lhs.day < rhs.day {
            return true
        }

        return false
    }
}

extension SolarDate {
    public func toLunar(with timeZone: Double = 0) -> LunarDate {
        return Amlich.toLunar(of: self, with: timeZone)
    }
    
    public static func of(lunar date: LunarDate, with timeZone: Double = 0) -> SolarDate {
        return Amlich.toSolar(of: date, with: timeZone)
    }

    public static func of(_ date: Date, with timeZone: Double = 0) -> SolarDate {
        return Amlich.toSolar(of: LunarDate.from(date), with: timeZone)
    }


    public static func from(_ date: Date) -> SolarDate {
        let components = Calendar.current.dateComponents([.day, .month, .year], from: date)

        return SolarDate(day: components.day ?? 0, month: components.month ?? 0, year: components.year ?? 0)
    }
}

extension SolarDate: CustomStringConvertible {
    public var description: String {
        return "Solar Date: day: \(day), month: \(month), year: \(year)"
    }
}
