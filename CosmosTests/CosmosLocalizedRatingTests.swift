import XCTest
@testable import Cosmos

class CosmosLocalizedRatingTests: XCTestCase {
  func testTranslation() {
    XCTAssertEqual("Rating", CosmosLocalizedRating.translation("en")!)
    XCTAssertEqual("Valorar", CosmosLocalizedRating.translation("es")!)
    XCTAssert(CosmosLocalizedRating.translation("zz") == nil)
  }
  
  // MARK: - Translation in preferred language
  
  func testTranslationInPreferredLanguage() {
    let result = CosmosLocalizedRating.translationInPreferredLanguage(
      ["en", "zz", "ru"],
      localizedText: CosmosLocalizedRating.localizedRatings,
      fallbackTranslation: "Test fallback")
    
    XCTAssertEqual("Rating", result)
  }
  
  func testTranslationInPreferredLanguageReverse() {
    let result = CosmosLocalizedRating.translationInPreferredLanguage(
      ["ru", "zz", "en"],
      localizedText: CosmosLocalizedRating.localizedRatings,
      fallbackTranslation: "Test fallback")
    
    XCTAssertEqual("Рейтинг", result)
  }
  
  func testTranslationInPreferredLanguage_notFound() {
    let result = CosmosLocalizedRating.translationInPreferredLanguage(
      ["uu", "zz"],
      localizedText: CosmosLocalizedRating.localizedRatings,
      fallbackTranslation: "Test fallback")
    
    XCTAssertEqual("Test fallback", result)
  }
  
  // MARK: - Rating in preferred language
  
  func testRatingInPreferredLanguage() {
    let result = CosmosLocalizedRating.ratingInPreferredLanguage(["en", "zz", "ru"])
    XCTAssertEqual("Rating", result)
  }
  
  func testRatingInPreferredLanguage_reversed() {
    let result = CosmosLocalizedRating.ratingInPreferredLanguage(["it", "zz", "en"])
    XCTAssertEqual("Voto", result)
  }
  
  func testRatingInPreferredLanguage_languageNotFound() {
    let result = CosmosLocalizedRating.ratingInPreferredLanguage(["zz"])
    XCTAssertEqual("Rating", result)
  }
  
  func testPreferredLanguages() {
    let result = CosmosLocalizedRating.preferredLanguages(["en-US", "en", "ru-RU", "fr_CA"])
    
    XCTAssertEqual(["en", "en", "ru", "fr"], result)
  }
}