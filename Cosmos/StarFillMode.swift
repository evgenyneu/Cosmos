import Foundation

/**

Defines how the star is filled when the rating is not an integer number. For example, if rating is 4.6 and the fill more is Half, the star will appear to be half filled.

*/
public enum StarFillMode: Int {
  /// Show only fully filled stars. For example, fourth star will be empty for 3.2.
  case Full = 0
  
  /// Show fully filled and half-filled stars. For example, fourth star will be half filled for 3.6.
  case Half = 1
  
  /// Fill star according to decimal rating. For example, fourth star will be 20% filled for 3.2.
  case Precise = 2
}
