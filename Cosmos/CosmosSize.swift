import UIKit

/**

Helper class for calculating size for the cosmos view.

*/
class CosmosSize {
  /**
  
  Calculates the size of the cosmos view. It goes through all the star and text layers and makes size the view size is large enough to show all of them.
  
  */
  class func calculateSizeToFitLayers(_ layers: [CALayer]) -> CGSize {
    var size = CGSize()
    
    for layer in layers {
        size.width = max(size.width, layer.frame.maxX)
        size.height = max(size.height, layer.frame.maxY)
    }
    
    return size
  }
}
