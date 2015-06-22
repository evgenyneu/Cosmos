import XCTest
@testable import Cosmos

class CosmosViewTests: XCTestCase {
  
  var obj: CosmosView!
  
  override func setUp() {
    super.setUp()
    
    obj = CosmosView()
  }
  
  // MARK: - Content size
  
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
    
    let sizeAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(15)]
    let textSize = NSString(string: "123").sizeWithAttributes(sizeAttributes)
    
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

    XCTAssertEqual(2.19, obj.rating)
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
    
    obj.touchedTheStar = { rating in
      callbackRating = rating
    }
    
    obj.onDidTouch(312, starsWidth: 500)
    
    XCTAssertEqual(3, callbackRating!)
  }
  
  func testOnDidTouch_minimumRating() {
    obj.settings.minTouchRating = 0.9
    obj.settings.updateOnTouch = true
    
    obj.onDidTouch(0, starsWidth: 400)
    
    XCTAssertEqual(0.9, obj.rating)
  }
}
