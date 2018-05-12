# Cosmos version history

## 16.0.0 (2018-05-12)

* Added ability to customize the Cosmos view from the interface build with Carthage setup method ([jsahoo](https://github.com/jsahoo)).


## 15.0.0 (2018-02-16)

* Added `prepareForReuse` function to help recycle Cosmos views in table cells.


## 14.0.0 (2018-01-31)

* Added ability to reuse settings in multiple cosmos views.


## 13.0.0 (2017-12-18)

* Call `didFinishTouchingCosmos` when touches are canceled (this can happen if user scrolls Cosmos in a scroll view).


## 12.0.0 (2017-09-23)

* Update for Swift 4.0 and Xcode 9.0.


## 11.0.0 (2017-07-14)

* Added ability to specify images for the stars.


## 10.0.0 (2017-06-07)

* Automatically resize the frame of the CosmosView to include the starts when it is used without Auto Layout. Thanks to [paoloq](https://github.com/paoloq) for reporting the issue and suggesting a solution.


## 9.0.0 (2017-04-08)

* Update to Swift 3.1 ([wagnersouz4](https://github.com/wagnersouz4)).

## 8.0.0 (2017-01-22)

* Improved star touch precision which is now within 1 AU.

* Added right-to-left language support (thanks, [tarek903](https://github.com/tarek903)). We may need to add non-linear language support in the future (waiting for a pull request from heptapods).


## 7.0.0 (2016-10-08)

Change `public` access-level modifiers of the `CosmosView` to `open` to allow subclassing [0x7fffffff](https://github.com/0x7fffffff).

## 6.0.0 (2016-08-27)

Update to Xcode 8 beta 6 version of Swift, thanks to [JimiSmith](https://github.com/JimiSmith).

## 5.0.0 (2016-08-13)

Update to Xcode 8 beta 4/5 version of Swift, thanks to [craiggrummitt](https://github.com/craiggrummitt).

## 4.0.0 (2016-07-24)

Update to Xcode 8 beta 3 version of Swift, thanks to [ali-zahedi](https://github.com/ali-zahedi).

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
