import UIKit

/**

Functions for working with touch input.

*/
struct CosmosTouch {
  /**
  
  Calculates the rating based on the touch location.
  
  - parameter locationX: The horizontal location of the touch relative to the width of the stars.
  
  - parameter starsWidth: The width of the stars excluding the text.
  
  - returns: The rating representing the touch location.
  
  */
  static func touchRating(_ locationX: CGFloat, starsWidth: CGFloat, settings: CosmosSettings) -> Double {
      
    let position = locationX / starsWidth
    let totalStars = Double(settings.totalStars)
    let actualRating = totalStars * Double(position)
    var correctedRating = actualRating
    
    if settings.fillMode != .precise {
      correctedRating += 0.25
    }
    
    correctedRating = CosmosRating.displayedRatingFromPreciseRating(correctedRating,
      fillMode: settings.fillMode, totalStars: settings.totalStars)
    
    correctedRating = max(settings.minTouchRating, correctedRating) // Can't be less than min rating
        
    return correctedRating
  }
}
