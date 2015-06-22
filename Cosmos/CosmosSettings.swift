import UIKit

/**

Settings that define the appearance of the star rating views.

*/
public struct CosmosSettings {
  init() {}
  
  // MARK: - Star settings
  // -----------------------------
  
  
  /// Border color of an empty star.
  public var borderColorEmpty = CosmosDefaultSettings.borderColorEmpty
  
  /// Width of the border for the empty star.
  public var borderWidthEmpty: Double = CosmosDefaultSettings.borderWidthEmpty

  /// Background color of an empty star.
  public var colorEmpty = CosmosDefaultSettings.colorEmpty
  
  /// Background color of a filled star.
  public var colorFilled = CosmosDefaultSettings.colorFilled
  
  /**
  
  Defines how the star is filled when the rating value is not a whole integer. It can either show full stars, half stars or stars partially filled according to the rating value.
  
  */
  public var fillMode = CosmosDefaultSettings.fillMode
  
  /// Distance between stars.
  public var starMargin: Double = CosmosDefaultSettings.starMargin
  
  /// Size of a single star.
  public var starSize: Double = CosmosDefaultSettings.starSize
  
  /// The maximum number of stars to be shown.
  public var totalStars = CosmosDefaultSettings.totalStars
  
  
  // MARK: - Text settings
  // -----------------------------
  
  
  /// Font for the text
  public var textFont = CosmosDefaultSettings.textFont
  
  /// Color of the text
  public var textColor = CosmosDefaultSettings.textColor
  
  
  /// Distance between the text and the star
  public var textMargin: Double = CosmosDefaultSettings.textMargin
  
  
  // MARK: - Touch settings
  // -----------------------------
  
  
  /// When true the star fill level is update when user touches the cosmos view.
  public var updateOnTouch = CosmosDefaultSettings.updateOnTouch
  
  /// The lowest rating that user can set by touching the stars.
  public var minTouchRating: Double = CosmosDefaultSettings.minTouchRating
  
  /**
  
  Points for drawing the star. Size is 100 by 100 pixels. Supply your points if you need to draw a different shape.
  
  */
  public var starPoints: [CGPoint] = CosmosDefaultSettings.starPoints
}
