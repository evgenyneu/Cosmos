import XCTest
@testable import Cosmos

// Ensure touch closures are called in accessibility mode
class CosmosAccessibilityCallbacksTests: XCTestCase {
  var obj: CosmosView!
  
  override func setUp() {
    super.setUp()
    
    obj = CosmosView()
  }
  
  func testAccessibilityIncrement_callsDidTouchCosmos() {
    var didTouchCosmosRating: Double? = nil
    
    obj.didTouchCosmos = { rating in
      didTouchCosmosRating = rating
    }
    
    obj.rating = 3.6
    obj.settings.fillMode = .half
    
    obj.accessibilityIncrement()
    
    XCTAssertEqual(4, didTouchCosmosRating)
  }
  
  func testAccessibilityDecrement_callsDidTouchCosmos() {
    var didTouchCosmosRating: Double? = nil
    
    obj.didTouchCosmos = { rating in
      didTouchCosmosRating = rating
    }
    
    obj.rating = 3.6
    obj.settings.fillMode = .half
    
    obj.accessibilityDecrement()
    
    XCTAssertEqual(3.5, didTouchCosmosRating)
  }
  
  func testAccessibilityIncrement_callsDidFinishTouchingCosmos() {
    var didFinishTouchingCosmosRating: Double? = nil
    
    obj.didFinishTouchingCosmos = { rating in
      didFinishTouchingCosmosRating = rating
    }
    
    obj.rating = 3.6
    obj.settings.fillMode = .half
    
    obj.accessibilityIncrement()
    
    XCTAssertEqual(4, didFinishTouchingCosmosRating)
  }
  
  func testAccessibilityDecrement_callsDidFinishTouchingCosmos() {
    var didFinishTouchingCosmosRating: Double? = nil
    
    obj.didFinishTouchingCosmos = { rating in
      didFinishTouchingCosmosRating = rating
    }
    
    obj.rating = 3.6
    obj.settings.fillMode = .half
    
    obj.accessibilityDecrement()
    
    XCTAssertEqual(3.5, didFinishTouchingCosmosRating)
  }
}
