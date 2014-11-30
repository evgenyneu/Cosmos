//
//  ViewController.swift
//  star-rating-view
//
//  Created by Evgenii Neumerzhitckii on 28/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var starRatingViewOne: TegStarRatingView!

  @IBOutlet weak var starRatingViewHalf: TegStarRatingView!
  
  @IBOutlet weak var starRatingViewPrecise: TegStarRatingView!
  
  @IBOutlet weak var ratingSlider: UISlider!
  @IBOutlet weak var ratingLabel: UILabel!
  private let startRating:Float = 3.7
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ratingSlider.value = startRating
    
    starRatingViewOne.backgroundColor = nil
    starRatingViewHalf.backgroundColor = nil
    starRatingViewPrecise.backgroundColor = nil
    
    starRatingViewOne.starFillMode = TegStarFillMode.Full
    starRatingViewHalf.starFillMode = TegStarFillMode.Half
    starRatingViewPrecise.starFillMode = TegStarFillMode.Precise
    
    updateRating()
  }
  
  private func updateLabel() {
    
  }
  
  @IBAction func onSliderChanged(sender: AnyObject) {
    updateRating()
  }
  
  private func updateRating() {
    let value = Double(ratingSlider.value)
    starRatingViewOne.show(raiting: value)
    starRatingViewHalf.show(raiting: value, text: "(132)")
    starRatingViewPrecise.show(raiting: value)
    
    self.ratingLabel.text = ViewController.formatValue(value)
  }
  
  private class func formatValue(value: Double) -> String {
    return String(format: "%.2f", value)
  }
}

