import XCTest
@testable import Star

class StarTests: XCTestCase {
  
  var star: StarRatingView!
  
  override func setUp() {
    super.setUp()
    
    star = StarRatingView()
  }
  
  // MARK: - Content size
  
  func testShowContentSize() {
    star.settings.starSize = 10
    star.settings.starMargin = 4

    star.rating = 4
    
    let size = star.intrinsicContentSize()
    
    // 5 * 10 (width of 5 stars)
    //   + 4 * 6 (4 margins between stars)
    XCTAssertEqual(66, size.width)
    
    XCTAssertEqual(10, size.height)
  }
  
  func testShowContentSizeWithText() {
    star.settings.starSize = 10
    star.settings.starMargin = 4
    
    star.settings.textFont = UIFont.systemFontOfSize(15)
    star.settings.textMargin = 8
    
    star.rating = 4
    star.text = "123"
    
    let sizeAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(15)]
    let textSize = NSString(string: "123").sizeWithAttributes(sizeAttributes)
    
    let size = star.intrinsicContentSize()
    
    // 58 (width of 5 stars)
    //   + 15 * 50 / 100 (margin between stars and text)
    //   + fontSize.width (width of text)
    XCTAssertEqual(66 + 8 + textSize.width, size.width)
  }

  // MARK: - On did touch
  
  func testOnDidTouch_updateCurrentRating() {
    star.settings.updateOnTouch = true

    star.onDidTouch(140, starsWidth: 400)
    
    XCTAssertEqual(2, star.rating)
  }

  func testOnDidTouch_updateTheStars() {
    star.rating = 0
    star.settings.updateOnTouch = true
    star.settings.fillMode = .Precise

    star.onDidTouch(219, starsWidth: 500)

    XCTAssertEqual(2.19, star.rating)
  }

  func testOnDidTouch_doNotUpdateOnTouch() {
    star.rating = 0
    star.settings.updateOnTouch = false
    
    star.onDidTouch(200, starsWidth: 500)
    
    XCTAssertEqual(0, star.rating)
  }

  func testOnDidTouch_executeTheCallback() {
    var callbackRating: Double?
    star.settings.fillMode = .Full
    
    star.touchedTheStar = { rating in
      callbackRating = rating
    }
    
    star.onDidTouch(312, starsWidth: 500)
    
    XCTAssertEqual(3, callbackRating!)
  }
  
  func testOnDidTouch_minimumRating() {
    star.settings.minTouchRating = 0.9
    star.settings.updateOnTouch = true
    
    star.onDidTouch(0, starsWidth: 400)
    
    XCTAssertEqual(0.9, star.rating)
  }
}
