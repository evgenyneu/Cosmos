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

  var starFillMode = TegStarFillMode.Half
  var marginBetweenStars:CGFloat = -100 // -100 means relative to font size
  
  var starFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
  var starColor = UIColor(red: 1, green: 149/255, blue: 0, alpha: 1)
  
  var numberFont = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
  var numberColor = UIColor.grayColor()
  var marginBetweenStarsAndNumber: CGFloat = -100 // -100 means relative to font size

  private var size = CGSize()

  func setup() {}

  func show(#raiting: Double, text: String? = nil) {
    setRelativeMargins()
    
    var sublayers = TegStarRating.createStarLayers(raiting, numberOfStars: numberOfStars,
      font: starFont, color: starColor, marginBetweenStars: marginBetweenStars, starFillMode: starFillMode)

    layer.sublayers = sublayers
    
    if let currentText = text {
      let numberLayer = TegStarRatingText.createLayer(currentText,
        font: numberFont, color: numberColor)
      
      let starsSize = TegStarRatingSize.outerSize(sublayers)
      
      TegStarRatingText.position(numberLayer, starsSize: starsSize,
        marginBetweenStarsAndNumber: marginBetweenStarsAndNumber)
      
      layer.addSublayer(numberLayer)
      
      sublayers.append(numberLayer)
    }
    
    size = TegStarRatingSize.outerSize(sublayers) // used as intrinsic content size
  }
  
  private func setRelativeMargins() {
    if marginBetweenStars == -100 {
      marginBetweenStars = starFont.pointSize / 10
    }
    
    if marginBetweenStarsAndNumber == -100 {
      marginBetweenStarsAndNumber = numberFont.pointSize / 4
    }
  }
  
  override func intrinsicContentSize() -> CGSize {
    return size
  }
}
