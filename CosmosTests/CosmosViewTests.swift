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
    
    let size = obj.intrinsicContentSize()
    
    // 5 * 10 (width of 5 stars)
    //   + 4 * 6 (4 margins between stars)
    XCTAssertEqual(66, size.width)
    
    XCTAssertEqual(10, size.height)
  }
  
  func testShowContentSizeWithText() {
    obj.settings.starSize = 10
    obj.settings.starMargin = 4
    
    obj.settings.textFont = UIFont.systemFontOfSize(15)
    obj.settings.textMargin = 8
    
    obj.rating = 4
    obj.text = "123"
    
    let sizeAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15)]
    let textSize = NSString(string: "123").size(attributes: sizeAttributes)
    
    let size = obj.intrinsicContentSize()
    
    // 58 (width of 5 stars)
    //   + 15 * 50 / 100 (margin between stars and text)
    //   + fontSize.width (width of text)
    XCTAssertEqual(66 + 8 + textSize.width, size.width)
  }

  // MARK: - On did touch
  
  func testOnDidTouch_updateCurrentRating() {
    obj.settings.updateOnTouch = true

    obj.onDidTouch(140, starsWidth: 400)
    
    XCTAssertEqual(2, obj.rating)
  }

  func testOnDidTouch_updateTheStars() {
    obj.rating = 0
    obj.settings.updateOnTouch = true
    obj.settings.fillMode = .Precise

    obj.onDidTouch(219, starsWidth: 500)

    XCTAssertEqual(2.19, Helpers.roundToPlaces(obj.rating, places: 2))
  }

  func testOnDidTouch_doNotUpdateOnTouch() {
    obj.rating = 0
    obj.settings.updateOnTouch = false
    
    obj.onDidTouch(200, starsWidth: 500)
    
    XCTAssertEqual(0, obj.rating)
  }

  func testOnDidTouch_executeTheCallback() {
    var callbackRating: Double?
    obj.settings.fillMode = .Full
    
    obj.didTouchCosmos = { rating in
      callbackRating = rating
    }
    
    obj.onDidTouch(312, starsWidth: 500)
    
    XCTAssertEqual(3, callbackRating!)
  }
  
  func testOnDidTouch_executeTheCallbackOnce_whenRatingRemainsTheSame() {
    obj.settings.fillMode = .Full
    
    var closureCalledTimes = 0
    
    obj.didTouchCosmos = { rating in
      closureCalledTimes += 1
    }
    
    obj.onDidTouch(312, starsWidth: 500)
    
    // Rating has not changed
    obj.onDidTouch(312, starsWidth: 500)
    XCTAssertEqual(1, closureCalledTimes)
    
    // Change the rating
    obj.onDidTouch(112, starsWidth: 500)
    XCTAssertEqual(2, closureCalledTimes)
  }
  
  func testOnDidTouch_minimumRating() {
    obj.settings.minTouchRating = 0.9
    obj.settings.updateOnTouch = true
    
    obj.onDidTouch(0, starsWidth: 400)
    
    XCTAssertEqual(0.9, obj.rating)
  }
  
  // MARK: Accesibility

  func testAccessibility() {
    XCTAssert(obj.isAccessibilityElement)
    obj.rating = 2.6
    obj.settings.fillMode = .Half
    obj.settings.updateOnTouch = false
    XCTAssertEqual("Rating", obj.accessibilityLabel)
    XCTAssertEqual("2.5", obj.accessibilityValue)
    XCTAssertEqual(UIAccessibilityTraitNone, obj.accessibilityTraits)
  }
  
  func testAccessibilityIncrement() {
    obj.rating = 3.6
    obj.settings.fillMode = .Half
  
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
    obj.settings.fillMode = .Half
    
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
