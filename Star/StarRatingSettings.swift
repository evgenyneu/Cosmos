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
  
  /// Size of the star.
  public var starSize: Double = StarRatingDefaultSettings.starSize
  
  /// Filled star color
  public var colorFilled = StarRatingDefaultSettings.colorFilled
  
  /// Empty star color
  public var colorEmpty = StarRatingDefaultSettings.colorEmpty
  
  /// Border color of an empty star.
  public var borderColorEmpty = StarRatingDefaultSettings.borderColorEmpty
  
  /// Width of the border for the empty star.
  public var borderWidthEmpty: Double = StarRatingDefaultSettings.borderWidthEmpty
  
  /// Font for the text
  public var textFont = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
  
  /// Color of the text
  public var textColor = StarRatingDefaultSettings.textColor
  
  
  /// Distance between the text and the star
  public var textMargin: Double = StarRatingDefaultSettings.textMargin
  
  /**
  
  Points for drawing the star. Size is 100 by 100 pixels. Supply your points if you need to draw a different shape.
  
  */
  public var starPoints: [CGPoint] = StarRatingDefaultSettings.starPoints
}
