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

  override func viewDidLoad() {
    super.viewDidLoad()
    
    starRatingViewOne.backgroundColor = nil

    starRatingViewOne.show(raiting: 3.7, numberOfPeople: 132)
  }
}

