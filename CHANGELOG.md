# Cosmos version history

## 1.2.0 (2016-02-20)

* [augmentedworks](https://github.com/augmentedworks) added two new fields `filledBorderColor` and `filledBorderWidth`. Before the color of the border and the filling were the same for the filled star. Now we can make them different.

* Renamed color and border properties to make them start with words 'Empty' and 'Filled'. This is done to distinguish the fields visually in the attributes inspector. Attribute inspector shows only the start of a long name and fills the rest with "dot dot dot". For example, field names  "Border color empty" and "Border color filled" both looked like "Border color..." and it was impossible to tell which one is which. Now they look like "Filled border..." and "Empty border..." and we can tell them apart in the attributes inspector.

  **Upgrade guide from versions prior to 1.2.0**. Rename the fields the following way if you used them in code. One will also need to set their colors in the attributes inspector.

  * `borderColorEmpty` -> `emptyBorderColor`
  * `borderWidthEmpty` -> `emptyBorderWidth`
  * `colorEmpty` -> `emptyColor`
  * `colorFilled` -> `filledColor`


## 1.1.4 (2015-11-25)

* @staticdreams added tvOS support.


## 1.1.3 (2015-11-09)

* Added `didFinishTouchingCosmos` property.

* Moved repository from https://github.com/exchangegroup/Cosmos to https://github.com/marketplacer/Cosmos.
