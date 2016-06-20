import XCTest
@testable import Cosmos

class CosmosDisplayedRatingTests: XCTestCase {
  // Calculate
  // --------------
  
  func testCalculate() {
    var result = CosmosRating.displayedRatingFromPreciseRating(4.6, fillMode: .half, totalStars: 5)
    XCTAssertEqual(4.5, result)
    
    result = CosmosRating.displayedRatingFromPreciseRating(4.6, fillMode: .full, totalStars: 5)
    XCTAssertEqual(5, result)
    
    result = CosmosRating.displayedRatingFromPreciseRating(4.6, fillMode: .precise, totalStars: 5)
    XCTAssertEqual(4.6, result)
  }
  
  func testCalculateEdgeCases() {
    // Rating is more than number of stars
    
    var result = CosmosRating.displayedRatingFromPreciseRating(7, fillMode: .half, totalStars: 5)
    XCTAssertEqual(5, result)
    
    
    // Rating is less than zero
    result = CosmosRating.displayedRatingFromPreciseRating(-1, fillMode: .half, totalStars: 5)
    XCTAssertEqual(0, result)
  }
  
  // MARK: - Star fill level
  
  func testStarFillLevel_moreThanOneRemain() {
    let result = CosmosRating.starFillLevel(ratingRemainder: 1.1, fillMode: .precise)
    
    XCTAssertEqual(1, result)
  }
  
  func testStarFillLevel_negativeRemainder() {
    let result = CosmosRating.starFillLevel(ratingRemainder: -0.1, fillMode: .precise)
    
    XCTAssertEqual(0, result)
  }
  
  func testStarFillLevel_partiallyFileldPrecise() {
    let result = CosmosRating.starFillLevel(ratingRemainder: 0.67, fillMode: .precise)
    
    XCTAssertEqual(0.67, result)
  }
  
  func testStarFillLevel_partiallyFileldHalf() {
    let result = CosmosRating.starFillLevel(ratingRemainder: 0.67, fillMode: .half)
    
    XCTAssertEqual(0.5, result)
  }
  
  func testStarFillLevel_partiallyFileldFull() {
    let result = CosmosRating.starFillLevel(ratingRemainder: 0.67, fillMode: .full)
    
    XCTAssertEqual(1, result)
  }
  
  // MARK: - Round fill level
  
  func testRoundFillLevel_full() {
    XCTAssertEqual(0,   CosmosRating.roundFillLevel(0,    fillMode: .full))
    XCTAssertEqual(0,   CosmosRating.roundFillLevel(0.4,  fillMode: .full))
    XCTAssertEqual(1,   CosmosRating.roundFillLevel(0.5,  fillMode: .full))
    XCTAssertEqual(1,   CosmosRating.roundFillLevel(1,    fillMode: .full))
  }
  
  func testRoundFillLevel_half() {
    XCTAssertEqual(0,   CosmosRating.roundFillLevel(0,    fillMode: .half))
    XCTAssertEqual(0,   CosmosRating.roundFillLevel(0.1,  fillMode: .half))
    XCTAssertEqual(0.5, CosmosRating.roundFillLevel(0.25, fillMode: .half))
    XCTAssertEqual(0.5, CosmosRating.roundFillLevel(0.3,  fillMode: .half))
    XCTAssertEqual(0.5, CosmosRating.roundFillLevel(0.5,  fillMode: .half))
    XCTAssertEqual(0.5, CosmosRating.roundFillLevel(0.6,  fillMode: .half))
    XCTAssertEqual(1,   CosmosRating.roundFillLevel(0.75, fillMode: .half))
    XCTAssertEqual(1,   CosmosRating.roundFillLevel(0.9,  fillMode: .half))
    XCTAssertEqual(1,   CosmosRating.roundFillLevel(1,    fillMode: .half))
  }
  
  func testRoundFillLevel_precise() {
    XCTAssertEqual(0,   CosmosRating.roundFillLevel(0,    fillMode: .precise))
    XCTAssertEqual(0.1, CosmosRating.roundFillLevel(0.1,  fillMode: .precise))
    XCTAssertEqual(0.25,CosmosRating.roundFillLevel(0.25, fillMode: .precise))
    XCTAssertEqual(0.9, CosmosRating.roundFillLevel(0.9,  fillMode: .precise))
  }
  
  // MARK: - Number of filled stars
  
  func testNumberOfFilledStars() {
    let result = CosmosRating.numberOfFilledStars(2.6, totalNumberOfStars: 5)
    XCTAssertEqual(2.6, result)
  }
  
  func testNumberOfFilledStars_ratingIsBiggerThanNumberOfStars() {
    let result = CosmosRating.numberOfFilledStars(3.6, totalNumberOfStars: 3)
    XCTAssertEqual(3, result)
  }
  
  func testNumberOfFilledStars_ratingIsNegative() {
    let result = CosmosRating.numberOfFilledStars(-0.6, totalNumberOfStars: 5)
    XCTAssertEqual(0, result)
  }
}

