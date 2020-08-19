# Amlich

[![build status](https://travis-ci.org/anhmv/Amlich.svg?branch=master)](https://github.com/anhmv/Amlich)

Amlich is a Swift package that provides an interface to convert date from Solar to Lunar and vice-versa.


## Usage

Put `import Amlich` on the top of your source code

**Convert a solar date to lunar date**

```swift
let solarDate = SolarDate(day: 1, month: 1, year: 2020)
let timeZone: Double = +7

print(Amlich.toLunar(of: solarDate, with: timeZone))
// or
print(solarDate.toLunar(with: timeZone))
```

**Convert a lunar date to solar date**

```swift
let lunarDate = LunarDate(day: 1, month: 1, year: 2020, isLeap: false)
let timeZone: Double = +7

print(Amlich.toSolar(of: lunarDate, with: timeZone))
// or
print(lunarDate.toSolar(with: timeZone))
```

**Get the solar term of a solar date**

```swift
let solarDate = SolarDate(day: 1, month: 1, year: 2020)
let hour = (hh: 10, mm: 20)
let timeZone: Double = +7

SolarTerm.of(solar: solarDate, in: hour, with: timeZone)
```

## Installation

- Add `.package(url: "https://github.com/anhmv/Amlich.git", from: "1.0.0")` to your `Package.swift` file's `dependencies`.
- Update your packages using `$ swift package update`.


## Help, feedback or suggestions?

- [Open a PR](https://github.com/anhmv/Amlich/pull/new/master) if you want to make some change to Releases.
- Contact [@mvanh91 on Twitter](https://twitter.com/mvanh91) for discussions, news & announcements about Releases & other projects.
