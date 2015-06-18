import Foundation

/**

Defines how the star is filled when the rating is not an integer number. For example, if raiting is 4.6 and the fill more is Half, the star will appear to be half filled.

*/
public enum TegStarFillMode {
  /// Fill star according to decimal rating. For example, fourth star will be 20% filled for 3.2. By default the fill rate is not applied linearly but corrected (see correctFillLevelForPreciseMode setting).
  case Precise
  
  /// Show fully filled and half-filled stars. For example, fourth star will be half filled for 3.6.
  case Half
  
  /// Show only fully filled stars. For example, fourth star will be empty for 3.2.
  case Full
}
