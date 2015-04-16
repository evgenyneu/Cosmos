import UIKit

class TegStarRatingSize {
  class func outerSize(layers: [CALayer]) -> CGSize {
    var size = CGSize()
    
    for layer in layers {
      if layer.frame.maxX > size.width {
        size.width = layer.frame.maxX
      }
      
      if layer.frame.maxY > size.height {
        size.height = layer.frame.maxY
      }
    }
    
    return size
  }
}
