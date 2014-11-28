//
//  TegStarRatingType.swift
//  star-rating-view
//
//  Created by Evgenii Neumerzhitckii on 28/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import Foundation

enum TegStarRatingType: Int {
  case Filled
  case Half
  case Empty

  static func starType(ratingRemainder: Double) -> TegStarRatingType {
    if ratingRemainder >= 0 { return TegStarRatingType.Filled }
    if ratingRemainder == -0.5 { return TegStarRatingType.Half }
    return TegStarRatingType.Empty
  }
}