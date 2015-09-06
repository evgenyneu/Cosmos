import XCTest
@testable import Cosmos

class CosmosDisplayedRatingTests: XCTestCase {
  // Calculate
  // --------------
  
  func testCalculate() {
    var result = CosmosRating.displayedRatingFromPreciseRating(4.6, fillMode: .Half, totalStars: 5)
    XCTAssertEqual(4.5, result)
    
    result = CosmosRating.displayedRatingFromPreciseRating(4.6, fillMode: .Full, totalStars: 5)
    XCTAssertEqual(5, result)
    
    result = CosmosRating.displayedRatingFromPreciseRating(4.6, fillMode: .Precise, totalStars: 5)
    XCTAssertEqual(4.6, result)
  }
  
  func testCalculateEdgeCases() {
    // Rating is more than number of stars
    
    var result = CosmosRating.displayedRatingFromPreciseRating(7, fillMode: .Half, totalStars: 5)
    XCTAssertEqual(5, result)
    
    
    // Rating is less than zero
    result = CosmosRating.displayedRatingFromPreciseRating(-1, fillMode: .Half, totalStars: 5)
    XCTAssertEqual(0, result)
  }
  
  // MARK: - Star fill level
  
  func testStarFillLevel_moreThanOneRemain() {
    let result = CosmosRating.starFillLevel(ratingRemainder: 1.1, fillMode: .Precise)
    
    XCTAssertEqual(1, result)
  }
  
  func testStarFillLevel_negativeRemainder() {
    let result = CosmosRating.starFillLevel(ratingRemainder: -0.1, fillMode: .Precise)
    
    XCTAssertEqual(0, result)
  }
  
  func testStarFillLevel_partiallyFileldPrecise() {
    let result = CosmosRating.starFillLevel(ratingRemainder: 0.67, fillMode: .Precise)
    
    XCTAssertEqual(0.67, result)
  }
  
  func testStarFillLevel_partiallyFileldHalf() {
    let result = CosmosRating.starFillLevel(ratingRemainder: 0.67, fillMode: .Half)
    
    XCTAssertEqual(0.5, result)
  }
  
  func testStarFillLevel_partiallyFileldFull() {
    let result = CosmosRating.starFillLevel(ratingRemainder: 0.67, fillMode: .Full)
    
    XCTAssertEqual(1, result)
  }
  
  // MARK: - Round fill level
  
  func testRoundFillLevel_full() {
    XCTAssertEqual(0,   CosmosRating.roundFillLevel(0,    fillMode: .Full))
    XCTAssertEqual(0,   CosmosRating.roundFillLevel(0.4,  fillMode: .Full))
    XCTAssertEqual(1,   CosmosRating.roundFillLevel(0.5,  fillMode: .Full))
    XCTAssertEqual(1,   CosmosRating.roundFillLevel(1,    fillMode: .Full))
  }
  
  func testRoundFillLevel_half() {
    XCTAssertEqual(0,   CosmosRating.roundFillLevel(0,    fillMode: .Half))
    XCTAssertEqual(0,   CosmosRating.roundFillLevel(0.1,  fillMode: .Half))
    XCTAssertEqual(0.5, CosmosRating.roundFillLevel(0.25, fillMode: .Half))
    XCTAssertEqual(0.5, CosmosRating.roundFillLevel(0.3,  fillMode: .Half))
    XCTAssertEqual(0.5, CosmosRating.roundFillLevel(0.5,  fillMode: .Half))
    XCTAssertEqual(0.5, CosmosRating.roundFillLevel(0.6,  fillMode: .Half))
    XCTAssertEqual(1,   CosmosRating.roundFillLevel(0.75, fillMode: .Half))
    XCTAssertEqual(1,   CosmosRating.roundFillLevel(0.9,  fillMode: .Half))
    XCTAssertEqual(1,   CosmosRating.roundFillLevel(1,    fillMode: .Half))
  }
  
  func testRoundFillLevel_precise() {
    XCTAssertEqual(0,   CosmosRating.roundFillLevel(0,    fillMode: .Precise))
    XCTAssertEqual(0.1, CosmosRating.roundFillLevel(0.1,  fillMode: .Precise))
    XCTAssertEqual(0.25,CosmosRating.roundFillLevel(0.25, fillMode: .Precise))
    XCTAssertEqual(0.9, CosmosRating.roundFillLevel(0.9,  fillMode: .Precise))
  }
}

