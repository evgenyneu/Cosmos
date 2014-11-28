//
//  File.swift
//  star-rating-view
//
//  Created by Evgenii Neumerzhitckii on 28/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class TegStarPeopleNumber {
  class func createLayer(number: Int, font: UIFont, color: UIColor) -> CALayer {
    let layer = TegStarRaitingLayerHelper.createTextLayer("(\(number))", font: font, color: color)
    return layer
  }
  
  class func position(layer: CALayer, starsSize: CGSize, marginBetweenStarsAndNumber: CGFloat) {
    layer.position.x = starsSize.width + marginBetweenStarsAndNumber
    
    let yOffset = (starsSize.height - layer.bounds.height) / 2
    
    layer.position.y = yOffset
  }
}
