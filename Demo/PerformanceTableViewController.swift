import UIKit

class PerformanceTableViewController: UITableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - UITableViewDataSource
  
  override func tableView(_ tableView: UITableView,
    cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
    if let cell = tableView.dequeueReusableCell(withIdentifier: "performanceTableViewCell") as? PerformanceTableViewCell  {
      let rating: Double = Double((indexPath as NSIndexPath).row) / 99 * 5
      cell.update(rating)
      return cell
    }
      
    return UITableViewCell()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }
}
