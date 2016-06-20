import UIKit

/**

Helper function to make sure bounds are big enought to be used as touch target.
The function is used in pointInside(point: CGPoint, withEvent event: UIEvent?) of UIImageView.

*/
struct CosmosTouchTarget {
  static func optimize(_ bounds: CGRect) -> CGRect {
    let recommendedHitSize: CGFloat = 44
    
    var hitWidthIncrease:CGFloat = recommendedHitSize - bounds.width
    var hitHeightIncrease:CGFloat = recommendedHitSize - bounds.height
    
    if hitWidthIncrease < 0 { hitWidthIncrease = 0 }
    if hitHeightIncrease < 0 { hitHeightIncrease = 0 }
    
    let extendedBounds: CGRect = bounds.insetBy(dx: -hitWidthIncrease / 2,
      dy: -hitHeightIncrease / 2)
    
    return extendedBounds
  }
}
