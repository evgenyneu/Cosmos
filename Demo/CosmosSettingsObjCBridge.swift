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
 
 [CosmosSettingsObjCBridge setStarSize:30 inCosmosView:self.cosmosView];
 [CosmosSettingsObjCBridge setFillMode: 0 inCosmosView: self.cosmosView];
 [CosmosSettingsObjCBridge setFilledColor: [UIColor redColor] inCosmosView:self.cosmosView];
 [CosmosSettingsObjCBridge setUpdateOnTouch: NO inCosmosView:self.cosmosView];
 
 */
@objc public class CosmosSettingsObjCBridge: NSObject {
  
  
  /**
   
   Set the star fill mode. A fill mode defines how the star is filled when the rating value is not a whole integer. It can either show full stars, half stars or stars partially filled according to the rating value.
   
   - parameter value: Value of the fill mode. 0: full, 1: half, 2: precise.
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func setFillMode(_ value: Int, inCosmosView cosmosView: CosmosView) {
    guard let fillMode = StarFillMode(rawValue: value) else { return }
    cosmosView.settings.fillMode = fillMode;
  }
  
  /**
   
   Get the star fill mode. A fill mode defines how the star is filled when the rating value is not a whole integer. It can either show full stars, half stars or stars partially filled according to the rating value.
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func getFillMode(_ cosmosView: CosmosView) -> Int {
    return cosmosView.settings.fillMode.rawValue;
  }
  
  
  
  /**
   
   When `true` the star fill level is updated when user touches the cosmos view. When `false` the Cosmos view only shows the rating and does not act as the input control.
   
   - parameter value: The value of the setting.
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func setUpdateOnTouch(_ value: Bool, inCosmosView cosmosView: CosmosView) {
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
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func setStarSize(_ value: Double, inCosmosView cosmosView: CosmosView) {
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
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func setTotalStars(_ value: Int, inCosmosView cosmosView: CosmosView) {
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
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func setStarMargin(_ value: Double, inCosmosView cosmosView: CosmosView) {
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
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func setFilledColor(_ value: UIColor, inCosmosView cosmosView: CosmosView) {
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
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func setEmptyColor(_ value: UIColor, inCosmosView cosmosView: CosmosView) {
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
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func setFilledBorderWidth(_ value: Double, inCosmosView cosmosView: CosmosView) {
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
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func setFilledBorderColor(_ value: UIColor, inCosmosView cosmosView: CosmosView) {
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
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func setEmptyBorderWidth(_ value: Double, inCosmosView cosmosView: CosmosView) {
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
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func setEmptyBorderColor(_ value: UIColor, inCosmosView cosmosView: CosmosView) {
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
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func setTextColor(_ value: UIColor, inCosmosView cosmosView: CosmosView) {
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
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func setTextFont(_ value: UIFont, inCosmosView cosmosView: CosmosView) {
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
   
   - parameter cosmosView: A CosmosView object.
   
   */
  public class func setTextMargin(_ value: Double, inCosmosView cosmosView: CosmosView) {
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
