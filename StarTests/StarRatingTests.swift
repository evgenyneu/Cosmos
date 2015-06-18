import XCTest
@testable import Star

class StarRatingTests: XCTestCase {
  
  // MARK: - Star fill level
  
  func testStarFillLevel_moreThanOneRemain() {
    let result = StarRating.starFillLevel(ratingRemainder: 1.1, starFillMode: .Precise,
      correctFillLevelForPrecise: false)
    
    XCTAssertEqual(1, result)
  }
  
  func testStarFillLevel_negativeRemainder() {
    let result = StarRating.starFillLevel(ratingRemainder: -0.1, starFillMode: .Precise,
      correctFillLevelForPrecise: false)
    
    XCTAssertEqual(0, result)
  }
}