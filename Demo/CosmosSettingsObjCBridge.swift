import UIKit

/**
 
 This is a sample file that can be used in your ObjC project if you want to change Cosmos View settings.
 Extend this file to add other functionality for your app.
 
 How to use
 ----------
 
 1. Import swift code in your ObjC file:
 
 #import "YOUR_PRODUCT_MODULE_NAME-Swift.h"
 
 2. Use Auk in your ObjC code:
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 
 [AukObjCBridge setupWithScrollView: self.scrollView];
 [AukObjCBridge showWithUrl: @"https://bit.ly/auk_image" inScrollView: self.scrollView];
 [AukObjCBridge showWithUrl: @"https://bit.ly/moa_image" inScrollView: self.scrollView];
 }
 */
@objc public class CosmosSettingsObjCBridge: NSObject {
  
  
  /**
   
   Set the star fill mode. A fill mode defines how the star is filled when the rating value is not a whole integer. It can either show full stars, half stars or stars partially filled according to the rating value.
   
   - parameter value: Value of the fill mode.
   
   - parameter inCosmosView: A CosmosView object.
   
  */
  public class func setFillMode(value: StarFillMode, inCosmosView cosmosView: CosmosView) {
    cosmosView.settings.fillMode = value;
  }
  
  /**
   
   Get the star fill mode. A fill mode defines how the star is filled when the rating value is not a whole integer. It can either show full stars, half stars or stars partially filled according to the rating value.
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func getFillMode(_ cosmosView: CosmosView) -> StarFillMode {
    return cosmosView.settings.fillMode;
  }
  
  
  
  /**
   
   When `true` the star fill level is updated when user touches the cosmos view. When `false` the Cosmos view only shows the rating and does not act as the input control.
   
   - parameter value: The value of the setting.
   
   - parameter inCosmosView: A CosmosView object.
   
   */
  public class func setUpdateOnTouch(value: Bool, inCosmosView cosmosView: CosmosView) {
    cosmosView.settings.updateOnTouch = value;
  }
  
  /**
   
   When `true` the star fill level is updated when user touches the cosmos view. When `false` the Cosmos view only shows the rating and does not act as the input control.
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func getUpdateOnTouch(_ cosmosView: CosmosView) -> Bool {
    return cosmosView.settings.updateOnTouch;
  }
  
  
  /**
   
   Set the size of a single star.
   
   - parameter value: The value of the setting.
   
   - parameter inCosmosView: A CosmosView object.
   
   */
  public class func setStarSize(value: Double, inCosmosView cosmosView: CosmosView) {
    cosmosView.settings.starSize = value;
  }
  
  /**
   
   Returns the size of a single star.
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func getStarSize(_ cosmosView: CosmosView) -> Double {
    return cosmosView.settings.starSize;
  }
  
  /**
   
   Set the maximum number of stars to be shown.
   
   - parameter value: The value of the setting.
   
   - parameter inCosmosView: A CosmosView object.
   
   */
  public class func setTotalStars(value: Int, inCosmosView cosmosView: CosmosView) {
    cosmosView.settings.totalStars = value;
  }
  
  /**
   
   Returns the maximum number of stars to be shown.
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func getTotalStars(_ cosmosView: CosmosView) -> Int {
    return cosmosView.settings.totalStars;
  }

  
  
  /**
   
   Set the distance between stars. 
   
   - parameter value: The value of the setting.
   
   - parameter inCosmosView: A CosmosView object.
   
   */
  public class func setStarMargin(value: Double, inCosmosView cosmosView: CosmosView) {
    cosmosView.settings.starMargin = value;
  }
  
  /**
   
   Returns the distance between stars.
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func getStarMargin(_ cosmosView: CosmosView) -> Double {
    return cosmosView.settings.starSize;
  }
  
  
  /**
   
   Set the background color of a filled star.
   
   - parameter value: The value of the setting.
   
   - parameter inCosmosView: A CosmosView object.
   
   */
  public class func setFilledColor(value: UIColor, inCosmosView cosmosView: CosmosView) {
    cosmosView.settings.filledColor = value;
  }
  
  /**
   
   Returns the background color of a filled star.
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func getFilledColor(_ cosmosView: CosmosView) -> UIColor {
    return cosmosView.settings.filledColor;
  }
  
  
  /**
   
   Set the background color of an empty star.
   
   - parameter value: The value of the setting.
   
   - parameter inCosmosView: A CosmosView object.
   
   */
  public class func setEmptyColor(value: UIColor, inCosmosView cosmosView: CosmosView) {
    cosmosView.settings.emptyColor = value;
  }
  
  /**
   
   Returns the background color of an empty star.
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func getEmptyColor(_ cosmosView: CosmosView) -> UIColor {
    return cosmosView.settings.emptyColor;
  }
  
  
  /**
   
   Set the width of the border for a filled star.
   
   - parameter value: The value of the setting.
   
   - parameter inCosmosView: A CosmosView object.
   
   */
  public class func setFilledBorderWidth(value: Double, inCosmosView cosmosView: CosmosView) {
    cosmosView.settings.filledBorderWidth = value;
  }
  
  /**
   
   Returns the width of the border for a filled star.
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func getFilledBorderWidth(_ cosmosView: CosmosView) -> Double {
    return cosmosView.settings.filledBorderWidth;
  }
  
  
  /**
   
   Set the border color of a filled star.
   
   - parameter value: The value of the setting.
   
   - parameter inCosmosView: A CosmosView object.
   
   */
  public class func setFilledBorderColor(value: UIColor, inCosmosView cosmosView: CosmosView) {
    cosmosView.settings.filledBorderColor = value;
  }
  
  /**
   
   Returns the border color of a filled star.
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func getFilledBorderColor(_ cosmosView: CosmosView) -> UIColor {
    return cosmosView.settings.filledBorderColor;
  }
  
  
  /**
   
   Set the width of the border for an empty star.
   
   - parameter value: The value of the setting.
   
   - parameter inCosmosView: A CosmosView object.
   
   */
  public class func setEmptyBorderWidth(value: Double, inCosmosView cosmosView: CosmosView) {
    cosmosView.settings.emptyBorderWidth = value;
  }
  
  /**
   
   Returns the width of the border for an empty star.
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func getEmptyBorderWidth(_ cosmosView: CosmosView) -> Double {
    return cosmosView.settings.emptyBorderWidth;
  }
  
  
  /**
   
   Set the border color of an empty star.
   
   - parameter value: The value of the setting.
   
   - parameter inCosmosView: A CosmosView object.
   
   */
  public class func setEmptyBorderColor(value: UIColor, inCosmosView cosmosView: CosmosView) {
    cosmosView.settings.emptyBorderColor = value;
  }
  
  /**
   
   Returns the border color of an empty star.
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func getEmptyBorderColor(_ cosmosView: CosmosView) -> UIColor {
    return cosmosView.settings.emptyBorderColor;
  }
  
  
  /**
   
   Set the color of the text.
   
   - parameter value: The value of the setting.
   
   - parameter inCosmosView: A CosmosView object.
   
   */
  public class func setTextColor(value: UIColor, inCosmosView cosmosView: CosmosView) {
    cosmosView.settings.textColor = value;
  }
  
  /**
   
   Returns the color of the text.
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func getTextColor(_ cosmosView: CosmosView) -> UIColor {
    return cosmosView.settings.textColor;
  }
  
  
  
  /**
   
   Set the font of the text.
   
   - parameter value: The value of the setting.
   
   - parameter inCosmosView: A CosmosView object.
   
   */
  public class func setTextFont(value: UIFont, inCosmosView cosmosView: CosmosView) {
    cosmosView.settings.textFont = value;
  }
  
  /**
   
   Returns the font of the text.
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func getTextFont(_ cosmosView: CosmosView) -> UIFont {
    return cosmosView.settings.textFont;
  }
  
  
  /**
   
   Set the distance between the text and the stars.
   
   - parameter value: The value of the setting.
   
   - parameter inCosmosView: A CosmosView object.
   
   */
  public class func setTextMargin(value: Double, inCosmosView cosmosView: CosmosView) {
    cosmosView.settings.textMargin = value;
  }
  
  /**
   
   Returns the distance between the text and the stars.
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func getTextMargin(_ cosmosView: CosmosView) -> Double {
    return cosmosView.settings.textMargin;
  }
}
