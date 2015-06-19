import UIKit


/**

Colection of helper functions for creating star layers.

*/
class StarRating {
  /**
  
  Creates the layers for the stars.
  
  - parameter rating: The decimal number representing the rating. Usually a number between 1 and 5
  - parameter settings: Star view settings.
  - returns: Array of star layers.
  
  */
  class func createStarLayers(rating: Double, settings: StarRatingSettings) -> [CALayer] {

    var ratingRemander = numberOfFilledStars(rating, totalNumberOfStars: settings.totalStars)

    var starLayers = [CALayer]()

    for _ in (0..<settings.totalStars) {
      let fillLevel = starFillLevel(ratingRemainder: ratingRemander, fillMode: settings.fillMode)
      let starLayer = createCompositeStarLayer(fillLevel, settings: settings)
      starLayers.append(starLayer)
      ratingRemander--
    }

    positionStarLayers(starLayers, starMargin: settings.starMargin)
    return starLayers
  }

  
  /**
  
  Creates an layer that shows a star that can look empty, fully filled or partially filled.
  Partially filled layer contains two sublayers.
  
  - parameter starFillLevel: Decimal number between 0 and 1 describing the star fill level.
  - parameter settings: Star view settings.
  - returns: Layer that shows the star. The layer is displauyed in the star view.
  
  */
  class func createCompositeStarLayer(starFillLevel: Double, settings: StarRatingSettings) -> CALayer {

    if starFillLevel >= 1 {
      return createStarLayer(true, settings: settings)
    }

    if starFillLevel == 0 {
      return createStarLayer(false, settings: settings)
    }

    return createPartialStar(starFillLevel, settings: settings)
  }

  /**
  
  Creates a partially filled star layer with two sub-layers:
  
  1. The layer for the 'filled star' character on top. The fill level parameter determines the width of this layer.
  2. The layer for the 'empty star' character below.
  
  
  - parameter starFillLevel: Decimal number between 0 and 1 describing the star fill level.
  - parameter settings: Star view settings.

  - returns: Layer that contains the partially filled star.
  
  */
  class func createPartialStar(starFillLevel: Double, settings: StarRatingSettings) -> CALayer {
    let filledStar = createStarLayer(true, settings: settings)
    let emptyStar = createStarLayer(false, settings: settings)

    let parentLayer = CALayer()
    parentLayer.contentsScale = UIScreen.mainScreen().scale
    parentLayer.bounds = CGRect(origin: CGPoint(), size: filledStar.bounds.size)
    parentLayer.anchorPoint = CGPoint()
    parentLayer.addSublayer(emptyStar)
    parentLayer.addSublayer(filledStar)

    // make filled layer width smaller according to the fill level.
    filledStar.bounds.size.width *= CGFloat(starFillLevel)

    return parentLayer
  }

  /**

  Returns a decimal number between 0 and 1 describing the star fill level.
  
  - parameter ratingRemainder: This value is passed from the loop that creates star layers. The value starts with the rating value and decremented by 1 when each star is created. For example, suppose we want to display rating of 3.5. When the first star is created the ratingRemainder parameter will be 3.5. For the second star it will be 2.5. Third: 1.5. Fourth: 0.5. Fifth: -0.5.
  
  - parameter fillMode: Describe how stars should be filled: full, half or precise.
  
  - returns: Decimal value between 0 and 1 describing the star fill level. 1 is a fully filled star. 0 is an empty star. 0.5 is a half-star.

  */
  class func starFillLevel(ratingRemainder ratingRemainder: Double, fillMode: StarFillMode) -> Double {
      
    var result = ratingRemainder
    
    if result > 1 { result = 1 }
    if result < 0 { result = 0 }
      
    switch fillMode {
    case .Full:
       result = Double(round(result))
    case .Half:
      result = Double(round(result * 2) / 2)
    case .Precise :
      let _ = "rating is very pecise"
    }
    
    return result
  }

  private class func createStarLayer(isFilled: Bool, settings: StarRatingSettings) -> CALayer {
    let fillColor = isFilled ? settings.colorFilled : UIColor.clearColor()
    let strokeColor = isFilled ? UIColor.clearColor() : settings.colorEmpty

    return StarLayer.create(settings.starPoints,
      size: settings.starSize,
      lineWidth: 1,
      fillColor: fillColor,
      strokeColor: strokeColor)
  }

  /**
  
  Returns the number of filled stars for given rating.
  
  - parameter rating: The rating to be displayed.
  - parameter maxNumberOfStars: Total number of stars.
  - returns: Number of filled stars. If rating is biggen than the total number of stars (usually 5) it returns the maximum number of stars.
  
  */
  class func numberOfFilledStars(rating: Double, totalNumberOfStars: Int) -> Double {
    if rating > Double(totalNumberOfStars) { return Double(totalNumberOfStars) }
    if rating < 0 { return 0 }

    return rating
  }

  /**
  
  Positions the star layers one after another with a margin in between.
  
  - parameter layers: The star layers array.
  - parameter starMargin: Margin between stars.

  */
  class func positionStarLayers(layers: [CALayer], starMargin: Double) {
    var positionX:CGFloat = 0

    for layer in layers {
      layer.position.x = positionX
      positionX += layer.bounds.width + CGFloat(starMargin)
    }
  }
}