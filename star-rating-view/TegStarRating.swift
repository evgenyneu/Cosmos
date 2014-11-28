//
//  TegStarRating.swift
//  star-rating-view
//
//  Created by Evgenii Neumerzhitckii on 28/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class TegStarRating {
  class func createStarLayers(raiting: Double, numberOfStars: Int, font: UIFont, color: UIColor, marginBetweenStars: CGFloat) -> [CALayer] {

    var filledStarsCount = numberOfFilledStars(raiting)

    var starLayers = [CALayer]()

    for starNumber in (0...numberOfStars) {
      filledStarsCount--

      let isFilled = filledStarsCount > 0
      let starLayer = createStarLayer(isFilled, font: font, color: color)
      starLayers.append(starLayer)
    }

    positionStarLayers(starLayers, marginBetweenStars: marginBetweenStars)
    return starLayers
  }

  private class func createStarLayer(isFilled: Bool, font: UIFont, color: UIColor) -> CALayer {
    let text = isFilled ? "★" : "☆"
    return createSublayer(text, font: font, color: color)
  }

  private class func numberOfFilledStars(rating: Double) -> Int {
    var stars = Int(round(rating))

    if stars > 5 { stars = 5 }
    if stars < 0 { stars = 0 }

    return stars
  }

  private class func createSublayer(text: String, font: UIFont, color: UIColor) -> CATextLayer {
    let size = NSString(string: text).sizeWithAttributes([NSFontAttributeName: font])

    let layer = CATextLayer()
    layer.bounds = CGRect(origin: CGPoint(), size: size)
    layer.anchorPoint = CGPoint()

    layer.string = text
    layer.font = CGFontCreateWithFontName(font.fontName)
    layer.fontSize = font.pointSize
    layer.foregroundColor = color.CGColor
    layer.contentsScale = UIScreen.mainScreen().scale

    return layer
  }

  private class func positionStarLayers(layers: [CALayer], marginBetweenStars: CGFloat) {
    var positionX:CGFloat = 0

    for layer in layers {
      layer.position.x = positionX
      positionX += layer.bounds.width + marginBetweenStars
    }
  }
}
