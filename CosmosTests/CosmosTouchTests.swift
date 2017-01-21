import XCTest
@testable import Cosmos

class CosmosTouchTests: XCTestCase {
  var settings: CosmosSettings!
  
  override func setUp() {
    settings = CosmosSettings()
    settings.totalStars = 5
    settings.starSize = 20
    settings.starMargin = 5
    settings.minTouchRating = 0
  }
  
  // MARK: preciseRating
  
  func testPreciseRating() {
    var result = CosmosTouch.preciseRating(position: 5, numberOfStars: 5, starSize: 20, starMargin: 5)
    XCTAssertEqual(0.25, result)
    
    result = CosmosTouch.preciseRating(position: 20, numberOfStars: 5, starSize: 20, starMargin: 5)
    XCTAssertEqual(1, result)
    
    result = CosmosTouch.preciseRating(position: 23, numberOfStars: 5, starSize: 20, starMargin: 5)
    XCTAssertEqual(1, result)
    
    result = CosmosTouch.preciseRating(position: 25, numberOfStars: 5, starSize: 20, starMargin: 5)
    XCTAssertEqual(1, result)
    
    result = CosmosTouch.preciseRating(position: 30, numberOfStars: 5, starSize: 20, starMargin: 5)
    XCTAssertEqual(1.25, result)
    
    result = CosmosTouch.preciseRating(position: 35, numberOfStars: 5, starSize: 20, starMargin: 5)
    XCTAssertEqual(1.5, result)
    
    result = CosmosTouch.preciseRating(position: 45, numberOfStars: 5, starSize: 20, starMargin: 5)
    XCTAssertEqual(2, result)
    
    result = CosmosTouch.preciseRating(position: 49, numberOfStars: 5, starSize: 20, starMargin: 5)
    XCTAssertEqual(2, result)
    
    result = CosmosTouch.preciseRating(position: 52, numberOfStars: 5, starSize: 20, starMargin: 5)
    XCTAssertEqual(2.1, result)
    
    result = CosmosTouch.preciseRating(position: 300, numberOfStars: 5, starSize: 20, starMargin: 5)
    XCTAssertEqual(5, result)
    
    result = CosmosTouch.preciseRating(position: -50, numberOfStars: 5, starSize: 20, starMargin: 5)
    XCTAssertEqual(0, result)
  }
  
  // MARK: - Touch rating
  
  func testTouchRating_full_three() {
    settings.fillMode = .full
    let result = CosmosTouch.touchRating(75, settings: settings)
    XCTAssertEqual(3, result)
  }
  
  func testTouchRating_full_threeRounded() {
    settings.fillMode = .full
    let result = CosmosTouch.touchRating(60, settings: settings)
    XCTAssertEqual(3, result)
  }
  
  func testTouchRating_full_two() {
    settings.fillMode = .full
    let result = CosmosTouch.touchRating(50, settings: settings)
    XCTAssertEqual(2, result)
  }

  func testTouchRating_biggerThanWidth() {
    settings.fillMode = .full
    let result = CosmosTouch.touchRating(600, settings: settings)
    XCTAssertEqual(5, result)
  }

  func testTouchRating_lessThanWidth() {
    settings.fillMode = .full
    let result = CosmosTouch.touchRating(-100, settings: settings)
    XCTAssertEqual(0, result)
  }

  func testTouchRating_half() {
    settings.fillMode = .half
    let result = CosmosTouch.touchRating(10, settings: settings)
    XCTAssertEqual(0.5, result)
  }
  
  func testTouchRating_half_one() {
    settings.fillMode = .half
    let result = CosmosTouch.touchRating(15, settings: settings)
    XCTAssertEqual(1, result)
  }
  
  func testTouchRating_half_one_onMargin() {
    settings.fillMode = .half
    let result = CosmosTouch.touchRating(23, settings: settings)
    XCTAssertEqual(1, result)
  }
  
  func testTouchRating_half_oneOverMargin() {
    settings.fillMode = .half
    let result = CosmosTouch.touchRating(25, settings: settings)
    XCTAssertEqual(1, result)
  }
  
  func testTouchRating_half_oneAndAHalf() {
    settings.fillMode = .half
    let result = CosmosTouch.touchRating(26, settings: settings)
    XCTAssertEqual(1.5, result)
  }

  func testTouchRating_precise_oneTenth() {
    settings.fillMode = .precise
    let result = CosmosTouch.touchRating(2, settings: settings)
    XCTAssertEqual(0.1, result)
  }
  
  func testTouchRating_precise_eightTenths() {
    settings.fillMode = .precise
    let result = CosmosTouch.touchRating(16, settings: settings)
    XCTAssertEqual(0.8, result)
  }
  
  func testTouchRating_precise_one() {
    settings.fillMode = .precise
    let result = CosmosTouch.touchRating(23, settings: settings)
    XCTAssertEqual(1, result)
  }

  func testTouchRating_minRating() {
    settings.fillMode = .precise
    settings.minTouchRating = 1
    let result = CosmosTouch.touchRating(0, settings: settings)
    XCTAssertEqual(1, result)
  }
}
