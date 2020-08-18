//
//  LunarDate.swift
//  
//
//  Created by Mac Van Anh on 8/18/20.
//

struct LunarDate: Equatable, Comparable {
    let day: Int
    let month: Int
    let year: Int
    let isLeap: Bool
    
    static func < (lhs: LunarDate, rhs: LunarDate) -> Bool {
        if lhs.year < rhs.year || lhs.month < rhs.month || lhs.day < rhs.day {
            return true
        }

        return false
    }
}

extension LunarDate {
    func toSolar(with timeZone: Double) -> SolarDate {
        return Amlich.toSolar(of: self, with: timeZone)
    }
    
    static func of(solar date: SolarDate, with timeZone: Double) -> LunarDate {
        return Amlich.toLunar(of: date, with: timeZone)
    }
}

extension LunarDate: CustomStringConvertible {
    var description: String {
        return "Lunar Date: day: \(day), month: \(month), year: \(year), isLeep: \(isLeap)"
    }
}
