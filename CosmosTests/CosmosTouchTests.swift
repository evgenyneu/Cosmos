import XCTest
@testable import Cosmos

class CosmosTouchTests: XCTestCase {
  // MARK: - Touch rating
  
  func testTouchRating_full() {
    var settings = CosmosSettings()
    settings.fillMode = .Full
    settings.minTouchRating = 0
    let result = CosmosTouch.touchRating(200, starsWidth: 500, settings: settings)
    XCTAssertEqual(2, result)
  }
  
  func testTouchRating_fullWithMoreStars() {
    var settings = CosmosSettings()

    settings.fillMode = .Full
    settings.totalStars = 500
    settings.minTouchRating = 0

    let result = CosmosTouch.touchRating(200, starsWidth: 500, settings: settings)
    XCTAssertEqual(200, result)
  }

  func testTouchRating_biggerThanWidth() {
    var settings = CosmosSettings()
    
    settings.fillMode = .Full
    settings.minTouchRating = 0
    
    let result = CosmosTouch.touchRating(600, starsWidth: 500, settings: settings)
    XCTAssertEqual(5, result)
  }

  func testTouchRating_lessThanWidth() {
    var settings = CosmosSettings()
    
    settings.fillMode = .Full
    settings.minTouchRating = 0
    
    let result = CosmosTouch.touchRating(-100, starsWidth: 500, settings: settings)
    XCTAssertEqual(0, result)
  }

  func testTouchRating_half() {
    var settings = CosmosSettings()
    
    settings.fillMode = .Half
    settings.minTouchRating = 0
    
    let result = CosmosTouch.touchRating(200, starsWidth: 500, settings: settings)
    XCTAssertEqual(2.5, result)
  }

  func testTouchRating_precise() {
    var settings = CosmosSettings()
    
    settings.fillMode = .Precise
    settings.minTouchRating = 0
    
    let result = CosmosTouch.touchRating(215, starsWidth: 500, settings: settings)
    XCTAssertEqual(2.15, result)
  }

  func testTouchRating_minRating() {
    var settings = CosmosSettings()
    
    settings.fillMode = .Precise
    settings.minTouchRating = 1.1
    
    let result = CosmosTouch.touchRating(0, starsWidth: 500, settings: settings)
    XCTAssertEqual(1.1, result)
  }
}