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
    XCTAssertEqual(UIAccessibilityTraitNone, view.accessibilityTraits)
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
}
  