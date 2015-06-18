//
//  Shows text to the right of the stars
//

import UIKit

class TegStarRatingText {
  class func createLayer(text: String, font: UIFont, color: UIColor) -> CALayer {
    let layer = TegStarRatingLayerHelper.createTextLayer(text, font: font, color: color)
    return layer
  }
  
  class func position(layer: CALayer, starsSize: CGSize, marginBetweenStarsAndText: CGFloat) {
    layer.position.x = starsSize.width + marginBetweenStarsAndText
    
    let yOffset = (starsSize.height - layer.bounds.height) / 2
    
    layer.position.y = yOffset
  }
}
