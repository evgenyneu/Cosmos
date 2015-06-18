import UIKit

/*

A star rating view that can be used to show customer rating for the products. An optional text can be supplied that is shown to the right from the stars.

Example:

   ratingView.show(rating: 4.3, text: "(132)")

*/
public class StarRatingView: UIView {
  public var settings = StarRatingSettings()
  
  /// Stores the size of the view. It is used as intrinsic content size.
  private var size = CGSize()

  /**
  
  Shows the star rating with an optional text label.
  
  Example:
  
      ratingView.show(rating: 4.3, text: "(132)")
  
  - parameter rating: Number of stars to be shown, usually between 1 and 5. If the value is decimal the stars will be shown according to the Fill Mode setting.
  - parameter text: An optional text string that will be shown to the right from the stars.
  
  */
  public func show(rating rating: Double, text: String? = nil) {
    calculateMargins()
    
    // Create star layers
    // ------------
    
    var layers = StarRating.createStarLayers(rating, settings: settings)
    layer.sublayers = layers
    
    // Create text layer
    // ------------

    if let text = text {
      let textLayer = createTextLayer(text, layers: layers)
      layers.append(textLayer)
    }
    
    // Update size
    // ------------

    updateSize(layers)
  }
  
  /**
  
  Creates the text layer for the given text string.
  
  - parameter text: Text string for the text layer.
  - parameter layers: Arrays of layers containing the stars.
  
  - returns: The newly created text layer.
  
  */
  private func createTextLayer(text: String, layers: [CALayer]) -> CALayer {
    let textLayer = StarRatingLayerHelper.createTextLayer(text,
      font: settings.textFont, color: settings.textColor)
    
    let starsSize = StarRatingSize.calculateSizeToFitLayers(layers)
    
    StarRatingText.position(textLayer, starsSize: starsSize,
      marginBetweenStarsAndText: settings.marginBetweenStarsAndText)
    
    layer.addSublayer(textLayer)
    
    return textLayer
  }
  
  /**

  Updates the size to fit all the layers containing stars and text.
  
  - parameter layers: Array of layers containing stars and the text.

  */
  private func updateSize(layers: [CALayer]) {
    size = StarRatingSize.calculateSizeToFitLayers(layers)
    invalidateIntrinsicContentSize()
  }
  
  /// Calculate margins based on the font size.
  private func calculateMargins() {
    settings.marginBetweenStars = settings.starFont.pointSize *
      CGFloat(settings.marginBetweenStarsRelativeToFontSize)
    
    settings.marginBetweenStarsAndText = settings.textFont.pointSize *
      CGFloat(settings.marginBetweenStarsAndTextRelativeToFontSize)
  }
  
  /// Returns the content size to fit all the star and text layers.
  override public func intrinsicContentSize() -> CGSize {
    return size
  }
}
