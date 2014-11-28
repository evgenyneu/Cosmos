//
//  TegStartRaitingLayerHelper.swift
//  star-rating-view
//
//  Created by Evgenii Neumerzhitckii on 28/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class TegStarRaitingLayerHelper {
  class func createTextLayer(text: String, font: UIFont, color: UIColor) -> CATextLayer {
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
