import XCTest
@testable import Cosmos

class CosmosLayersTests: XCTestCase {
  // MARK: - Position star layers
  
  func testPositionStarLayers() {
    let layerOne = CALayer()
    layerOne.bounds = CGRect(origin: CGPoint(), size: CGSize(width: 20, height: 2))
      
    let layerTwo = CALayer()
    layerTwo.bounds = CGRect(origin: CGPoint(), size: CGSize(width: 20, height: 2))
    
    let layerThree = CALayer()
    layerThree.bounds = CGRect(origin: CGPoint(), size: CGSize(width: 20, height: 2))
    
    let layers = [layerOne, layerTwo, layerThree]
      
    CosmosLayers.positionStarLayers(layers, starMargin: 5)
    
    XCTAssertEqual(0, layerOne.position.x)
    XCTAssertEqual(25, layerTwo.position.x)
    XCTAssertEqual(50, layerThree.position.x)
  }
  
  // MARK: - Create partially filled star
  
  func testCreatePartiallyFilledStar_verifyTextAndStyles() {
    var settings = CosmosSettings()
    settings.starSize = 19
    
    settings.emptyColor = UIColor.purple
    settings.emptyBorderColor = UIColor.blue
    settings.emptyBorderWidth = 1.31
    
    settings.filledColor = UIColor.red
    settings.filledBorderColor = UIColor.cyan
    settings.filledBorderWidth = 1.72

    let result = CosmosLayers.createPartialStar(0.8, settings: settings, isRightToLeft: false)
    
    XCTAssertEqual(2, result.sublayers!.count)
    
    // Check layer
    // ------------------
    
    XCTAssertEqual(19, result.bounds.size.width)
    XCTAssertEqual(19, result.bounds.size.height)
    
    // Check empty container layer
    // ------------------
    
    let emptyContainerLayer = result.sublayers![0] as CALayer
    XCTAssertEqual(19, emptyContainerLayer.bounds.size.width)
    XCTAssertEqual(19, emptyContainerLayer.bounds.size.height)

    // Check empty shape layer
    // ------------------
    
    let emptyShapeLayer = emptyContainerLayer.sublayers![0] as! CAShapeLayer
    XCTAssertEqual(UIColor.purple, UIColor(cgColor: emptyShapeLayer.fillColor!))
    XCTAssertEqual(UIColor.blue, UIColor(cgColor: emptyShapeLayer.strokeColor!))
    XCTAssertEqual(1.31, emptyShapeLayer.lineWidth)
    
    // Check filled container layer
    // ------------------
    
    let filledContainerLayer = result.sublayers![1] as CALayer
    XCTAssertEqual(19 * 0.8, filledContainerLayer.bounds.size.width)
    XCTAssertEqual(19, filledContainerLayer.bounds.size.height)
    
    // Check filled shape layer color
    // ------------------
    
    let filledShapeLayer = filledContainerLayer.sublayers![0] as! CAShapeLayer
    XCTAssertEqual(UIColor.red, UIColor(cgColor: filledShapeLayer.fillColor!))
    XCTAssertEqual(UIColor.cyan, UIColor(cgColor: filledShapeLayer.strokeColor!))
    XCTAssertEqual(1.72, filledShapeLayer.lineWidth)
  }
  
  // MARK: - Create composite star layer
  
  func testCreateCompositeStarLayer_fullStar() {
    var settings = CosmosSettings()
    settings.starSize = 12
    settings.filledColor = UIColor.yellow
    settings.filledBorderColor = UIColor.green
    settings.emptyColor = UIColor.red
    settings.emptyBorderColor = UIColor.gray

    
    let result = CosmosLayers.createCompositeStarLayer(1, settings: settings, isRightToLeft: false) as CALayer
  
    XCTAssertEqual(1, result.sublayers!.count)

    // Check filled container layer
    // ------------------
    
    XCTAssertEqual(12, result.bounds.size.width)
    XCTAssertEqual(12, result.bounds.size.height)
    
    // Check filled shape layer color
    // ------------------
    
    let filledShapeLayer = result.sublayers![0] as! CAShapeLayer
    XCTAssertEqual(UIColor.yellow, UIColor(cgColor: filledShapeLayer.fillColor!))
    XCTAssertEqual(UIColor.green, UIColor(cgColor: filledShapeLayer.strokeColor!))
  }

  func testCreateCompositeStarLayer_emptyStar() {
    var settings = CosmosSettings()
    settings.starSize = 61
    settings.emptyColor = UIColor.purple
    settings.emptyBorderColor = UIColor.blue
    settings.emptyBorderWidth = 1.31
    
    let result = CosmosLayers.createCompositeStarLayer(0, settings: settings, isRightToLeft: false) as CALayer
    
    XCTAssertEqual(1, result.sublayers!.count)
    
    // Check empty container layer
    // ------------------
    
    XCTAssertEqual(61, result.bounds.size.width)
    XCTAssertEqual(61, result.bounds.size.height)
    
    // Check empty shape layer color
    // ------------------
    
    let emptyShapeLayer = result.sublayers![0] as! CAShapeLayer
    XCTAssertEqual(UIColor.purple, UIColor(cgColor: emptyShapeLayer.fillColor!))
    XCTAssertEqual(UIColor.blue, UIColor(cgColor: emptyShapeLayer.strokeColor!))
    XCTAssertEqual(1.31, emptyShapeLayer.lineWidth)
  }

  func testCreateCompositeStarLayer_partiallyFilled() {
    var settings = CosmosSettings()
    settings.starSize = 14
    
    settings.emptyColor = UIColor.purple
    settings.emptyBorderColor = UIColor.blue
    settings.emptyBorderWidth = 1.31
    
    settings.filledColor = UIColor.yellow
    settings.filledBorderColor = UIColor.magenta
    settings.filledBorderWidth = 0.41

    let result = CosmosLayers.createCompositeStarLayer(0.2, settings: settings, isRightToLeft: false)
    
    XCTAssertEqual(2, result.sublayers!.count)
    
    // Check layer
    // ------------------
    
    XCTAssertEqual(14, result.bounds.size.width)
    XCTAssertEqual(14, result.bounds.size.height)
    
    // Check empty container layer
    // ------------------
    
    let emptyContainerLayer = result.sublayers![0] as CALayer
    XCTAssertEqual(14, emptyContainerLayer.bounds.size.width)
    XCTAssertEqual(14, emptyContainerLayer.bounds.size.height)
    
    // Check empty shape layer
    // ------------------
    
    let emptyShapeLayer = emptyContainerLayer.sublayers![0] as! CAShapeLayer
    XCTAssertEqual(UIColor.purple, UIColor(cgColor: emptyShapeLayer.fillColor!))
    XCTAssertEqual(UIColor.blue, UIColor(cgColor: emptyShapeLayer.strokeColor!))
    XCTAssertEqual(1.31, emptyShapeLayer.lineWidth)
    
    // Check filled container layer
    // ------------------
    
    let filledContainerLayer = result.sublayers![1] as CALayer
    XCTAssertEqual(14 * 0.2, filledContainerLayer.bounds.size.width)
    XCTAssertEqual(14, filledContainerLayer.bounds.size.height)
    
    // Check filled shape layer color
    // ------------------
    
    let filledShapeLayer = filledContainerLayer.sublayers![0] as! CAShapeLayer
    XCTAssertEqual(UIColor.yellow, UIColor(cgColor: filledShapeLayer.fillColor!))
    XCTAssertEqual(UIColor.magenta, UIColor(cgColor: filledShapeLayer.strokeColor!))
    XCTAssertEqual(0.41, filledShapeLayer.lineWidth)

  }

  // MARK: - Create star layers 
  
  func testCreateStarLayers() {
    var settings = CosmosSettings()
    settings.fillMode = .precise
    settings.starSize = 17
    settings.starMargin = 5
    settings.totalStars = 100 // Crazy, huh? But still way less than 100,000,000,000 to 400,000,000,000 stars in our Milky Way galaxy. 🌌
    
    let result = CosmosLayers.createStarLayers(3.7, settings: settings, isRightToLeft: false)
    
    XCTAssertEqual(100, result.count)
    XCTAssertEqual(17, result.last!.bounds.width)
    
    // 100 * 10 (width of the stars)
    //   + 99 * 5 (margin between stars)
    XCTAssertEqual(Double(99 * 17 + 99 * 5), Double(result.last!.position.x))
    
    // Order is left-to-right, the fourth star is partial - contains two layers
    XCTAssertEqual(2, result[3].sublayers!.count)
  }
  
  func testCreateStarLayers_rightToLeft() {
    var settings = CosmosSettings()
    settings.fillMode = .precise
    settings.starSize = 17
    settings.starMargin = 5
    settings.totalStars = 100
    
    let result = CosmosLayers.createStarLayers(3.7, settings: settings, isRightToLeft: true)
    
    XCTAssertEqual(100, result.count)
    XCTAssertEqual(17, result.last!.bounds.width)
    
    // 100 * 10 (width of the stars)
    //   + 99 * 5 (margin between stars)
    XCTAssertEqual(Double(99 * 17 + 99 * 5), Double(result.last!.position.x))
    
    // Order is left-to-right, the fourth star from the end is partial - contains two layers
    XCTAssertEqual(2, result[96].sublayers!.count)
  }
  
  // MARK: - Create star layers with images
  
  func testCreateStarLayers_filledImage() {
    var settings = CosmosSettings()
    settings.fillMode = .precise
    settings.starSize = 17
    settings.starMargin = 5
    settings.filledImage = CosmosTest.uiImageFromFile("35px.jpg")
    
    let result = CosmosLayers.createStarLayers(3.7, settings: settings, isRightToLeft: false)

    
    // First star
    // --------

    // The first star is filled - contains one layer with star from an image
    var starLayer = result[0]
    XCTAssertEqual(1, starLayer.sublayers?.count)
    
    // The image layer should contain one sublayer that shows the image
    var starImage = starLayer.sublayers?[0]
    let image = starImage!.contents as! CGImage
    
    // Check the image is shown
    XCTAssertEqual(35, image.width)
    
    
    // Last star
    // --------
    
    // The last star is empty - contains one layer with drawn star
    starLayer = result[4]
    XCTAssertEqual(1, starLayer.sublayers?.count)
    
    // The image layer should contain one sublayer that draws the image
    starImage = starLayer.sublayers?[0]
    XCTAssertNil(starImage!.contents)
    XCTAssert(starImage is CAShapeLayer)
  }
  
  func testCreateStarLayers_emptyImage() {
    var settings = CosmosSettings()
    settings.fillMode = .precise
    settings.starSize = 17
    settings.starMargin = 5
    settings.emptyImage = CosmosTest.uiImageFromFile("67px.png")
    
    let result = CosmosLayers.createStarLayers(3.7, settings: settings, isRightToLeft: false)
    
    
    // First star
    // --------
    
    // The first star is filled - contains one layer that draws the image
    var starLayer = result[0]
    XCTAssertEqual(1, starLayer.sublayers?.count)
    
    // The image layer should contain one sublayer that shows the image
    var starImage = starLayer.sublayers?[0]
    XCTAssertNil(starImage!.contents)
    XCTAssert(starImage is CAShapeLayer)
    
    
    // Last star
    // --------
    
    // The last star is empty - contains one layer
    starLayer = result[4]
    XCTAssertEqual(1, starLayer.sublayers?.count)
  
    // The image layer should contain one sublayer that shows the image
    starImage = starLayer.sublayers?[0]
    let image = starImage!.contents as! CGImage
    
    // Check the image is shown
    XCTAssertEqual(67, image.width)
  }
  
  func testCreateStarLayers_drawStarIfImageIsNotSpecified() {
    var settings = CosmosSettings()
    settings.fillMode = .precise
    settings.starSize = 17
    settings.starMargin = 5
    
    let result = CosmosLayers.createStarLayers(3.7, settings: settings, isRightToLeft: false)
    
    
    // Filled star
    // --------

    // The first star is filled - contains one layer
    let firstStar = result[0]
    XCTAssertEqual(1, firstStar.sublayers?.count)
    
    // The image layer should contain one sublayer that draws the image
    let firstStarImage = firstStar.sublayers?[0]
    XCTAssertNil(firstStarImage!.contents)
    XCTAssert(firstStarImage is CAShapeLayer)
    
    
    // Empty star
    // --------
    
    // The last star is empty - contains one layer
    let lastStar = result[4]
    XCTAssertEqual(1, lastStar.sublayers?.count)
    
    // The image layer should contain one sublayer that draws the image
    let lastStarImage = lastStar.sublayers?[0]
    XCTAssertNil(lastStarImage!.contents)
    XCTAssert(lastStarImage is CAShapeLayer)
  }
}
