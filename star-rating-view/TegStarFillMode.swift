import Foundation

enum TegStarFillMode {
  // Fill star according to decimal rating. For example, fourth star will be 20% filled for 3.2
  case Precise
  
  // Show fully filled and half-filled stars. For example, fourth star will be half filled for 3.6
  case Half
  
  // Show only fully filled stars. For example, fourth star will be empty for 3.2
  case Full
}
