import XCTest
@testable import Cosmos

class CosmosViewTests: XCTestCase {
  
  var obj: CosmosView!
  
  override func setUp() {
    super.setUp()
    
    obj = CosmosView()
  }
  
  // MARK: - Content size
  
  func testCalculateViewSizeOnInit() {
    XCTAssertEqual(CGSize(width: 120, height: 20), obj.frame.size)
  }
  
  func testShowContentSize() {
    obj.settings.starSize = 10
    obj.settings.starMargin = 4

    obj.rating = 4
    
    let size = obj.intrinsicContentSize
    
    // 5 * 10 (width of 5 stars)
    //   + 4 * 6 (4 margins between stars)
    XCTAssertEqual(66, size.width)
    
    XCTAssertEqual(10, size.height)
  }
  
  func testUpdateFrameSize_whenSettingsChange() {
    obj.settings.starSize = 10
    obj.settings.starMargin = 4
    obj.rating = 4
    
    // 5 * 10 (width of 5 stars)
    //   + 4 * 6 (4 margins between stars)
    XCTAssertEqual(66, obj.frame.width)
    
    obj.settings.starSize = 20
    // 5 * 20 (width of 5 stars)
    //   + 4 * 6 (4 margins between stars)
    XCTAssertEqual(116, obj.frame.width)
  }
  
  func testShowContentSizeWithText() {
    obj.settings.starSize = 10
    obj.settings.starMargin = 4
    
    obj.settings.textFont = UIFont.systemFont(ofSize: 15)
    obj.settings.textMargin = 8
    
    obj.rating = 4
    obj.text = "123"
    
    let sizeAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
    let textSize = NSString(string: "123").size(withAttributes: sizeAttributes)
    
    let size = obj.intrinsicContentSize
    
    // 58 (width of 5 stars)
    //   + 15 * 50 / 100 (margin between stars and text)
    //   + fontSize.width (width of text)
    XCTAssertEqual(66 + 8 + textSize.width, size.width)
    
    // Stars are on the left, followed by the text layer
    XCTAssertEqual(6, obj.layer.sublayers!.count)
    XCTAssertEqual(0, obj.layer.sublayers![0].position.x)
    XCTAssertEqual(10, obj.layer.sublayers![0].bounds.width)
    XCTAssertEqual(14 * 5 - 4 + 8, obj.layer.sublayers![5].position.x)
    XCTAssertEqual(textSize.width, obj.layer.sublayers![5].bounds.width)
  }
  
  func testShowContentSizeWithText_rightToLeft() {
    if #available(iOS 9.0, *) {
      obj.semanticContentAttribute = .forceRightToLeft
      obj.settings.starSize = 10
      obj.settings.starMargin = 4
      obj.settings.totalStars = 5
      
      obj.settings.textFont = UIFont.systemFont(ofSize: 15)
      obj.settings.textMargin = 8
      
      obj.rating = 4
      obj.text = "123"
      
      let sizeAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
      let textSize = NSString(string: "123").size(withAttributes: sizeAttributes)
      
      let size = obj.intrinsicContentSize
      
      // 58 (width of 5 stars)
      //   + 15 * 50 / 100 (margin between stars and text)
      //   + fontSize.width (width of text)
      XCTAssertEqual(66 + 8 + textSize.width, size.width)
      
      // Text layer is on the left, followed by stars
      XCTAssertEqual(6, obj.layer.sublayers!.count)
      XCTAssertEqual(0, obj.layer.sublayers![0].position.x)
      XCTAssertEqual(textSize.width, obj.layer.sublayers![0].bounds.width)
      XCTAssertEqual(textSize.width + 8, obj.layer.sublayers![1].position.x)
      XCTAssertEqual(10, obj.layer.sublayers![1].bounds.width)
    }
  }

  // MARK: - On did touch
  
  func testOnDidTouch_updateCurrentRating() {
    obj.settings.updateOnTouch = true
    obj.settings.starSize = 20
    obj.settings.starMargin = 5
    obj.settings.fillMode = .full

    obj.onDidTouch(50)
    
    XCTAssertEqual(2, obj.rating)
  }

  func testOnDidTouch_updateTheStars() {
    obj.rating = 0
    obj.settings.updateOnTouch = true
    obj.settings.starSize = 20
    obj.settings.starMargin = 5
    obj.settings.fillMode = .precise

    obj.onDidTouch(30)

    XCTAssertEqual(1.25, obj.rating)
  }

  func testOnDidTouch_doNotUpdateOnTouch() {
    obj.rating = 0
    obj.settings.updateOnTouch = false
    
    obj.onDidTouch(200)
    
    XCTAssertEqual(0, obj.rating)
  }

  func testOnDidTouch_executeTheCallback() {
    var callbackRating: Double?
    obj.settings.starSize = 20
    obj.settings.starMargin = 5
    obj.settings.fillMode = .full
    
    obj.didTouchCosmos = { rating in
      callbackRating = rating
    }
    
    obj.onDidTouch(75)
    
    XCTAssertEqual(3, callbackRating!)
  }
  
  func testOnDidTouch_executeTheCallbackOnce_whenRatingRemainsTheSame() {
    obj.settings.starSize = 20
    obj.settings.starMargin = 5
    obj.settings.fillMode = .full
    
    var closureCalledTimes = 0
    
    obj.didTouchCosmos = { rating in
      closureCalledTimes += 1
    }
    
    obj.onDidTouch(75)
    
    // Rating has not changed
    obj.onDidTouch(75)
    XCTAssertEqual(1, closureCalledTimes)
    
    // Change the rating
    obj.onDidTouch(85)
    XCTAssertEqual(2, closureCalledTimes)
  }
  
  func testOnDidTouch_minimumRating() {
    obj.settings.minTouchRating = 0.9
    obj.settings.updateOnTouch = true
    
    obj.onDidTouch(0)
    
    XCTAssertEqual(0.9, obj.rating)
  }
  
  // MARK: touchLocationFromBeginningOfRating
  
  func testTouchLocationFromBeginningOfRating_noTouches() {
    let touches = Set<UITouch>()
    
    let result = obj.touchLocationFromBeginningOfRating(touches)
    
    XCTAssertNil(result)
  }
  
  func testTouchLocationFromBeginningOfRating_returnLocation() {
    let touches = Set<UITouch>([UITouch()])
    let result = obj.touchLocationFromBeginningOfRating(touches)
    XCTAssertEqual(0, result)
  }
  
  func testTouchLocationFromBeginningOfRating_rightToLeft() {
    if #available(iOS 9.0, *) {
      obj.semanticContentAttribute = .forceRightToLeft
      let touches = Set<UITouch>([UITouch()])
      let result = obj.touchLocationFromBeginningOfRating(touches)
      XCTAssertEqual(120, result)
    }
  }
  
  // MARK: Accesibility

  func testAccessibility() {
    XCTAssert(obj.isAccessibilityElement)
    obj.rating = 2.6
    obj.settings.fillMode = .half
    obj.settings.updateOnTouch = false
    XCTAssertEqual("Rating", obj.accessibilityLabel)
    XCTAssertEqual("2.5", obj.accessibilityValue)
    XCTAssertEqual(UIAccessibilityTraitNone, obj.accessibilityTraits)
  }
  
  func testAccessibilityIncrement() {
    obj.rating = 3.6
    obj.settings.fillMode = .half
  
    obj.accessibilityIncrement()
    
    XCTAssertEqual(4.0, obj.rating)
    XCTAssertEqual("4", obj.accessibilityValue)
    
    obj.accessibilityIncrement()
    XCTAssertEqual(4.5, obj.rating)
    
    obj.accessibilityIncrement()
    XCTAssertEqual(5, obj.rating)
    
    obj.accessibilityIncrement()
    XCTAssertEqual(5, obj.rating)
    XCTAssertEqual("5", obj.accessibilityValue)
    
    obj.settings.totalStars = 7
    obj.accessibilityIncrement()
    XCTAssertEqual(5.5, obj.rating)
    XCTAssertEqual("5.5", obj.accessibilityValue)
  }
  
  func testAccessibilityDecrement() {
    obj.rating = 2.6
    obj.settings.fillMode = .half
    
    obj.accessibilityDecrement()
    
    XCTAssertEqual(2.5, obj.rating)
    XCTAssertEqual("2.5", obj.accessibilityValue)
    
    obj.accessibilityDecrement()
    obj.accessibilityDecrement()
    obj.accessibilityDecrement()
    
    XCTAssertEqual(1, obj.rating)
    XCTAssertEqual("1", obj.accessibilityValue)
    
    obj.accessibilityDecrement()
    XCTAssertEqual(1, obj.rating)
    XCTAssertEqual("1", obj.accessibilityValue)
    
    obj.settings.minTouchRating = 0
    
    obj.accessibilityDecrement()
    XCTAssertEqual(0.5, obj.rating)
    XCTAssertEqual("0.5", obj.accessibilityValue)
  }
}
