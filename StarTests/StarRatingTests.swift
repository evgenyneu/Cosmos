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
  
  func testStarFillLevel_partiallyFileldPrecise() {
    let result = StarRating.starFillLevel(ratingRemainder: 0.67, starFillMode: .Precise,
      correctFillLevelForPrecise: false)
    
    XCTAssertEqual(0.67, result)
  }
  
  func testStarFillLevel_partiallyFileldPreciseWithCorrection() {
    var result = StarRating.starFillLevel(ratingRemainder: 0.67, starFillMode: .Precise,
      correctFillLevelForPrecise: true)
    
    result = Helpers.roundToPlaces(result, places: 3)
    XCTAssertEqual(0.602, result)
  }
  
  func testStarFillLevel_partiallyFileldHalf() {
    let result = StarRating.starFillLevel(ratingRemainder: 0.67, starFillMode: .Half,
      correctFillLevelForPrecise: false)
    
    XCTAssertEqual(0.5, result)
  }
  
  func testStarFillLevel_partiallyFileldFull() {
    let result = StarRating.starFillLevel(ratingRemainder: 0.67, starFillMode: .Full,
      correctFillLevelForPrecise: false)
    
    XCTAssertEqual(1, result)
  }
}