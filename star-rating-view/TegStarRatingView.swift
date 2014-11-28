//
//  StarRatingView.swift
//  star-rating-view
//
//  Created by Evgenii Neumerzhitckii on 28/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class TegStarRatingView: UIView {

  let numberOfStars = 5

  var starFont = UIFont.boldSystemFontOfSize(19)
  var starColor = UIColor(red: 1, green: 149/255, blue: 0, alpha: 1)

  func setup() {
  }

  func show(raiting: Double, count: Int) {
    var filledStars = TegStarRatingView.numberOfFilledStars(raiting)

    for starNumber in (0...numberOfStars) {
      filledStars--

      let isFilled = filledStars > 0
      TegStarRatingView.addStar(isFilled, font: starFont, color: starColor)
    }
  }

  private class func addStar(isFilled: Bool, font: UIFont, color: UIColor) {
    let text = isFilled ? "★" : "☆"
    let starLayer = createSublayer(text, font: font, color: color)
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
}
