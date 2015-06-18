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
  
  // MARK: - Correct precise fill level
  
  func testCorrectPreciseFillLevel() {
    let result = StarRating.correctPreciseFillLevel(0.5)
    
    XCTAssertEqual(0.5, result)
  }
  
  func testCorrectPreciseFillLevel_moreThanHalf() {
    let result = StarRating.correctPreciseFillLevel(0.7)
    
    XCTAssertEqual(0.62, result)
  }
  
  func testCorrectPreciseFillLevel_lessThanHalf() {
    let result = StarRating.correctPreciseFillLevel(0.3)
    
    XCTAssertEqual(0.38, result)
  }
  
  func testCorrectPreciseFillLevel_one() {
    let result = StarRating.correctPreciseFillLevel(1)
    
    XCTAssertEqual(0.8, result)
  }
  
  func testCorrectPreciseFillLevel_zero() {
    let result = StarRating.correctPreciseFillLevel(0)
    
    XCTAssertEqual(0.2, result)
  }
  
  func testCorrectPreciseFillLevel_moreThanOne() {
    let result = StarRating.correctPreciseFillLevel(1.1)
    
    XCTAssertEqual(0.8, result)
  }
  
  func testCorrectPreciseFillLevel_lessThanZero() {
    let result = StarRating.correctPreciseFillLevel(-0.2)
    
    XCTAssertEqual(0.2, result)
  }
  
  // MARK: - Number of filled stars
  
  func testNumberOfFilledStars() {
    let result = StarRating.numberOfFilledStars(2.6, totalNumberOfStars: 5)
    XCTAssertEqual(2.6, result)
  }
  
  func testNumberOfFilledStars_ratingIsBiggerThanNumberOfStars() {
    let result = StarRating.numberOfFilledStars(3.6, totalNumberOfStars: 3)
    XCTAssertEqual(3, result)
  }
  
  func testNumberOfFilledStars_ratingIsNegative() {
    let result = StarRating.numberOfFilledStars(-0.6, totalNumberOfStars: 5)
    XCTAssertEqual(0, result)
  }
  
  // MARK: - Position star layers
  
  func testPositionStarLayers() {
    let layerOne = CALayer()
    layerOne.bounds = CGRect(origin: CGPoint(), size: CGSize(width: 20, height: 2))
      
    let layerTwo = CALayer()
    layerTwo.bounds = CGRect(origin: CGPoint(), size: CGSize(width: 20, height: 2))
    
    let layerThree = CALayer()
    layerThree.bounds = CGRect(origin: CGPoint(), size: CGSize(width: 20, height: 2))
    
    let layers = [layerOne, layerTwo, layerThree]
      
    StarRating.positionStarLayers(layers, marginBetweenStars: 5)
    
    XCTAssertEqual(0, layerOne.position.x)
    XCTAssertEqual(25, layerTwo.position.x)
    XCTAssertEqual(50, layerThree.position.x)
  }
}