import UIKit

/**

Helper function to make sure bounds are big enought to be used as touch target.
The function is used in pointInside(point: CGPoint, withEvent event: UIEvent?) of UIImageView.

*/
struct CosmosTouchTarget {
  static func optimize(_ bounds: CGRect) -> CGRect {
    let recommendedHitSize: CGFloat = 44
    
    let hitWidthIncrease: CGFloat = max(recommendedHitSize - bounds.width, 0)
    let hitHeightIncrease: CGFloat = max(recommendedHitSize - bounds.height, 0)

    let extendedBounds: CGRect = bounds.insetBy(dx: -hitWidthIncrease / 2,
      dy: -hitHeightIncrease / 2)
    
    return extendedBounds
  }
}
