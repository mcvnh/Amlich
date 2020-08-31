# Amlich

[![build status](https://travis-ci.org/anhmv/Amlich.svg?branch=master)](https://github.com/anhmv/Amlich)
[![codecov](https://codecov.io/gh/anhmv/Amlich/branch/master/graph/badge.svg)](https://codecov.io/gh/anhmv/Amlich)
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://github.com/apple/swift-package-manager)
[![Version](https://img.shields.io/cocoapods/v/Amlich.svg?style=flat)](http://cocoapods.org/pods/Amlich)
[![License](https://img.shields.io/cocoapods/l/Amlich.svg?style=flat)](http://cocoapods.org/pods/Amlich)

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

### Cocoapods
Amlich is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'Amlich'
```

### Swift Package Manager
Amlich is also available through [Swift Package Manager](https://github.com/apple/swift-package-manager). 
To install it, simply add the dependency to your Package.Swift file:

```swift
...
dependencies: [
    .package(url: "https://github.com/anhmv/Amlich.git", from: "1.1.2"),
],
targets: [
    .target( name: "[YourTarget]", dependencies: ["Amlich"]),
]
...
```

## Help, feedback or suggestions?

- [Open a PR](https://github.com/anhmv/Amlich/pull/new/master) if you want to make some change to Releases.
- Contact [@mvanh91 on Twitter](https://twitter.com/mvanh91) for discussions, news & announcements about Releases & other projects.
