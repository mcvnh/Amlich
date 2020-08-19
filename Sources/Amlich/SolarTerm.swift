//
//  SolarTerm.swift
//  
//
//  Created by Mac Van Anh on 8/19/20.
//
import Foundation

public enum SolarTerm: Int, CaseIterable {
    case startOfSpring = 1
    case rainWater
    case awakeningOfInsects
    case vernalEquinox
    case clearAndBright
    case grainRain
    case startOfSummer
    case grainFull
    case grainInEar
    case summerSolstice
    case minorHeat
    case majorHeat
    case startOfAutumn
    case limitOfHeat
    case whiteDew
    case autumnalEquinox
    case coldDew
    case frostDescent
    case startOfWinter
    case minorSnow
    case majorSnow
    case winterSolstice
    case minorCold
    case majorCold

    static func of(solar date: SolarDate, in hour: (hh: Int, mm: Int), with timeZone: Double) -> SolarTerm {
        let (hh, mm) = hour
        let jdn = Amlich.fromDate(date)
        let jdnWithHour: Double = Double(jdn) + Double(hh - 12)/24.0 + Double(mm)/1440.0 - timeZone / 24.0
        let sunLongitudeAtJDN = Amlich.sunLongitudeAsAngle(of: jdnWithHour)

        let index = Int(round(sunLongitudeAtJDN / 15))
        return SolarTerm.allCases[index - 1]
    }
}
