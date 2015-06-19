import UIKit

/**

Settings that define the appearance of the star rating views.

*/
public struct StarRatingSettings {
  init() {}
  
  /// Raiting value that is shown in the storyboard by default.
  public var rating: Double = StarRatingDefaultSettings.rating
  
  /// Text that is shown in the storyboard.
  public var text: String?
  
  /// The maximum number of start to be shown.
  public var totalStars = StarRatingDefaultSettings.totalStars
  
  /**

  Defines how the star should appear to be filled when the rating value is not an integer value.

  */
  public var fillMode = StarRatingDefaultSettings.fillMode
  
  /// Distance between stars expressed. The value is automatically calculated based on marginPercent property and the font size.
  var marginBetweenStars:CGFloat = 0
  
  /**

  Distance between stars expressed as a percentage of the font size. For example, if the font size is 12 and the value is 25 the distance will be 3.

  */
  public var marginPercent: Double = StarRatingDefaultSettings.marginPercent
  
  /// The font used to draw the star character
  public var starFont = StarRatingDefaultSettings.starFont
  
  /// Character used to show a filled star
  public var textFilled = StarRatingDefaultSettings.textFilled
  
  /// Character used to show an empty star
  public var textEmpty = StarRatingDefaultSettings.textEmpty
  
  /// Filled star color
  public var colorFilled = StarRatingDefaultSettings.colorFilled
  
  /// Empty star color
  public var colorEmpty = StarRatingDefaultSettings.colorEmpty
  
  /// Font for the text
  public var textFont = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
  
  /// Color of the text
  public var textColor = StarRatingDefaultSettings.textColor
  
  /// Distance between the text and the star. The value is automatically calculated based on textMarginPercent property and the font size.
  var marginBetweenStarsAndText: CGFloat = 0
  
  /**

  Distance between the text and the star expressed as a percentage of the font size. For example, if the font size is 12 and the value is 25 the margin will be 3.

  */
  public var textMarginPercent: Double = StarRatingDefaultSettings.textMarginPercent
  
  /**
  
  Value between 0 and 100 that is used to correct the star fill value when precise fill mode is used. Default value is 40. When 0 - no correction is applied. Correction is done to compensate for the fact that star characters do not fill the full width of they lay rectangle. Default value is 40.
  
  Graph: https://www.desmos.com/calculator/gk0fpc7tun
  
  */
  public var fillCorrection: Double = StarRatingDefaultSettings.fillCorrection
}
