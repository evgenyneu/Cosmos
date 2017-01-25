import UIKit

/**
 
 Helper functions for dealing with right-to-left languages.
 
 */
struct RightToLeft {
  static func isRightToLeft(_ view: UIView) -> Bool {
    if #available(iOS 9.0, *) {
      return UIView.userInterfaceLayoutDirection(
        for: view.semanticContentAttribute) == .rightToLeft
    } else {
      return false
    }
  }
}
