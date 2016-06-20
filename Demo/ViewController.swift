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
    cosmosViewFull.didTouchCosmos = didTouchCosmos
    cosmosViewHalf.didTouchCosmos = didTouchCosmos
    cosmosViewPrecise.didTouchCosmos = didTouchCosmos
    
    cosmosViewFull.didFinishTouchingCosmos = didFinishTouchingCosmos
    cosmosViewHalf.didFinishTouchingCosmos = didFinishTouchingCosmos
    cosmosViewPrecise.didFinishTouchingCosmos = didFinishTouchingCosmos
    
    ratingSlider.value = startRating
    updateRating()
  }
  
  @IBAction func onSliderChanged(_ sender: AnyObject) {
    updateRating()
  }
  
  private func updateRating() {
    let value = Double(ratingSlider.value)
    cosmosViewFull.rating = value
    cosmosViewHalf.rating = value
    cosmosViewPrecise.rating = value
    
    self.ratingLabel.text = ViewController.formatValue(value)
  }
  
  private class func formatValue(_ value: Double) -> String {
    return String(format: "%.2f", value)
  }
  
  private func didTouchCosmos(_ rating: Double) {
    ratingSlider.value = Float(rating)
    ratingLabel.text = ViewController.formatValue(rating)
    ratingLabel.textColor = UIColor(red: 133/255, green: 116/255, blue: 154/255, alpha: 1)
  }
  
  private func didFinishTouchingCosmos(_ rating: Double) {
    ratingSlider.value = Float(rating)
    self.ratingLabel.text = ViewController.formatValue(rating)
    ratingLabel.textColor = UIColor(red: 183/255, green: 186/255, blue: 204/255, alpha: 1)
  }
}
