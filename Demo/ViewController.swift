import UIKit
import Star

class ViewController: UIViewController {
  
  @IBOutlet weak var starRatingViewHalf: StarRatingView!
  
  @IBOutlet weak var starRatingViewOne: StarRatingView!
  
  @IBOutlet weak var starRatingViewPrecise: StarRatingView!
  
  @IBOutlet weak var ratingSlider: UISlider!
  @IBOutlet weak var ratingLabel: UILabel!
  private let startRating:Float = 3.7
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Register touch handlers
    starRatingViewOne.touchedTheStar = touchedTheStar
    starRatingViewHalf.touchedTheStar = touchedTheStar
    starRatingViewPrecise.touchedTheStar = touchedTheStar
    
    ratingSlider.value = startRating
    updateRating()
  }
  
  @IBAction func onSliderChanged(sender: AnyObject) {
    updateRating()
  }
  
  private func updateRating() {
    let value = Double(ratingSlider.value)
    starRatingViewOne.show(rating: value)
    starRatingViewHalf.show(rating: value)
    starRatingViewPrecise.show(rating: value)
  
    
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