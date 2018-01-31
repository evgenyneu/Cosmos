import XCTest
@testable import Cosmos

class CosmosSettingsTests: XCTestCase {
  var obj: CosmosView!
  
  func testInitializeWithSettings() {
    var settings = CosmosSettings()
    settings.starSize = 142
    obj = CosmosView(settings: settings)
    
    XCTAssertEqual(obj.settings.starSize, 142)
  }
}

