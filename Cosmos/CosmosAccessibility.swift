import UIKit

/**

Functions for making cosmos view accessible.

*/
struct CosmosAccessibility {
  /**
  
  Makes the view accesible by settings its label and using rating as value.
  
  */
    
  static func update(view: UIView, rating: Double, text: String?, settings: CosmosSettings) {
    view.isAccessibilityElement = true
    
    view.accessibilityTraits = settings.updateOnTouch ?
      UIAccessibilityTraitAdjustable :UIAccessibilityTraitNone
    
    var accessibilityLabel = CosmosLocalizedRating.ratingTranslation
    
    if let text = text where text != "" {
      accessibilityLabel += " \(text)"
    }
    
    view.accessibilityLabel = accessibilityLabel
    
    view.accessibilityValue = accessibilityValue(view, rating: rating, settings: settings)
  }
  
  /**
  
  Returns the rating that is used as accessibility value.
  The accessibility value depends on the star fill mode.

  For example, if rating is 4.6 and fill mode is .Half the value will be 4.5. And if the fill mode
  if .Full the value will be 5.
  
  */
  static func accessibilityValue(view: UIView, rating: Double, settings: CosmosSettings) -> String {
    let accessibilityRating = CosmosRating.displayedRatingFromPreciseRating(rating,
      fillMode: settings.fillMode, totalStars: settings.totalStars)
    
    // Omit decimals if the value is an integer
    let isInteger = (accessibilityRating * 10) % 10 == 0
    
    if isInteger {
      return "\(Int(accessibilityRating))"
    } else {
      // Only show a single decimal place
      let roundedToFirstDecimalPlace = Double( round(10 * accessibilityRating) / 10 )
      return "\(roundedToFirstDecimalPlace)"
    }
  }
  
  /**

  Returns the amount of increment for the rating. When .Half and .Precise fill modes are used the
  rating is incremented by 0.5.
  
  */
  static func accessibilityIncrement(rating: Double, settings: CosmosSettings) -> Double {
    var increment: Double = 0
      
    switch settings.fillMode {
    case .Full:
      increment = ceil(rating) - rating
      if increment == 0 { increment = 1 }

    case .Half, .Precise:
      increment = (ceil(rating * 2) - rating * 2) / 2
      if increment == 0 { increment = 0.5 }      
    }
    
    if rating >= Double(settings.totalStars) { increment = 0 }
            
    return increment
  }
  
  static func accessibilityDecrement(rating: Double, settings: CosmosSettings) -> Double {
    var increment: Double = 0
    
    switch settings.fillMode {
    case .Full:
      increment = rating - floor(rating)
      if increment == 0 { increment = 1 }
      
    case .Half, .Precise:
      increment = (rating * 2 - floor(rating * 2)) / 2
      if increment == 0 { increment = 0.5 }
    }
    
    if rating <= settings.minTouchRating { increment = 0 }
    
    return increment
  }
}

