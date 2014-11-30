//
//  StarRatingView.swift
//  star-rating-view
//
//  Created by Evgenii Neumerzhitckii on 28/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class TegStarRatingView: UIView {
  var settings = TegStarRatingSettings()

  private var size = CGSize()

  func setup() {}

  func show(#raiting: Double, text: String? = nil) {
    setRelativeMargins()
    
    var sublayers = TegStarRating.createStarLayers(raiting, settings: settings)

    layer.sublayers = sublayers
    
    if let currentText = text {
      let numberLayer = TegStarRatingText.createLayer(currentText,
        font: settings.textFont, color: settings.textColor)
      
      let starsSize = TegStarRatingSize.outerSize(sublayers)
      
      TegStarRatingText.position(numberLayer, starsSize: starsSize,
        marginBetweenStarsAndText: settings.marginBetweenStarsAndText)
      
      layer.addSublayer(numberLayer)
      
      sublayers.append(numberLayer)
    }
    
    size = TegStarRatingSize.outerSize(sublayers) // used as intrinsic content size
  }
  
  private func setRelativeMargins() {
    if settings.marginBetweenStars == -100 {
      settings.marginBetweenStars = settings.starFont.pointSize / 10
    }
    
    if settings.marginBetweenStarsAndText == -100 {
      settings.marginBetweenStarsAndText = settings.textFont.pointSize / 4
    }
  }
  
  override func intrinsicContentSize() -> CGSize {
    return size
  }
}
