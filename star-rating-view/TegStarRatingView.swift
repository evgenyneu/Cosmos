//
//  StarRatingView.swift
//  star-rating-view
//
//  Created by Evgenii Neumerzhitckii on 28/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class TegStarRatingView: UIView {

  let numberOfStars = 5

  var marginBetweenStars:CGFloat = 10
  var starFont = UIFont.boldSystemFontOfSize(19)
  var starColor = UIColor(red: 1, green: 149/255, blue: 0, alpha: 1)

  func setup() {
  }

  func show(#raiting: Double, numberOfPeopleWhoRated: Int) {
    let starLayers = TegStarRating.createStarLayers(raiting, numberOfStars: numberOfStars,
      font: starFont, color: starColor, marginBetweenStars: marginBetweenStars)

    layer.sublayers = starLayers
  }
}
