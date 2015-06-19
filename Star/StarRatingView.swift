import UIKit

/*

A star rating view that can be used to show customer rating for the products. An optional text can be supplied that is shown to the right from the stars.

Example:

   ratingView.show(rating: 4, text: "(132)")

Displays: ★★★★☆ (132)

*/
@IBDesignable public class StarRatingView: UIView {
  // MARK: Inspectable properties for storyboard
  
  @IBInspectable var rating: Double = StarRatingDefaultSettings.rating {
    didSet { settings.rating = rating }
  }
  
  @IBInspectable var totalStars: Int = StarRatingDefaultSettings.totalStars {
    didSet { settings.totalStars = totalStars }
  }
  
  @IBInspectable var textFilled: String = StarRatingDefaultSettings.textFilled {
    didSet { settings.textFilled = textFilled }
  }
  
  @IBInspectable var textEmpty: String = StarRatingDefaultSettings.textEmpty {
    didSet { settings.textEmpty = textEmpty }
  }
  
  @IBInspectable var colorFilled: UIColor = StarRatingDefaultSettings.colorFilled {
    didSet { settings.colorFilled = colorFilled }
  }
  
  @IBInspectable var colorEmpty: UIColor = StarRatingDefaultSettings.colorEmpty {
    didSet { settings.colorEmpty = colorEmpty }
  }
  
  @IBInspectable var fillMode: Int = StarRatingDefaultSettings.fillMode.rawValue {
    didSet {
      settings.fillMode = StarFillMode(rawValue: fillMode) ?? StarRatingDefaultSettings.fillMode
    }
  }
  
  @IBInspectable var fillCorrection: Double = StarRatingDefaultSettings.fillCorrection {
    didSet {
      settings.fillCorrection = fillCorrection
    }
  }
  
  public override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    
    show(rating: settings.rating)
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    show()
  }
  
  /// Star rating settings.
  public var settings = StarRatingSettings()
  
  /// Stores the size of the view. It is used as intrinsic content size.
  private var size = CGSize()

  /**
  
  Creates sub-layers in the view that show the stars and the optional text.
  
  Example:
  
      ratingView.show(rating: 4.3, text: "(132)")
  
  - parameter rating: Number of stars to be shown, usually between 1 and 5. If the value is decimal the stars will be shown according to the Fill Mode setting.
  - parameter text: An optional text string that will be shown to the right from the stars.
  
  */
  public func show(rating rating: Double? = nil, text: String? = nil) {
    
    let ratingToShow = rating ?? settings.rating
    
    calculateMargins()
    
    // Create star layers
    // ------------
    
    var layers = StarRating.createStarLayers(ratingToShow, settings: settings)
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
