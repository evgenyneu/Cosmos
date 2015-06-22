

import UIKit

/**

Positions the text layer to the right of the stars.

*/
class CosmosText {
  /**
  
  Positions the text layer to the right from the stars. Text is aligned to the center of the star superview vertically.
  
  - parameter layer: The text layer to be positioned.
  - parameter starsSize: The size of the star superview.
  - parameter textMargin: The distance between the stars and the text.
  
  */
  class func position(layer: CALayer, starsSize: CGSize, textMargin: Double) {
    layer.position.x = starsSize.width + CGFloat(textMargin)
    let yOffset = (starsSize.height - layer.bounds.height) / 2
    layer.position.y = yOffset
  }
}
