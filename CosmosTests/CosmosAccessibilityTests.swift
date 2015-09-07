import XCTest
@testable import Cosmos

class CosmosAccessibilityTests: XCTestCase {
  var view: UIView!
  var settings: CosmosSettings!
  
  override func setUp() {
    super.setUp()
    
    view = UIView()
    settings = CosmosSettings()
    settings.totalStars = 5
  }
  
  // MARK: - Accesibility value
  
  func testAccesibilityEnabled() {
    CosmosAccessibility.update(view, rating: 5, settings: settings)
    
    XCTAssert(view.isAccessibilityElement)
  }
  
  func testAccesibilityTrait_none() {
    settings.updateOnTouch = false
    CosmosAccessibility.update(view, rating: 5, settings: settings)

    XCTAssertEqual(UIAccessibilityTraitNone, view.accessibilityTraits)
  }
  
  func testAccesibilityTrait_adjustable() {
    settings.updateOnTouch = true
    CosmosAccessibility.update(view, rating: 5, settings: settings)
    
    XCTAssertEqual(UIAccessibilityTraitAdjustable, view.accessibilityTraits)
  }
  
  func testAccesibilityValue_full() {
    settings.fillMode = .Full

    CosmosAccessibility.update(view, rating: 5, settings: settings)
    XCTAssertEqual("5", view.accessibilityValue)
    
    CosmosAccessibility.update(view, rating: 4.5, settings: settings)
    XCTAssertEqual("5", view.accessibilityValue)
    
    CosmosAccessibility.update(view, rating: 4.2, settings: settings)
    XCTAssertEqual("4", view.accessibilityValue)
    
    CosmosAccessibility.update(view, rating: 6, settings: settings)
    XCTAssertEqual("5", view.accessibilityValue)
  }
  
  func testAccesibilityValue_half() {
    settings.fillMode = .Half

    CosmosAccessibility.update(view, rating: 5, settings: settings)
    XCTAssertEqual("5", view.accessibilityValue)
    
    CosmosAccessibility.update(view, rating: 4.6, settings: settings)
    XCTAssertEqual("4.5", view.accessibilityValue)
    
    CosmosAccessibility.update(view, rating: 4.2, settings: settings)
    XCTAssertEqual("4", view.accessibilityValue)
  }
  
  func testAccesibilityValue_precise() {
    settings.fillMode = .Precise
    
    CosmosAccessibility.update(view, rating: 5, settings: settings)
    XCTAssertEqual("5", view.accessibilityValue)
    
    CosmosAccessibility.update(view, rating: 4.632, settings: settings)
    XCTAssertEqual("4.6", view.accessibilityValue)
    
    CosmosAccessibility.update(view, rating: 4.212, settings: settings)
    XCTAssertEqual("4.2", view.accessibilityValue)
  }
  
  // MARK: - Increment
  
  func testIncrement_full() {
    settings.fillMode = .Full
    
    var result = CosmosAccessibility.accessibilityIncrement(4.7, settings: settings)
    
    // ---

    result = CosmosAccessibility.accessibilityIncrement(4.1, settings: settings)
    XCTAssertEqual("0.9", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityIncrement(4, settings: settings)
    XCTAssertEqual("1.0", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityIncrement(5, settings: settings)
    XCTAssertEqual("0.0", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityIncrement(5.1, settings: settings)
    XCTAssertEqual("0.0", "\(result)")
  }
  
  func testIncrement_half() {
    settings.fillMode = .Half
    
    var result = CosmosAccessibility.accessibilityIncrement(4.2, settings: settings)
    XCTAssertEqual("0.3", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityIncrement(4.5, settings: settings)
    XCTAssertEqual("0.5", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityIncrement(2, settings: settings)
    XCTAssertEqual("0.5", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityIncrement(4.8, settings: settings)
    XCTAssertEqual("0.2", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityIncrement(5, settings: settings)
    XCTAssertEqual("0.0", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityIncrement(5.7, settings: settings)
    XCTAssertEqual("0.0", "\(result)")
  }

  func testIncrement_precise() {
    settings.fillMode = .Precise

    var result = CosmosAccessibility.accessibilityIncrement(4.2, settings: settings)
    XCTAssertEqual("0.3", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityIncrement(4.5, settings: settings)
    XCTAssertEqual("0.5", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityIncrement(2, settings: settings)
    XCTAssertEqual("0.5", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityIncrement(4.8, settings: settings)
    XCTAssertEqual("0.2", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityIncrement(5, settings: settings)
    XCTAssertEqual("0.0", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityIncrement(5.7, settings: settings)
    XCTAssertEqual("0.0", "\(result)")
  }
  
  // MARK: - Decrement
  
  func testDecrement_full() {
    settings.fillMode = .Full
    settings.minTouchRating = 1
    
    var result = CosmosAccessibility.accessibilityDecrement(4.7, settings: settings)
    XCTAssertEqual("0.7", "\(result)")
    
    // ---

    result = CosmosAccessibility.accessibilityDecrement(4.2, settings: settings)
    XCTAssertEqual("0.2", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityDecrement(5, settings: settings)
    XCTAssertEqual("1.0", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityDecrement(1, settings: settings)
    XCTAssertEqual("0.0", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityDecrement(0, settings: settings)
    XCTAssertEqual("0.0", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityDecrement(-1,settings: settings)
    XCTAssertEqual("0.0", "\(result)")
  }
  
  func testDecrement_half() {
    settings.fillMode = .Half
    settings.minTouchRating = 1
    
    var result = CosmosAccessibility.accessibilityDecrement(4.2, settings: settings)
    XCTAssertEqual("0.2", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityDecrement(4.8, settings: settings)
    XCTAssertEqual("0.3", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityDecrement(5, settings: settings)
    XCTAssertEqual("0.5", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityDecrement(1.5, settings: settings)
    XCTAssertEqual("0.5", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityDecrement(1.0, settings: settings)
    XCTAssertEqual("0.0", "\(result)")
    
    // ---
    
    settings.minTouchRating = 0
    result = CosmosAccessibility.accessibilityDecrement(1.0, settings: settings)
    XCTAssertEqual("0.5", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityDecrement(0.0, settings: settings)
    XCTAssertEqual("0.0", "\(result)")
  }
  
  func testDecrement_precise() {
    settings.fillMode = .Precise
    settings.minTouchRating = 1
    
    var result = CosmosAccessibility.accessibilityDecrement(4.2, settings: settings)
    XCTAssertEqual("0.2", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityDecrement(4.8, settings: settings)
    XCTAssertEqual("0.3", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityDecrement(5, settings: settings)
    XCTAssertEqual("0.5", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityDecrement(1.5, settings: settings)
    XCTAssertEqual("0.5", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityDecrement(1.0, settings: settings)
    XCTAssertEqual("0.0", "\(result)")
    
    // ---
    
    settings.minTouchRating = 0
    result = CosmosAccessibility.accessibilityDecrement(1.0, settings: settings)
    XCTAssertEqual("0.5", "\(result)")
    
    // ---
    
    result = CosmosAccessibility.accessibilityDecrement(0.0, settings: settings)
    XCTAssertEqual("0.0", "\(result)")
  }
}
  