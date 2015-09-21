import UIKit

class PerformanceTableViewController: UITableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - UITableViewDataSource
  
  override func tableView(tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
    if let cell = tableView.dequeueReusableCellWithIdentifier("performanceTableViewCell") as? PerformanceTableViewCell  {
      let rating: Double = Double(indexPath.row) / 99 * 5
      cell.update(rating)
      return cell
    }
      
    return UITableViewCell()
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }
}