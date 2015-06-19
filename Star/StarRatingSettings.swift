import UIKit

/**

Settings that define the appearance of the star rating views.

*/
public struct StarRatingSettings {
  init() {}
  
  /// Raiting value that is shown in the storyboard by default.
  public var rating: Double = StarRatingDefaultSettings.rating
  
  /// The maximum number of start to be shown.
  public var totalStars = StarRatingDefaultSettings.totalStars
  
  /**

  Defines how the star should appear to be filled when the rating value is not an integer value.

  */
  public var starFillMode = StarFillMode.Half
  
  /// Distance between stars expressed. The value is automatically calculated based on marginBetweenStarsRelativeToFontSize property and the font size.
  var marginBetweenStars:CGFloat = 0
  
  /**

  Distance between stars expressed as a fraction of the font size. For example, if the font size is 12 and the value is 0.25 the distance will be 4.

  */
  public var marginBetweenStarsRelativeToFontSize = 0.1
  
  /// The font used to draw the star character
  public var starFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
  
  /// Character used to show a filled star
  public var starCharacterFilled = "★"
  
  /// Character used to show an empty star
  public var starCharacterEmpty = "☆"
  
  /// Filled star color
  public var starColorFilled = UIColor(red: 1, green: 149/255, blue: 0, alpha: 1)
  
  /// Empty star color
  public var starColorEmpty = UIColor(red: 1, green: 149/255, blue: 0, alpha: 1)
  
  /// Font for the text
  public var textFont = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
  
  /// Color of the text
  public var textColor = UIColor.grayColor()
  
  /// Distance between the text and the star. The value is automatically calculated based on marginBetweenStarsAndTextRelativeToFontSize property and the font size.
  var marginBetweenStarsAndText: CGFloat = 0
  
  /**

  Distance between the text and the star expressed as a fraction of the font size. For example, if the font size is 12 and the value is 0.25 the margin will be 4.

  */
  public var marginBetweenStarsAndTextRelativeToFontSize = 0.25
  
  /**

  When true the fill level is corrected to appear more gradual for default characters ★ and ☆. Applied only for precise star fill level.

  */
  public var correctFillLevelForPreciseMode = true
}
