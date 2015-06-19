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
    star.settings.starFont = UIFont.systemFontOfSize(10)
    star.settings.marginPercent = 20

    star.show(rating: 4)
    
    let size = star.intrinsicContentSize()
    
    // 5 * 10 (width of 5 stars)
    //   + 4 * 10 * 20 / 100 (4 margins between stars)
    //   == 58
    XCTAssertEqual(size.width, 58)
    
    
    let sizeAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(10)]
    let fontSize = NSString(string: "★").sizeWithAttributes(sizeAttributes)
    
    XCTAssertEqual(size.height, fontSize.height)
  }
  
  func testContentSizeWithText() {
    star.settings.starFont = UIFont.systemFontOfSize(10)
    star.settings.marginPercent = 20
    
    star.settings.textFont = UIFont.systemFontOfSize(15)
    star.settings.marginBetweenStarsAndTextRelativeToFontSize = 50
    
    star.show(rating: 4, text: "123")
    
    let sizeAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(15)]
    let textSize = NSString(string: "123").sizeWithAttributes(sizeAttributes)
    
    let size = star.intrinsicContentSize()
    
    // 58 (width of 5 stars)
    //   + 15 * 0.5 (margin between stars and text)
    //   + fontSize.width (width of text)
    XCTAssertEqual(size.width, 58 + 7.5 + textSize.width)
  }
  
}
