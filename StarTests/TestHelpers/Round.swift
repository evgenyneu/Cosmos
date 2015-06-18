import Foundation

struct Helpers {
  static func roundToPlaces(value: Double, places: Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return round(value * divisor) / divisor
  }
  
  static func round10(value: Double) -> Double {
    return roundToPlaces(value, places: 10)
  }
}