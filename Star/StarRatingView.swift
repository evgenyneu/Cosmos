import UIKit

/*

A view that shows stars. It can be used to show customer rating for the products. An optional text can be supplied that is shown to the right from the stars.

Example:

   ratingView.show(rating: 4.3, text: "(132)")

*/
public class StarRatingView: UIView {
  public var settings = StarRatingSettings()
  private var size = CGSize()

  /**
  
  Shows the star raiting with an optional text label.
  
  Example:
  
      ratingView.show(rating: 4.3, text: "(132)")
  
  - parameter rating: Number of stars to be shown, usually between 1 and 5. If the value is decimal the stars will be shown according to the Fill Mode setting.
  - parameter text: An optional text string that will be shown to the right from the stars.
  
  */
  public func show(rating rating: Double, text: String? = nil) {
    calculateMargins()
    
    var sublayers = StarRating.createStarLayers(rating, settings: settings)

    layer.sublayers = sublayers
    
    if let text = text {
      let numberLayer = StarRatingLayerHelper.createTextLayer(text,
        font: settings.textFont, color: settings.textColor)
      
      let starsSize = StarRatingSize.outerSize(sublayers)
      
      StarRatingText.position(numberLayer, starsSize: starsSize,
        marginBetweenStarsAndText: settings.marginBetweenStarsAndText)
      
      layer.addSublayer(numberLayer)
      
      sublayers.append(numberLayer)
    }
    
    size = StarRatingSize.outerSize(sublayers) // used as intrinsic content size

    invalidateIntrinsicContentSize()
  }
  
  /// Calculate margins based on the font size.
  private func calculateMargins() {
    settings.marginBetweenStars = settings.starFont.pointSize *
      CGFloat(settings.marginBetweenStarsRelativeToFontSize)
    
    settings.marginBetweenStarsAndText = settings.textFont.pointSize *
      CGFloat(settings.marginBetweenStarsAndTextRelativeToFontSize)
  }
  
  override public func intrinsicContentSize() -> CGSize {
    return size
  }
}
