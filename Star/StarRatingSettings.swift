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
  
  Defines how the star is filled when the rating value is not an integer value. It can either show full stars, half stars or stars partially filled according to the rating value.
  
  */
  public var fillMode = StarRatingDefaultSettings.fillMode
  
  /// Distance between stars.
  public var starMargin: Double = StarRatingDefaultSettings.starMargin
  
  /// The font used to draw the star character
  public var starFont = StarRatingDefaultSettings.starFont
  
  /// Size of the star.
  public var starSize: Double = StarRatingDefaultSettings.starSize
  
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
  
  
  /// Distance between the text and the star
  public var textMargin: Double = StarRatingDefaultSettings.textMargin
  
  /**
  
  Value between 0 and 100 that is used to correct the star fill value when precise fill mode is used. Default value is 40. When 0 - no correction is applied. Correction is done to compensate for the fact that star characters do not fill the full width of they lay rectangle. Default value is 40.
  
  Graph: https://www.desmos.com/calculator/gk0fpc7tun
  
  */
  public var fillCorrection: Double = StarRatingDefaultSettings.fillCorrection
  
  /**
  
  Points for drawing the star. Size is 100 by 100 pixels. Supply your points if you need to draw a different shape.
  
  */
  public var starPoints: [CGPoint] = StarRatingDefaultSettings.starPoints
}
