import UIKit

/**

A star rating view that can be used to show customer rating for the products. On can select stars by tapping on them when updateOnTouch settings is true. An optional text can be supplied that is shown on the right side.

Example:

    cosmosView.rating = 4
    cosmosView.text = "(123)"

Shows: ★★★★☆ (123)

*/
@IBDesignable open class CosmosView: UIView {
    
  /**
  
  The currently shown number of stars, usually between 1 and 5. If the value is decimal the stars will be shown according to the Fill Mode setting.

  */
  @IBInspectable open var rating: Double = CosmosDefaultSettings.rating {
    didSet {
      if oldValue != rating {
        update()
      }
    }
  }
  
  /// Currently shown text. Set it to nil to display just the stars without text.
  @IBInspectable open var text: String? {
    didSet {
      if oldValue != text {
        update()
      }
    }
  }
  
  /// Star rating settings.
  open var settings: CosmosSettings = .default {
    didSet {
      update()
    }
  }
  
  /// Stores calculated size of the view. It is used as intrinsic content size.
  private var viewSize = CGSize()

  /// Draws the stars when the view comes out of storyboard with default settings
  open override func awakeFromNib() {
    super.awakeFromNib()
    
    update()
  }

  /**

  Initializes and returns a newly allocated cosmos view object.
  
  */
  public convenience init(settings: CosmosSettings = .default) {
    self.init(frame: .zero, settings: settings)
  }

  /**

  Initializes and returns a newly allocated cosmos view object with the specified frame rectangle.

  - parameter frame: The frame rectangle for the view.
  
  */
  override public convenience init(frame: CGRect) {
    self.init(frame: frame, settings: .default)
  }

  public init(frame: CGRect, settings: CosmosSettings) {
    super.init(frame: frame)
    self.settings = settings
    update()
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
    layer.rasterizationScale = UIScreen.main.scale
    
    isOpaque = true
  }
  
  /**
  
  Updates the stars and optional text based on current values of `rating` and `text` properties.
  
  */
  open func update() {
    
    // Create star layers
    // ------------
    
    var layers = CosmosLayers.createStarLayers(
      rating,
      settings: settings,
      isRightToLeft: RightToLeft.isRightToLeft(self)
    )
    
    // Create text layer
    // ------------

    if let text = text {
      let textLayer = createTextLayer(text, layers: layers)
      layers = addTextLayer(textLayer: textLayer, layers: layers)
    }
    
    layer.sublayers = layers
    
    
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
  private func createTextLayer(_ text: String, layers: [CALayer]) -> CALayer {
    let textLayer = CosmosLayerHelper.createTextLayer(text,
      font: settings.textFont, color: settings.textColor)
    
    let starsSize = CosmosSize.calculateSizeToFitLayers(layers)
    
    if RightToLeft.isRightToLeft(self) {
      CosmosText.position(textLayer, starsSize: CGSize(width: 0, height: starsSize.height), textMargin: 0)
    } else {
      CosmosText.position(textLayer, starsSize: starsSize, textMargin: settings.textMargin)
    }
    
    layer.addSublayer(textLayer)
    
    return textLayer
  }
  
  /**
   
   Adds text layer to the array of layers
   
   - parameter textLayer: A text layer.
   - parameter layers: An array where the text layer will be added.
   - returns: An array of layer with the text layer.
   
   */
  private func addTextLayer(textLayer: CALayer, layers: [CALayer]) -> [CALayer] {
    var allLayers = layers
    // Position stars after the text for right-to-left languages
    if RightToLeft.isRightToLeft(self) {
      for starLayer in layers {
        starLayer.position.x += textLayer.bounds.width + CGFloat(settings.textMargin);
      }
      
      allLayers.insert(textLayer, at: 0)
    } else {
      allLayers.append(textLayer)
    }
    
    return allLayers
  }
  
  /**

  Updates the size to fit all the layers containing stars and text.
  
  - parameter layers: Array of layers containing stars and the text.

  */
  private func updateSize(_ layers: [CALayer]) {
    viewSize = CosmosSize.calculateSizeToFitLayers(layers)
    invalidateIntrinsicContentSize()

    // Stretch the view to include all stars and the text.
    // Needed when used without Auto Layout to receive touches for all stars.
    frame.size = intrinsicContentSize
  }
  
  /// Returns the content size to fit all the star and text layers.
  override open var intrinsicContentSize:CGSize {
    return viewSize
  }
  
  // MARK: - Accessibility
  
  private func updateAccessibility() {
    CosmosAccessibility.update(self, rating: rating, text: text, settings: settings)
  }
  
  /// Called by the system in accessibility voice-over mode when the value is incremented by the user.
  open override func accessibilityIncrement() {
    super.accessibilityIncrement()
    
    rating += CosmosAccessibility.accessibilityIncrement(rating, settings: settings)
    didTouchCosmos?(rating)
    didFinishTouchingCosmos?(rating)
  }
  
  /// Called by the system in accessibility voice-over mode when the value is decremented by the user.
  open override func accessibilityDecrement() {
    super.accessibilityDecrement()
    
    rating -= CosmosAccessibility.accessibilityDecrement(rating, settings: settings)
    didTouchCosmos?(rating)
    didFinishTouchingCosmos?(rating)
  }
  
  // MARK: - Touch recognition
  
  /// Closure will be called when user touches the cosmos view. The touch rating argument is passed to the closure.
  open var didTouchCosmos: ((Double)->())?
  
  /// Closure will be called when the user lifts finger from the cosmos view. The touch rating argument is passed to the closure.
  open var didFinishTouchingCosmos: ((Double)->())?
  
  /// Overriding the function to detect the first touch gesture.
  open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    guard let location = touchLocationFromBeginningOfRating(touches) else { return }
    onDidTouch(location)
  }
  
  /// Overriding the function to detect touch move.
  open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    guard let location = touchLocationFromBeginningOfRating(touches) else { return }
    onDidTouch(location)
  }
  
  /// Returns the distance of the touch relative to the left edge of the first star
  func touchLocationFromBeginningOfRating(_ touches: Set<UITouch>) -> CGFloat? {
    guard let touch = touches.first else { return nil }
    var location = touch.location(in: self).x
    
    // In right-to-left languages, the first star will be on the right
    if RightToLeft.isRightToLeft(self) { location = bounds.width - location }
    
    return location
  }
  
  /// Detecting event when the user lifts their finger.
  open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    
    didFinishTouchingCosmos?(rating)
  }

  /**
   
   Detecting event when the touches are cancelled (can happen in a scroll view).
   Behave as if user has lifted their finger.
   
   */
  open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesCancelled(touches, with: event)
    
    didFinishTouchingCosmos?(rating)
  }

  /**

  Called when the view is touched.

  - parameter locationX: The horizontal location of the touch relative to the width of the stars.
  
  - parameter starsWidth: The width of the stars excluding the text.
  
  */
  func onDidTouch(_ locationX: CGFloat) {
    let calculatedTouchRating = CosmosTouch.touchRating(locationX, settings: settings)
    
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
  
  /// Increase the hitsize of the view if it's less than 44px for easier touching.
  override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
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
      settings.textFont = settings.textFont.withSize(CGFloat(textSize))
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
  
  @IBInspectable var filledImage: UIImage? {
    didSet {
      settings.filledImage = filledImage
    }
  }
  
  @IBInspectable var emptyImage: UIImage? {
    didSet {
      settings.emptyImage = emptyImage
    }
  }
  
  /// Draw the stars in interface buidler
  open override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    
    update()
  }
}
