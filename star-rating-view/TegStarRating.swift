//
//  TegStarRating.swift
//  star-rating-view
//
//  Created by Evgenii Neumerzhitckii on 28/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class TegStarRating {
  class func createStarLayers(rating: Double, settings: TegStarRatingSettings) -> [CALayer] {

    var ratingRemander = numberOfFilledStars(rating)

    var starLayers = [CALayer]()

    for starNumber in (0..<settings.numberOfStars) {
      ratingRemander--

      let fillLevel = starFillLevel(ratingRemander, starFillMode: settings.starFillMode,
        correctFillLevelForPrecise: settings.correctFillLevelForPreciseMode)
      
      let starLayer = createCompositeStarLayer(fillLevel, settings: settings)
      starLayers.append(starLayer)
    }

    positionStarLayers(starLayers, marginBetweenStars: settings.marginBetweenStars)
    return starLayers
  }

  private class func createCompositeStarLayer(starFillLevel: Double,
    settings: TegStarRatingSettings) -> CALayer {

    if starFillLevel >= 1 {
      return createStarLayer(true, settings: settings)
    }
      
    if starFillLevel == 0 {
      return createStarLayer(false, settings: settings)
    }
      
    return createHalfStar(starFillLevel, settings: settings)
  }

  
  private class func createHalfStar(starFillLevel: Double, settings: TegStarRatingSettings) -> CALayer {
    let filledStar = createStarLayer(true, settings: settings)
    let emptyStar = createStarLayer(false, settings: settings)

    let parentLayer = CALayer()
    parentLayer.contentsScale = UIScreen.mainScreen().scale
    parentLayer.bounds = CGRect(origin: CGPoint(), size: filledStar.bounds.size)
    parentLayer.anchorPoint = CGPoint()
    parentLayer.addSublayer(emptyStar)
    parentLayer.addSublayer(filledStar)
    
    // make filled layer width smaller according to fill level
    filledStar.bounds.size.width *= CGFloat(starFillLevel)
    
    return parentLayer
  }
  
  // Returns a number between 0 and 1 describing the star fill level.
  // 1 is a fully filled star. 0 is an empty star. 0.5 is a half-star.
  private class func starFillLevel(ratingRemainder: Double, starFillMode: TegStarFillMode,
    correctFillLevelForPrecise: Bool) -> Double {
      
    var result = ratingRemainder + 1
    if result > 1 {
      result = 1
    } else if result < 0 {
      result = 0
    }
    
    if starFillMode == TegStarFillMode.Precise && correctFillLevelForPrecise {
      result = correctFillLevelToCompensateForTheFactThatStarIsNotOneHundredPercentWide(result)
    }
    
    if starFillMode == TegStarFillMode.Full {
      result = Double(round(result))
    }
    
    if starFillMode == TegStarFillMode.Half {
      result = Double(round(result * 2) / 2)
    }
  
    return result
  }
  
  private class func correctFillLevelToCompensateForTheFactThatStarIsNotOneHundredPercentWide(fillLevel: Double) -> Double {
    if fillLevel >= 0 && fillLevel <= 1 {
      return 3.0 / 5.0 * fillLevel + 1.0 / 5.0
    }
    
    return fillLevel
  }
  
  private class func createStarLayer(isFilled: Bool, settings: TegStarRatingSettings) -> CALayer {
    let text = isFilled ? settings.starCharacterFilled : settings.starCharacterEmpty
    let color = isFilled ? settings.starColorFilled : settings.starColorEmpty

    return TegStarRatingLayerHelper.createTextLayer(text, font:settings.starFont, color: color)
  }

  private class func numberOfFilledStars(rating: Double) -> Double {
    if rating > 5 { return 5 }
    if rating < 0 { return 0 }

    return rating
  }

  private class func positionStarLayers(layers: [CALayer], marginBetweenStars: CGFloat) {
    var positionX:CGFloat = 0

    for layer in layers {
      layer.position.x = positionX
      positionX += layer.bounds.width + marginBetweenStars
    }
  }
}
