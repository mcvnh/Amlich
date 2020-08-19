//
//  SolarDate.swift
//  
//
//  Created by Mac Van Anh on 8/18/20.
//

public struct SolarDate: Equatable, Comparable {
    let day: Int
    let month: Int
    let year: Int
    
    public static func < (lhs: SolarDate, rhs: SolarDate) -> Bool {
        if lhs.year < rhs.year || lhs.month < rhs.month || lhs.day < rhs.day {
            return true
        }

        return false
    }
}

extension SolarDate {
    public func toLunar(with timeZone: Double) -> LunarDate {
        return Amlich.toLunar(of: self, with: timeZone)
    }
    
    public static func of(lunar date: LunarDate, timeZone: Double) -> SolarDate {
        return Amlich.toSolar(of: date, with: timeZone)
    }
}

extension SolarDate: CustomStringConvertible {
    public var description: String {
        return "Solar Date: day: \(day), month: \(month), year: \(year)"
    }
}
