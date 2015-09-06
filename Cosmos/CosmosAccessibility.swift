/**

Functions for making cosmos view accessible.

*/
struct CosmosAccessibility {
  /**
  
  Makes the view accesible by settings its label and using rating as value.
  
  */
  static func update(view: UIView, rating: Double, settings: CosmosSettings) {
    view.isAccessibilityElement = true
    view.accessibilityTraits = UIAccessibilityTraitNone
    view.accessibilityLabel = "Rating"
    view.accessibilityValue = accessiblityValue(view, rating: rating, settings: settings)
  }
  
  static func accessiblityValue(view: UIView, rating: Double, settings: CosmosSettings) -> String {
    let accessibilityRating = CosmosRating.displayedRatingFromPreciseRating(rating,
      fillMode: settings.fillMode, totalStars: settings.totalStars)
    
    let isInteger = (accessibilityRating * 10) % 10 == 0
    
    return isInteger ?
      "\(Int(accessibilityRating))" : "\(Double(round(10 * accessibilityRating)/10))"
  }
}

