import UIKit

public class PerformanceTableViewCell: UITableViewCell {
  @IBOutlet var cosmosView: CosmosView!
  
  func update(_ rating: Double) {
    cosmosView.rating = rating
  }
  
  override public func prepareForReuse() {
    // Ensures the reused cosmos view is as good as new
    cosmosView.prepareForReuse()
  }
}
