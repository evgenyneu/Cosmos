import XCTest
@testable import Star

class StarTouchTests: XCTestCase {
  
  var star: StarRatingView!
  
  override func setUp() {
    super.setUp()
    
    star = StarRatingView()
  }
  
  // MARK: - Touch rating
  
  func testTouchRating_full() {
    var settings = StarRatingSettings()
    settings.fillMode = .Full
    settings.minTouchRating = 0
    let result = StarTouch.touchRating(200, starsWidth: 500, settings: settings)
    XCTAssertEqual(2.25, result)
  }
  
  func testTouchRating_fullWithMoreStars() {
    var settings = StarRatingSettings()

    settings.fillMode = .Full
    settings.totalStars = 500
    settings.minTouchRating = 0

    let result = StarTouch.touchRating(200, starsWidth: 500, settings: settings)
    XCTAssertEqual(200.25, result)
  }

  func testTouchRating_biggerThanWidth() {
    var settings = StarRatingSettings()
    
    settings.fillMode = .Full
    settings.minTouchRating = 0
    
    let result = StarTouch.touchRating(600, starsWidth: 500, settings: settings)
    XCTAssertEqual(5, result)
  }

  func testTouchRating_lessThanWidth() {
    var settings = StarRatingSettings()
    
    settings.fillMode = .Full
    settings.minTouchRating = 0
    
    let result = StarTouch.touchRating(-100, starsWidth: 500, settings: settings)
    XCTAssertEqual(0, result)
  }

  func testTouchRating_half() {
    var settings = StarRatingSettings()
    
    settings.fillMode = .Half
    settings.minTouchRating = 0
    
    let result = StarTouch.touchRating(200, starsWidth: 500, settings: settings)
    XCTAssertEqual(2.25, result)
  }

  func testTouchRating_precise() {
    var settings = StarRatingSettings()
    
    settings.fillMode = .Precise
    settings.minTouchRating = 0
    
    let result = StarTouch.touchRating(200, starsWidth: 500, settings: settings)
    XCTAssertEqual(2, result)
  }

  func testTouchRating_minRating() {
    var settings = StarRatingSettings()
    
    settings.fillMode = .Precise
    settings.minTouchRating = 1.1
    
    let result = StarTouch.touchRating(0, starsWidth: 500, settings: settings)
    XCTAssertEqual(1.1, result)
  }
}