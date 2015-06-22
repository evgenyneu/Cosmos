import UIKit

/**

Functions for working with touch input.

*/
struct StarTouch {
  /**
  
  Calculates the rating based on the touch location.
  
  - parameter locationX: The horizontal location of the touch relative to the width of the stars.
  
  - parameter starsWidth: The width of the stars excluding the text.
  
  - returns: The rating representing the touch location.
  
  */
  static func touchRating(locationX: CGFloat, starsWidth: CGFloat, settings: StarRatingSettings) -> Double {
      
    let position = locationX / starsWidth
    let totalStars = Double(settings.totalStars)
    let actualRating = totalStars * Double(position)
    var correctedRating = actualRating
    
    if settings.fillMode != .Precise {
      correctedRating += 0.25
    }
    
    let starFloorNumber = floor(correctedRating)
    let singleStarRemainder = correctedRating - starFloorNumber
    
    correctedRating = starFloorNumber + StarRating.starFillLevel(
      ratingRemainder: singleStarRemainder, fillMode: settings.fillMode)
    
    correctedRating = min(totalStars, correctedRating) // Can't go bigger than number of stars
    correctedRating = max(0, correctedRating) // Can't be less than zero
    correctedRating = max(settings.minTouchRating, correctedRating) // Can't be less than min rating
        
    return correctedRating
  }
}