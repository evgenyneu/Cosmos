import UIKit

/*

A star rating view that can be used to show customer rating for the products. An optional text can be supplied that is shown to the right from the stars.

Example:

   ratingView.show(rating: 4, text: "(132)")

Displays: ★★★★☆ (132)

*/
@IBDesignable public class StarRatingView: UIView {
  // MARK: Inspectable properties for storyboard
  
  var gestureRecognizer: UIGestureRecognizer?
  
  @IBInspectable var rating: Double = StarRatingDefaultSettings.rating {
    didSet { settings.rating = rating }
  }
  
  @IBInspectable var totalStars: Int = StarRatingDefaultSettings.totalStars {
    didSet { settings.totalStars = totalStars }
  }
  
  @IBInspectable var starSize: Double = StarRatingDefaultSettings.starSize {
    didSet {
      settings.starSize = starSize
    }
  }
  
  @IBInspectable var colorFilled: UIColor = StarRatingDefaultSettings.colorFilled {
    didSet { settings.colorFilled = colorFilled }
  }
  
  @IBInspectable var colorEmpty: UIColor = StarRatingDefaultSettings.colorEmpty {
    didSet { settings.colorEmpty = colorEmpty }
  }
  
  @IBInspectable var borderColorEmpty: UIColor = StarRatingDefaultSettings.borderColorEmpty {
    didSet { settings.borderColorEmpty = borderColorEmpty }
  }
  
  @IBInspectable var borderWidthEmpty: Double = StarRatingDefaultSettings.borderWidthEmpty {
    didSet { settings.borderWidthEmpty = borderWidthEmpty }
  }
  
  @IBInspectable var starMargin: Double = StarRatingDefaultSettings.starMargin {
    didSet { settings.starMargin = starMargin }
  }
  
  @IBInspectable var fillMode: Int = StarRatingDefaultSettings.fillMode.rawValue {
    didSet {
      settings.fillMode = StarFillMode(rawValue: fillMode) ?? StarRatingDefaultSettings.fillMode
    }
  }
  
  @IBInspectable var text: String? {
    didSet { settings.text = text }
    
  }
  
  @IBInspectable var textSize: Double = StarRatingDefaultSettings.textSize {
    didSet {
      settings.textFont = settings.textFont.fontWithSize(CGFloat(textSize))
    }
  }
  
  @IBInspectable var textMargin: Double = StarRatingDefaultSettings.textMargin {
    didSet { settings.textMargin = textMargin }
  }
  
  @IBInspectable var textColor: UIColor = StarRatingDefaultSettings.textColor {
    didSet { settings.textColor = textColor }
  }
  
  
  public override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    
    show(rating: settings.rating, text: settings.text)
  }
  
  /// Star rating settings.
  public var settings = StarRatingSettings()
  
  /// Stores the size of the view. It is used as intrinsic content size.
  private var viewSize = CGSize()

  /**
  
  Creates sub-layers in the view that show the stars and the optional text.
  
  Example:
  
      ratingView.show(rating: 4.3, text: "(132)")
  
  - parameter rating: Number of stars to be shown, usually between 1 and 5. If the value is decimal the stars will be shown according to the Fill Mode setting.
  - parameter text: An optional text string that will be shown to the right from the stars.
  
  */
  public func show(rating rating: Double, text: String? = nil) {
    
    let currenText = text ?? settings.text
    
    // Create star layers
    // ------------
    
    var layers = StarRating.createStarLayers(rating, settings: settings)
    layer.sublayers = layers
    
    // Create text layer
    // ------------

    if let currenText = currenText {
      let textLayer = createTextLayer(currenText, layers: layers)
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
    
    StarRatingText.position(textLayer, starsSize: starsSize, textMargin: settings.textMargin)
    
    layer.addSublayer(textLayer)
    
    return textLayer
  }
  
  /**

  Updates the size to fit all the layers containing stars and text.
  
  - parameter layers: Array of layers containing stars and the text.

  */
  private func updateSize(layers: [CALayer]) {
    viewSize = StarRatingSize.calculateSizeToFitLayers(layers)
    invalidateIntrinsicContentSize()
  }
  
  /// Returns the content size to fit all the star and text layers.
  override public func intrinsicContentSize() -> CGSize {
    return viewSize
  }
  
  
  // MARK: - Touch recognition
  
  public var touchedTheStar: ((Double)->())?
  
  public override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesMoved(touches, withEvent: event)
    
    if let touch = touches.first {
      onDidTouch(touch)
    }
  }
  
  public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event)
    
    if let touch = touches.first {
      onDidTouch(touch)
    }
  }
  
  private func onDidTouch(touch: UITouch) {
    let translation = touch.locationInView(self)
    
    
    if let sublayers = self.layer.sublayers where settings.totalStars <= sublayers.count {
      let starLayers = Array(sublayers[0..<settings.totalStars])
      let size = StarRatingSize.calculateSizeToFitLayers(starLayers)
      
      let position = translation.x / size.width
      let actualRating = Double(settings.totalStars) * Double(position)
      var correctedRating: Double = actualRating
      
      if settings.fillMode != .Precise {
        correctedRating += 0.25
      }
      
      show(rating: correctedRating)
      
      touchedTheStar?(correctedRating)
    }
  }
  
  /// Increase the hitsize of the view if it's less than 44px for easier tapping.
  override public func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
    let oprimizedBounds = StarTouchTarget.optimize(bounds)
    return oprimizedBounds.contains(point)
  }
}
