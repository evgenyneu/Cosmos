import UIKit

class PerformanceTableViewController: UITableViewController {
  private static var rowsCount = 100
  private var ratingStorage = [Double](repeating: 0, count: rowsCount)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Assign the ratings for all stars continuously from 0 to 5
    for i in 0..<PerformanceTableViewController.rowsCount {
      ratingStorage[i] = Double(i) / 99 * 5
    }
  }
  
  // MARK: - UITableViewDataSource
  
  override func tableView(_ tableView: UITableView,
    cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
    if let cell = tableView.dequeueReusableCell(withIdentifier: "performanceTableViewCell") as? PerformanceTableViewCell  {
      // Get the rating for the star
      let rating = ratingStorage[indexPath.row]
      
      // Update star's rating
      cell.update(rating)
      
      // Store the star's rating when user lifts her finger
      cell.cosmosView.didFinishTouchingCosmos = { [weak self] rating in
        self?.ratingStorage[indexPath.row] = rating
      }
      
      return cell
    }
      
    return UITableViewCell()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return PerformanceTableViewController.rowsCount
  }
}
