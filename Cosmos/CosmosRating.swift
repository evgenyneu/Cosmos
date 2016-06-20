import UIKit

/**

Helper functions for calculating rating.

*/
struct CosmosRating {
  
  /**
  
  Returns a decimal number between 0 and 1 describing the star fill level.
  
  - parameter ratingRemainder: This value is passed from the loop that creates star layers. The value starts with the rating value and decremented by 1 when each star is created. For example, suppose we want to display rating of 3.5. When the first star is created the ratingRemainder parameter will be 3.5. For the second star it will be 2.5. Third: 1.5. Fourth: 0.5. Fifth: -0.5.
  
  - parameter fillMode: Describe how stars should be filled: full, half or precise.
  
  - returns: Decimal value between 0 and 1 describing the star fill level. 1 is a fully filled star. 0 is an empty star. 0.5 is a half-star.
  
  */
  static func starFillLevel(ratingRemainder: Double, fillMode: StarFillMode) -> Double {
    
    var result = ratingRemainder
    
    if result > 1 { result = 1 }
    if result < 0 { result = 0 }
    
    return roundFillLevel(result, fillMode: fillMode)
  }
  
  /**
  
  Rounds a single star's fill level according to the fill mode. "Full" mode returns 0 or 1 by using the standard decimal rounding. "Half" mode returns 0, 0.5 or 1 by rounding the decimal to closest of 3 values. "Precise" mode will return the fill level unchanged.
  
  - parameter starFillLevel: Decimal number between 0 and 1 describing the star fill level.
  
  - parameter fillMode: Fill mode that is used to round the fill level value.
  
  - returns: The rounded fill level.
  
  */
  static func roundFillLevel(_ starFillLevel: Double, fillMode: StarFillMode) -> Double {
    switch fillMode {
    case .full:
      return Double(round(starFillLevel))
    case .half:
      return Double(round(starFillLevel * 2) / 2)
    case .precise :
      return starFillLevel
    }
  }
  
  
  /**
  
  Helper function for calculating the rating that is displayed to the user
  taking into account the star fill mode. For example, if the fill mode is .half and precise rating is 4.6, the displayed rating will be 4.5. And if the fill mode is .full the displayed rating will be 5.
  
  - parameter preciseRating: Precise rating value, like 4.8237
  
  - parameter fillMode: Describe how stars should be filled: full, half or precise.
  
  - parameter totalStars: Total number of stars.
  
  - returns: Returns rating that is displayed to the user taking into account the star fill mode.
  
  */
  static func displayedRatingFromPreciseRating(_ preciseRating: Double,
    fillMode: StarFillMode, totalStars: Int) -> Double {
      
    let starFloorNumber = floor(preciseRating)
    let singleStarRemainder = preciseRating - starFloorNumber
    
    var displayedRating = starFloorNumber + starFillLevel(
      ratingRemainder: singleStarRemainder, fillMode: fillMode)
      
    displayedRating = min(Double(totalStars), displayedRating) // Can't go bigger than number of stars
    displayedRating = max(0, displayedRating) // Can't be less than zero
    
    return displayedRating
  }
  
  /**
  
  Returns the number of filled stars for given rating.
  
  - parameter rating: The rating to be displayed.
  - parameter totalNumberOfStars: Total number of stars.
  - returns: Number of filled stars. If rating is biggen than the total number of stars (usually 5) it returns the maximum number of stars.
  
  */
  static func numberOfFilledStars(_ rating: Double, totalNumberOfStars: Int) -> Double {
    if rating > Double(totalNumberOfStars) { return Double(totalNumberOfStars) }
    if rating < 0 { return 0 }
    
    return rating
  }
}
