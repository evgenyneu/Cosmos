# Cosmos version history

## 3.0.0 (2016-07-07)

Update to Xcode 8 beta 2 version of Swift.

## 2.0.0 (2016-06-20)

Update to Swift 3.0

## 1.2.3 (2016-05-28)

Fix [the issue](https://github.com/marketplacer/Cosmos/pull/27) with uploading of a TVOS app to iTunes Connect by setting EMBEDDED_CONTENT_CONTAINS_SWIFT to NO in tvOS target of the library.

## 1.2.2 (2016-03-24)

Fix stuff that was deprecated in Swift 2.2 in order to avoid warnings in Xcode 7.3.

## 1.2.0 (2016-02-20)

* [augmentedworks](https://github.com/augmentedworks) added two new fields `filledBorderColor` and `filledBorderWidth`. Before the color of the border and the filling were the same for the filled star. Now we can make them different.

* Renamed color and border properties to make them start with words 'Empty' and 'Filled'. This is done to distinguish the fields visually in the attributes inspector. Attribute inspector shows only the start of a long name and fills the rest with "dot dot dot". For example, field names  "Border color empty" and "Border color filled" both looked like "Border color..." and it was impossible to tell which one is which. Now they look like "Filled border..." and "Empty border..." and we can tell them apart in the attributes inspector.

  ### Upgrade guide from versions prior to 1.2.0

  * Rename `borderColorEmpty` to `emptyBorderColor`.
  * Rename `borderWidthEmpty` to `emptyBorderWidth`.
  * Rename `colorEmpty` to `emptyColor`.
  * Rename `colorFilled` to `filledColor`.
  * If you used storyboard to set the colors and widths you will need to set them again.
  * You may also need to fix the warnings by removing the values for the old properties like 'Color Filled' and 'Color Empty'. It can be done in the identity inspector for the view.
  * You will most likely need to set the the field `filledBorderColor` to be the same as your `colorFilled` to retain the previous look of the star.
  * If you used a non-default border width you may need to set `filledBorderWidth` as well.


## 1.1.4 (2015-11-25)

* @staticdreams added tvOS support.


## 1.1.3 (2015-11-09)

* Added `didFinishTouchingCosmos` property.

* Moved repository from https://github.com/exchangegroup/Cosmos to https://github.com/marketplacer/Cosmos.
