import Foundation

/**

Returns the word "Rating" in user's language. It is used for voice-over  in accessibility mode.

*/
struct CosmosLocalizedRating {
  static var defaultText = "Rating"
  
  static var localizedRatings = [
    "ar": "تصنيف",
    "bg": "Рейтинг",
    "cy": "Sgôr",
    "da": "Rating",
    "de": "Bewertung",
    "el": "Βαθμολογία",
    "en": defaultText,
    "es": "Valorar",
    "et": "Reiting",
    "fi": "Luokitus",
    "fr": "De note",
    "he": "דירוג",
    "hi": "रेटिंग",
    "hr": "Ocjena",
    "hu": "Értékelés",
    "id": "Peringkat",
    "it": "Voto",
    "ko": "등급",
    "lt": "Reitingas",
    "lv": "Vērtējums",
    "nl": "Rating",
    "no": "Vurdering",
    "pl": "Ocena",
    "pt": "Classificação",
    "ro": "Evaluare",
    "ru": "Рейтинг",
    "sk": "Hodnotenie",
    "sl": "Ocena",
    "sr": "Рејтинг",
    "sw": "Rating",
    "th": "การจัดอันดับ",
    "tr": "Oy verin",
    "cs": "Hodnocení",
    "uk": "Рейтинг",
    "vi": "Đánh giá",
    "zh": "评分"
  ]
  
  static var ratingTranslation: String {
    let languages = preferredLanguages(Locale.preferredLanguages)
    return ratingInPreferredLanguage(languages)
  }
  
  /**

  Returns the word "Rating" in user's language.
  
  - parameter language: ISO 639-1 language code. Example: 'en'.
  
  */
  static func translation(_ language: String) -> String? {
    return localizedRatings[language]
  }
  
  /**
  
  Returns translation using the preferred language.
  
  - parameter preferredLanguages: Array of preferred language codes (ISO 639-1). The first element is most preferred.
  
  - parameter localizedText: Dictionary with translations for the languages. The keys are ISO 639-1 language codes and values are the text.
  
  - parameter fallbackTranslation: The translation text used if no translation found for the preferred languages.
  
  - returns: Translation for the preferred language.
  
  */
  static func translationInPreferredLanguage(_ preferredLanguages: [String],
    localizedText: [String: String],
    fallbackTranslation: String) -> String {
    
    for language in preferredLanguages {
      if let translatedText = translation(language) {
        return translatedText
      }
    }
      
    return fallbackTranslation
  }
  
  static func ratingInPreferredLanguage(_ preferredLanguages: [String]) -> String {
    return translationInPreferredLanguage(preferredLanguages,
      localizedText: localizedRatings,
      fallbackTranslation: defaultText)
  }
  
  static func preferredLanguages(_ preferredLocales: [String]) -> [String] {
    return preferredLocales.map { element in
      
      let dashSeparated = element.components(separatedBy: "-")
      if dashSeparated.count > 1 { return dashSeparated[0] }
      
      let underscoreSeparated = element.components(separatedBy: "_")
      if underscoreSeparated.count > 1 { return underscoreSeparated[0] }
      
      return element
    }
  }
}
