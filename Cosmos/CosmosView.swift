import UIKit

/**

A star rating view that can be used to show customer rating for the products. On can select stars by tapping on them when updateOnTouch settings is true. An optional text can be supplied that is shown on the right side.

Example:

    cosmosView.rating = 4
    cosmosView.text = "(123)"

Shows: ★★★★☆ (132)

*/
@IBDesignable public class CosmosView: UIView {
    
  /**
  
  The currently shown number of stars, usually between 1 and 5. If the value is decimal the stars will be shown according to the Fill Mode setting.

  */
  @IBInspectable public var rating: Double = CosmosDefaultSettings.rating {
    didSet {
      if oldValue != rating {
        update()
      }
    }
  }
  
  /// Currently shown text. Set it to nil to display just the stars without text.
  @IBInspectable public var text: String? {
    didSet {
      if oldValue != text {
        update()
      }
    }
  }
  
  /// Star rating settings.
  public var settings = CosmosSettings() {
    didSet {
      update()
    }
  }
  
  /// Stores calculated size of the view. It is used as intrinsic content size.
  private var viewSize = CGSize()

  /// Draws the stars when the view comes out of storyboard with default settings
  public override func awakeFromNib() {
    super.awakeFromNib()
    
    update()
  }
  
  
  /**

  Initializes and returns a newly allocated cosmos view object.
  
  */
  convenience public init() {
    self.init(frame: CGRect())
  }
  
  /**

  Initializes and returns a newly allocated cosmos view object with the specified frame rectangle.

  - parameter frame: The frame rectangle for the view.
  
  */
  override public init(frame: CGRect) {
    super.init(frame: frame)
    update()
    self.frame.size = intrinsicContentSize()
    
    improvePerformance()
  }
  
  /// Initializes and returns a newly allocated cosmos view object.
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    improvePerformance()
  }
  
  /// Change view settings for faster drawing
  private func improvePerformance() {
    /// Cache the view into a bitmap instead of redrawing the stars each time
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.mainScreen().scale
    
    opaque = true
  }
  
  /**
  
  Updates the stars and optional text based on current values of `rating` and `text` properties.
  
  */
  public func update() {
    
    // Create star layers
    // ------------
    
    var layers = CosmosLayers.createStarLayers(rating, settings: settings)
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
    
    // Update accesibility
    // ------------

    updateAccessibility()
  }
  
  /**
  
  Creates the text layer for the given text string.
  
  - parameter text: Text string for the text layer.
  - parameter layers: Arrays of layers containing the stars.
  
  - returns: The newly created text layer.
  
  */
  private func createTextLayer(text: String, layers: [CALayer]) -> CALayer {
    let textLayer = CosmosLayerHelper.createTextLayer(text,
      font: settings.textFont, color: settings.textColor)
    
    let starsSize = CosmosSize.calculateSizeToFitLayers(layers)
    
    CosmosText.position(textLayer, starsSize: starsSize, textMargin: settings.textMargin)
    
    layer.addSublayer(textLayer)
    
    return textLayer
  }
  
  /**

  Updates the size to fit all the layers containing stars and text.
  
  - parameter layers: Array of layers containing stars and the text.

  */
  private func updateSize(layers: [CALayer]) {
    viewSize = CosmosSize.calculateSizeToFitLayers(layers)
    invalidateIntrinsicContentSize()
  }
  
  /// Returns the content size to fit all the star and text layers.
  override public func intrinsicContentSize() -> CGSize {
    return viewSize
  }
  
  // MARK: - Accessibility
  
  private func updateAccessibility() {
    CosmosAccessibility.update(self, rating: rating, text: text, settings: settings)
  }
  
  /// Called by the system in accessibility voice-over mode when the value is incremented by the user.
  public override func accessibilityIncrement() {
    super.accessibilityIncrement()
    
    rating += CosmosAccessibility.accessibilityIncrement(rating, settings: settings)
    didTouchCosmos?(rating)
    didFinishTouchingCosmos?(rating)
  }
  
  /// Called by the system in accessibility voice-over mode when the value is decremented by the user.
  public override func accessibilityDecrement() {
    super.accessibilityDecrement()
    
    rating -= CosmosAccessibility.accessibilityDecrement(rating, settings: settings)
    didTouchCosmos?(rating)
    didFinishTouchingCosmos?(rating)
  }
  
  // MARK: - Touch recognition
  
  /// Closure will be called when user touches the cosmos view. The touch rating argument is passed to the closure.
  public var didTouchCosmos: ((Double)->())?
  
  /// Closure will be called when the user lifts finger from the cosmos view. The touch rating argument is passed to the closure.
  public var didFinishTouchingCosmos: ((Double)->())?
  
  /// Overriding the function to detect the first touch gesture.
  public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event)
    
    if let touch = touches.first {
      let location = touch.locationInView(self).x
      onDidTouch(location, starsWidth: widthOfStars)
    }
  }
  
  /// Overriding the function to detect touch move.
  public override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesMoved(touches, withEvent: event)
    
    if let touch = touches.first {
      let location = touch.locationInView(self).x
      onDidTouch(location, starsWidth: widthOfStars)
    }
  }
  
  /// Detecting event when the user lifts their finger.
  public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesEnded(touches, withEvent: event)
    
    didFinishTouchingCosmos?(rating)
  }

  /**

  Called when the view is touched.

  - parameter locationX: The horizontal location of the touch relative to the width of the stars.
  
  - parameter starsWidth: The width of the stars excluding the text.
  
  */
  func onDidTouch(locationX: CGFloat, starsWidth: CGFloat) {
    let calculatedTouchRating = CosmosTouch.touchRating(locationX, starsWidth: starsWidth,
      settings: settings)
    
    if settings.updateOnTouch {
      rating = calculatedTouchRating
    }
    
    if calculatedTouchRating == previousRatingForDidTouchCallback {
      // Do not call didTouchCosmos if rating has not changed
      return
    }
    
    didTouchCosmos?(calculatedTouchRating)
    previousRatingForDidTouchCallback = calculatedTouchRating
  }
  
  private var previousRatingForDidTouchCallback: Double = -123.192
  
  
  /// Width of the stars (excluding the text). Used for calculating touch location.
  var widthOfStars: CGFloat {
    if let sublayers = self.layer.sublayers where settings.totalStars <= sublayers.count {
      let starLayers = Array(sublayers[0..<settings.totalStars])
      return CosmosSize.calculateSizeToFitLayers(starLayers).width
    }
    
    return 0
  }
  
  /// Increase the hitsize of the view if it's less than 44px for easier touching.
  override public func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
    let oprimizedBounds = CosmosTouchTarget.optimize(bounds)
    return oprimizedBounds.contains(point)
  }
  
  
  // MARK: - Properties inspectable from the storyboard
  
  @IBInspectable var totalStars: Int = CosmosDefaultSettings.totalStars {
    didSet {
      settings.totalStars = totalStars
    }
  }
  
  @IBInspectable var starSize: Double = CosmosDefaultSettings.starSize {
    didSet {
      settings.starSize = starSize
    }
  }
  
  @IBInspectable var filledColor: UIColor = CosmosDefaultSettings.filledColor {
    didSet {
      settings.filledColor = filledColor
    }
  }
  
  @IBInspectable var emptyColor: UIColor = CosmosDefaultSettings.emptyColor {
    didSet {
      settings.emptyColor = emptyColor
    }
    }
    
    @IBInspectable var emptyBorderColor: UIColor = CosmosDefaultSettings.emptyBorderColor {
        didSet {
            settings.emptyBorderColor = emptyBorderColor
        }
    }
    
    @IBInspectable var emptyBorderWidth: Double = CosmosDefaultSettings.emptyBorderWidth {
        didSet {
            settings.emptyBorderWidth = emptyBorderWidth
        }
    }
    
    @IBInspectable var filledBorderColor: UIColor = CosmosDefaultSettings.filledBorderColor {
        didSet {
            settings.filledBorderColor = filledBorderColor
        }
    }
    
    @IBInspectable var filledBorderWidth: Double = CosmosDefaultSettings.filledBorderWidth {
        didSet {
            settings.filledBorderWidth = filledBorderWidth
        }
    }
  
  @IBInspectable var starMargin: Double = CosmosDefaultSettings.starMargin {
    didSet {
      settings.starMargin = starMargin
    }
  }
  
  @IBInspectable var fillMode: Int = CosmosDefaultSettings.fillMode.rawValue {
    didSet {
      settings.fillMode = StarFillMode(rawValue: fillMode) ?? CosmosDefaultSettings.fillMode
    }
  }
  
  @IBInspectable var textSize: Double = CosmosDefaultSettings.textSize {
    didSet {
      settings.textFont = settings.textFont.fontWithSize(CGFloat(textSize))
    }
  }
  
  @IBInspectable var textMargin: Double = CosmosDefaultSettings.textMargin {
    didSet {
      settings.textMargin = textMargin
    }
  }
  
  @IBInspectable var textColor: UIColor = CosmosDefaultSettings.textColor {
    didSet {
      settings.textColor = textColor
    }
  }
  
  @IBInspectable var updateOnTouch: Bool = CosmosDefaultSettings.updateOnTouch {
    didSet {
      settings.updateOnTouch = updateOnTouch
    }
  }
  
  @IBInspectable var minTouchRating: Double = CosmosDefaultSettings.minTouchRating {
    didSet {
      settings.minTouchRating = minTouchRating
    }
  }
  
  /// Draw the stars in interface buidler
  public override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    
    update()
  }
}
