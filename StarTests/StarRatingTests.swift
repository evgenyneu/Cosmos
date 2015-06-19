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
  
  // MARK: - Create partially filled star
  
  func testCreatePartiallyFilledStar_verifyTextAndStyles() {
    var settings = StarRatingSettings()
    settings.textEmpty = "empty"
    settings.textFilled = "filled"
    settings.starFont = UIFont.systemFontOfSize(19)
    settings.colorEmpty = UIColor.purpleColor()
    settings.colorFilled = UIColor.redColor()

    let result = StarRating.createPartialStar(0.8, settings: settings)
    
    XCTAssertEqual(2, result.sublayers!.count)
    
    // Check empty star size
    // ------------------
    
    let emptyStarLayer = result.sublayers![0] as! CATextLayer
    XCTAssertEqual("empty", emptyStarLayer.string as! String)
    XCTAssertEqual(19, emptyStarLayer.fontSize)
    XCTAssertEqual(UIColor.purpleColor(), UIColor(CGColor: emptyStarLayer.foregroundColor!))
    
    // Check filled star size
    // ------------------
    
    let filledStarLayer = result.sublayers![1] as! CATextLayer
    XCTAssertEqual("filled", filledStarLayer.string as! String)
    XCTAssertEqual(19, filledStarLayer.fontSize)
    XCTAssertEqual(UIColor.redColor(), UIColor(CGColor: filledStarLayer.foregroundColor!))
  }
  
  func testCreatePartiallyFilledStar_verifySize() {
    var settings = StarRatingSettings()
    settings.textEmpty = "☆"
    settings.textFilled = "★"
    settings.starFont = UIFont.systemFontOfSize(19)
    
    let result = StarRating.createPartialStar(0.8, settings: settings)
    
    let sizeAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(19)]
    
    // Check empty star size
    // ------------------
    
    let emptyStarLayer = result.sublayers![0] as! CATextLayer
    let emptyFontSize = NSString(string: "☆").sizeWithAttributes(sizeAttributes)
    XCTAssertEqual(19, emptyStarLayer.bounds.width)
    XCTAssertEqual(emptyFontSize.height, emptyStarLayer.bounds.height)
    
    // Check filled star size
    // ------------------
    
    let filledStarLayer = result.sublayers![1] as! CATextLayer
    let filledFontSize = NSString(string: "★").sizeWithAttributes(sizeAttributes)
    XCTAssertEqual(19 * 0.8, filledStarLayer.bounds.width)
    XCTAssertEqual(filledFontSize.height, filledStarLayer.bounds.height)
    
    // Check parent layer size
    // ------------------
    
    XCTAssertEqual(19, result.bounds.width)
    XCTAssertEqual(filledFontSize.height, result.bounds.height)
  }
  
  // MARK: - Create composite star layer
  
  func testCreateCompositeStarLayer_fullStar() {
    var settings = StarRatingSettings()
    settings.textFilled = "full"
    settings.starFont = UIFont.systemFontOfSize(19)
    settings.colorFilled = UIColor.redColor()
    
    let result = StarRating.createCompositeStarLayer(1, settings: settings) as! CATextLayer
    
    let sizeAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(19)]
    let fontSize = NSString(string: "full").sizeWithAttributes(sizeAttributes)
    
    XCTAssert(result.sublayers == nil)
    XCTAssertEqual("full", result.string as! String)
    XCTAssertEqual(19, result.fontSize)
    XCTAssertEqual(UIColor.redColor(), UIColor(CGColor: result.foregroundColor!))
    XCTAssertEqual(fontSize.width, result.bounds.width)
    XCTAssertEqual(fontSize.height, result.bounds.height)
  }
  
  func testCreateCompositeStarLayer_emptyStar() {
    var settings = StarRatingSettings()
    settings.textEmpty = "empty"
    settings.starFont = UIFont.systemFontOfSize(19)
    settings.colorEmpty = UIColor.blueColor()
    
    let result = StarRating.createCompositeStarLayer(0, settings: settings) as! CATextLayer
    
    XCTAssert(result.sublayers == nil)
    
    let sizeAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(19)]
    let fontSize = NSString(string: "empty").sizeWithAttributes(sizeAttributes)
    
    XCTAssertEqual("empty", result.string as! String)
    XCTAssertEqual(19, result.fontSize)
    XCTAssertEqual(UIColor.blueColor(), UIColor(CGColor: result.foregroundColor!))
    XCTAssertEqual(fontSize.width, result.bounds.width)
    XCTAssertEqual(fontSize.height, result.bounds.height)
  }
  
  func testCreateCompositeStarLayer_partiallyFilled() {
    var settings = StarRatingSettings()
    settings.textEmpty = "empty"
    settings.textFilled = "filled"

    settings.starFont = UIFont.systemFontOfSize(19)
    settings.colorEmpty = UIColor.blueColor()
    settings.colorFilled = UIColor.greenColor()
    
    let result = StarRating.createCompositeStarLayer(0.2, settings: settings)
    
    XCTAssertEqual(2, result.sublayers!.count)
    
    // Check empty star size
    // ------------------
    
    let emptyStarLayer = result.sublayers![0] as! CATextLayer
    XCTAssertEqual("empty", emptyStarLayer.string as! String)
    XCTAssertEqual(19, emptyStarLayer.fontSize)
    XCTAssertEqual(UIColor.blueColor(), UIColor(CGColor: emptyStarLayer.foregroundColor!))
    
    // Check filled star size
    // ------------------
    
    let filledStarLayer = result.sublayers![1] as! CATextLayer
    XCTAssertEqual("filled", filledStarLayer.string as! String)
    XCTAssertEqual(19, filledStarLayer.fontSize)
    XCTAssertEqual(UIColor.greenColor(), UIColor(CGColor: filledStarLayer.foregroundColor!))
  }
  
  // MARK: - Create star layers 
  
  func testCreateStarLayers() {
    var settings = StarRatingSettings()
    settings.textEmpty = "☆"
    settings.textFilled = "★"
    settings.starFont = UIFont.systemFontOfSize(10)
    settings.marginBetweenStars = 5
    settings.totalStars = 100 // Crazy, huh? But still way less than 100,000,000,000 to 400,000,000,000 stars in our Milky Way galaxy. 🌌
    
    let result = StarRating.createStarLayers(3.7, settings: settings)
    
    XCTAssertEqual(100, result.count)
    XCTAssertEqual(10, result.last!.bounds.width)
    
    // 100 * 10 (width of the stars)
    //   + 99 * 5 (margin between stars)
    XCTAssertEqual(Double(99 * 10 + 99 * 5), Double(result.last!.position.x))
  }
  
}