import UIKit

public class PerformanceTableViewCell: UITableViewCell {
  @IBOutlet var cosmosView: CosmosView!
  
  func update(rating: Double) {
    cosmosView.rating = rating
  }
}
