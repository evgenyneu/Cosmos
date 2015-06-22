import UIKit
import Cosmos

class ViewController: UIViewController {
  
  @IBOutlet weak var cosmosViewFull: CosmosView!
  
  @IBOutlet weak var cosmosViewHalf: CosmosView!
  
  @IBOutlet weak var cosmosViewPrecise: CosmosView!
  
  @IBOutlet weak var ratingSlider: UISlider!
  @IBOutlet weak var ratingLabel: UILabel!
  private let startRating:Float = 3.7
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Register touch handlers
    cosmosViewFull.touchedTheStar = touchedTheStar
    cosmosViewHalf.touchedTheStar = touchedTheStar
    cosmosViewPrecise.touchedTheStar = touchedTheStar
    
    ratingSlider.value = startRating
    updateRating()
  }
  
  @IBAction func onSliderChanged(sender: AnyObject) {
    updateRating()
  }
  
  private func updateRating() {
    let value = Double(ratingSlider.value)
    cosmosViewFull.rating = value
    cosmosViewHalf.rating = value
    cosmosViewPrecise.rating = value
    
    self.ratingLabel.text = ViewController.formatValue(value)
  }
  
  private class func formatValue(value: Double) -> String {
    return String(format: "%.2f", value)
  }
  
  private func touchedTheStar(rating: Double) {
    ratingSlider.value = Float(rating)
    self.ratingLabel.text = ViewController.formatValue(rating)
  }
}