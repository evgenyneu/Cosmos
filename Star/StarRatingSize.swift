import UIKit

/**

Helper class for calculating size fo star view.

*/
class StarRatingSize {
  /**
  
  Calculates the size of star rating view. It goes through all the layers and makes size the view size is large enough to show all of them.
  
  */
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
