import UIKit

class CosmosTest {
  static func nsDataFromFile(_ name: String) -> Data {
    let url = Bundle(for: self).url(forResource: name, withExtension: nil)!
    return try! Data(contentsOf: url)
  }
  
  static func uiImageFromFile(_ name: String) -> UIImage {
    return UIImage(data: nsDataFromFile(name))!
  }
}
