import UIKit

/**

Functions for working with touch input.

*/
struct CosmosTouch {
  /**
  
  Calculates the rating based on the touch location.
  
  - parameter position: The horizontal location of the touch relative to the width of the stars.
   
  - returns: The rating representing the touch location.
  
  */
  static func touchRating(_ position: CGFloat, settings: CosmosSettings) -> Double {
    var rating = preciseRating(
      position: Double(position),
      numberOfStars: settings.totalStars,
      starSize: settings.starSize,
      starMargin: settings.starMargin)
    
    if settings.fillMode == .half {
      rating += 0.20
    }
    
    if settings.fillMode == .full {
      rating += 0.45
    }
    
    rating = CosmosRating.displayedRatingFromPreciseRating(rating,
      fillMode: settings.fillMode, totalStars: settings.totalStars)
    
    rating = max(settings.minTouchRating, rating) // Can't be less than min rating
        
    return rating
  }
  
  
  /**
   
  Returns the precise rating based on the touch position.
   
  - parameter position: The horizontal location of the touch relative to the width of the stars.
  - parameter numberOfStars: Total number of stars, filled and full.
  - parameter starSize: The width of a star.
  - parameter starSize: Margin between stars.
  - returns: The precise rating.
   
  */
  static func preciseRating(position: Double, numberOfStars: Int,
                            starSize: Double, starMargin: Double) -> Double {
    
    if position < 0 { return 0 }
    var positionRemainder = position;
    
    // Calculate the number of times the star with a margin fits the position
    // This will be the whole part of the rating
    var rating: Double = Double(Int(position / (starSize + starMargin)))
    
    // If rating is grater than total number of stars - return maximum rating
    if Int(rating) > numberOfStars { return Double(numberOfStars) }
    
    // Calculate what portion of the last star does the position correspond to
    // This will be the added partial part of the rating
    
    positionRemainder -= rating * (starSize + starMargin)
    
    if positionRemainder > starSize
    {
      rating += 1
    } else {
      rating += positionRemainder / starSize
    }
    
    return rating
  }
}
