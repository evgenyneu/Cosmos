import XCTest
@testable import Star

class StarTests: XCTestCase {
  
  var star: StarRatingView!
  
  override func setUp() {
    super.setUp()
    
    star = StarRatingView()
  }
  
  // MARK: - Content size
  
  func testContentSize() {
    star.settings.starSize = 10
    star.settings.starMargin = 4

    star.show(rating: 4)
    
    let size = star.intrinsicContentSize()
    
    // 5 * 10 (width of 5 stars)
    //   + 4 * 6 (4 margins between stars)
    XCTAssertEqual(66, size.width)
    
    XCTAssertEqual(10, size.height)
  }
  
  func testContentSizeWithText() {
    star.settings.starSize = 10
    star.settings.starMargin = 4
    
    star.settings.textFont = UIFont.systemFontOfSize(15)
    star.settings.textMargin = 8
    
    star.show(rating: 4, text: "123")
    
    let sizeAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(15)]
    let textSize = NSString(string: "123").sizeWithAttributes(sizeAttributes)
    
    let size = star.intrinsicContentSize()
    
    // 58 (width of 5 stars)
    //   + 15 * 50 / 100 (margin between stars and text)
    //   + fontSize.width (width of text)
    XCTAssertEqual(66 + 8 + textSize.width, size.width)
  }
}
