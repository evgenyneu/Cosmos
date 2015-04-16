import UIKit

struct TegStarRatingSettings {
  init() {}
  
  var numberOfStars = 5
  
  var starFillMode = TegStarFillMode.Half
  var marginBetweenStars:CGFloat = -100 // -100 means relative to font size
  
  var starFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
  
  var starCharacterFilled = "★"
  var starCharacterEmpty = "☆"
  
  var starColorFilled = UIColor(red: 1, green: 149/255, blue: 0, alpha: 1)
  var starColorEmpty = UIColor(red: 1, green: 149/255, blue: 0, alpha: 1)
  
  var textFont = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
  var textColor = UIColor.grayColor()
  var marginBetweenStarsAndText: CGFloat = -100 // -100 means relative to font size
  
  var correctFillLevelForPreciseMode = true // Needs to be true for ★ ☆ characters.
}
