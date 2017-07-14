import UIKit


/**

Colection of helper functions for creating star layers.

*/
class CosmosLayers {
  /**
  
  Creates the layers for the stars.
  
  - parameter rating: The decimal number representing the rating. Usually a number between 1 and 5
  - parameter settings: Star view settings.
  - returns: Array of star layers.
  
  */
  class func createStarLayers(_ rating: Double, settings: CosmosSettings, isRightToLeft: Bool) -> [CALayer] {

    var ratingRemander = CosmosRating.numberOfFilledStars(rating,
      totalNumberOfStars: settings.totalStars)

    var starLayers = [CALayer]()

    for _ in (0..<settings.totalStars) {
      
      let fillLevel = CosmosRating.starFillLevel(ratingRemainder: ratingRemander,
        fillMode: settings.fillMode)
      
      let starLayer = createCompositeStarLayer(fillLevel, settings: settings, isRightToLeft: isRightToLeft)
      starLayers.append(starLayer)
      ratingRemander -= 1
    }
    
    if isRightToLeft { starLayers.reverse() }
    positionStarLayers(starLayers, starMargin: settings.starMargin)
    return starLayers
  }

  
  /**
  
  Creates an layer that shows a star that can look empty, fully filled or partially filled.
  Partially filled layer contains two sublayers.
  
  - parameter starFillLevel: Decimal number between 0 and 1 describing the star fill level.
  - parameter settings: Star view settings.
  - returns: Layer that shows the star. The layer is displayed in the cosmos view.
  
  */
  class func createCompositeStarLayer(_ starFillLevel: Double,
                                      settings: CosmosSettings, isRightToLeft: Bool) -> CALayer {

    if starFillLevel >= 1 {
      return createStarLayer(true, settings: settings)
    }

    if starFillLevel == 0 {
      return createStarLayer(false, settings: settings)
    }

    return createPartialStar(starFillLevel, settings: settings, isRightToLeft: isRightToLeft)
  }

  /**
  
  Creates a partially filled star layer with two sub-layers:
  
  1. The layer for the filled star on top. The fill level parameter determines the width of this layer.
  2. The layer for the empty star below.
  
  - parameter starFillLevel: Decimal number between 0 and 1 describing the star fill level.
  - parameter settings: Star view settings.

  - returns: Layer that contains the partially filled star.
  
  */
  class func createPartialStar(_ starFillLevel: Double, settings: CosmosSettings, isRightToLeft: Bool) -> CALayer {
    let filledStar = createStarLayer(true, settings: settings)
    let emptyStar = createStarLayer(false, settings: settings)


    let parentLayer = CALayer()
    parentLayer.contentsScale = UIScreen.main.scale
    parentLayer.bounds = CGRect(origin: CGPoint(), size: filledStar.bounds.size)
    parentLayer.anchorPoint = CGPoint()
    parentLayer.addSublayer(emptyStar)
    parentLayer.addSublayer(filledStar)
    
    if isRightToLeft {
      // Flip the star horizontally for a right-to-left language
      let rotation = CATransform3DMakeRotation(CGFloat(Double.pi), 0, 1, 0)
      filledStar.transform = CATransform3DTranslate(rotation, -filledStar.bounds.size.width, 0, 0)
    }
    
    // Make filled layer width smaller according to the fill level
    filledStar.bounds.size.width *= CGFloat(starFillLevel)

    return parentLayer
  }

  private class func createStarLayer(_ isFilled: Bool, settings: CosmosSettings) -> CALayer {
    if let image = isFilled ? settings.filledImage : settings.emptyImage {
      // Create a layer that shows a star from an image
      return StarLayer.create(image: image, size: settings.starSize)
    }
    
    // Create a layer that draws a star from an array of points
    
    let fillColor = isFilled ? settings.filledColor : settings.emptyColor
    let strokeColor = isFilled ? settings.filledBorderColor : settings.emptyBorderColor

    return StarLayer.create(settings.starPoints,
      size: settings.starSize,
      lineWidth: isFilled ? settings.filledBorderWidth : settings.emptyBorderWidth,
      fillColor: fillColor,
      strokeColor: strokeColor)
  }

  /**
  
  Positions the star layers one after another with a margin in between.
  
  - parameter layers: The star layers array.
  - parameter starMargin: Margin between stars.

  */
  class func positionStarLayers(_ layers: [CALayer], starMargin: Double) {
    var positionX:CGFloat = 0

    for layer in layers {
      layer.position.x = positionX
      positionX += layer.bounds.width + CGFloat(starMargin)
    }
  }
}
