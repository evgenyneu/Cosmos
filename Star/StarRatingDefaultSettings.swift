
/**

Defaults setting values.

*/
struct StarRatingDefaultSettings {
  init() {}
  
  /// Raiting value that is shown in the storyboard by default.
  static let rating: Double = 3.5
  
  /// The total number of start to be shown.
  static let totalStars = 5
  
  /**
  
  Defines how the star should appear to be filled when the rating value is not an integer value.
  
  */
  static let fillMode = StarFillMode.Half
  
  /// Distance between stars expressed. The value is automatically calculated based on marginBetweenStarsRelativeToFontSize property and the font size.
  static let marginBetweenStars:CGFloat = 0
  
  /**
  
  Distance between stars expressed as a percentage of the font size. For example, if the font size is 12 and the value is 25 the distance will be 3.
  
  */
  static let marginPercent: Double = 10
  
  /// The font used to draw the star character
  static let starFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
  
  /// Returns the size of the default star font
  static var starSize: CGFloat {
    get {
      return starFont.pointSize
    }
  }
  
  /// Character used to show a filled star
  static let textFilled = "★"
  
  /// Character used to show an empty star
  static let textEmpty = "☆"
  
  /// Filled star color
  static let colorFilled = UIColor(red: 1, green: 149/255, blue: 0, alpha: 1)
  
  /// Empty star color
  static let colorEmpty = UIColor(red: 1, green: 149/255, blue: 0, alpha: 1)
  
  /// Font for the text
  static let textFont = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
  
  /// Color of the text
  static let textColor = UIColor.grayColor()
  
  /// Distance between the text and the star. The value is automatically calculated based on marginBetweenStarsAndTextRelativeToFontSize property and the font size.
  static let marginBetweenStarsAndText: CGFloat = 0
  
  /**
  
  Distance between the text and the star expressed as a percentage of the font size. For example, if the font size is 12 and the value is 25 the margin will be 3.
  
  */
  static let textMarginPercent: Double = 25
  
  /**
  
  Value between 0 and 100 that is used to correct the star fill value when precise fill mode is used. Default value is 40. When 0 - no correction is applied. Correction is done to compensate for the fact that star characters do not fill the full width of they lay rectangle. Default value is 40.
  
  Graph: https://www.desmos.com/calculator/gk0fpc7tun
  
  */
  static let fillCorrection: Double = 40
}
