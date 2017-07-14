import UIKit

/**

Settings that define the appearance of the star rating views.

*/
public struct CosmosSettings {
  init() {}
  
  // MARK: - Star settings
  // -----------------------------
    
  /// Border color of an empty star.
  public var emptyBorderColor = CosmosDefaultSettings.emptyBorderColor
  
  /// Width of the border for empty star.
  public var emptyBorderWidth: Double = CosmosDefaultSettings.emptyBorderWidth
  
  /// Border color of a filled star.
  public var filledBorderColor = CosmosDefaultSettings.filledBorderColor
  
  /// Width of the border for a filled star.
  public var filledBorderWidth: Double = CosmosDefaultSettings.filledBorderWidth

  /// Background color of an empty star.
  public var emptyColor = CosmosDefaultSettings.emptyColor
  
  /// Background color of a filled star.
  public var filledColor = CosmosDefaultSettings.filledColor
  
  /**
  
  Defines how the star is filled when the rating value is not a whole integer. It can either show full stars, half stars or stars partially filled according to the rating value.
  
  */
  public var fillMode = CosmosDefaultSettings.fillMode
  
  /// Distance between stars.
  public var starMargin: Double = CosmosDefaultSettings.starMargin
  
  /**
  
  Array of points for drawing the star with size of 100 by 100 pixels. Supply your points if you need to draw a different shape.
  
  */
  public var starPoints: [CGPoint] = CosmosDefaultSettings.starPoints
  
  /// Size of a single star.
  public var starSize: Double = CosmosDefaultSettings.starSize
  
  /// The maximum number of stars to be shown.
  public var totalStars = CosmosDefaultSettings.totalStars
  
  // MARK: - Star image settings
  // -----------------------------
  
  /**
  
  Image used for the filled portion of the star. By default the star is drawn from the array of points unless an image is supplied.
  
  */
  public var filledImage: UIImage? = nil
  
  /**
   
   Image used for the empty portion of the star. By default the star is drawn from the array of points unless an image is supplied.
   
   */
  public var emptyImage: UIImage? = nil
  
  // MARK: - Text settings
  // -----------------------------
  
  /// Color of the text.
  public var textColor = CosmosDefaultSettings.textColor
  
  /// Font for the text.
  public var textFont = CosmosDefaultSettings.textFont
  
  /// Distance between the text and the stars.
  public var textMargin: Double = CosmosDefaultSettings.textMargin
  
  
  // MARK: - Touch settings
  // -----------------------------
  
  /// The lowest rating that user can set by touching the stars.
  public var minTouchRating: Double = CosmosDefaultSettings.minTouchRating
  
  /// When `true` the star fill level is updated when user touches the cosmos view. When `false` the Cosmos view only shows the rating and does not act as the input control.
  public var updateOnTouch = CosmosDefaultSettings.updateOnTouch
}


