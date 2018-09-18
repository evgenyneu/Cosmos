import UIKit

/// Helper class for creating CALayer objects.
class CosmosLayerHelper {
  /**

  Creates a text layer for the given text string and font.
  
  - parameter text: The text shown in the layer.
  - parameter font: The text font. It is also used to calculate the layer bounds.
  - parameter color: Text color.
  
  - returns: New text layer.
  
  */
  class func createTextLayer(_ text: String, font: UIFont, color: UIColor) -> CATextLayer {
    let size = NSString(string: text).size(withAttributes: [NSAttributedString.Key.font: font])
    
    let layer = CATextLayer()
    layer.bounds = CGRect(origin: CGPoint(), size: size)
    layer.anchorPoint = CGPoint()
    
    layer.string = text
    layer.font = CGFont(font.fontName as CFString)
    layer.fontSize = font.pointSize
    layer.foregroundColor = color.cgColor
    layer.contentsScale = UIScreen.main.scale
    
    return layer
  }
}
