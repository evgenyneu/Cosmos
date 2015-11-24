# Cosmos, a star rating control for iOS and tvOS

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)][carthage]
[![CocoaPods Version](https://img.shields.io/cocoapods/v/Cosmos.svg?style=flat)][cocoadocs]
[![License](https://img.shields.io/cocoapods/l/Cosmos.svg?style=flat)](LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/Cosmos.svg?style=flat)][cocoadocs]
[cocoadocs]: http://cocoadocs.org/docsets/Cosmos
[carthage]: https://github.com/Carthage/Carthage

<img src='https://raw.githubusercontent.com/marketplacer/Cosmos/master/graphics/Screenshots/star_screenshot_dark.png' alt='Cosmos, star rating control for iOS / Swift' width='300'>

This is a UI control for iOS and tvOS written in Swift. It shows a star rating and takes rating input from the user. Cosmos is a subclass of a UIView that will allow your users post those inescapable 1-star reviews!

* Shows star rating with an optional text label.
* Can be used as a rating input control.
* Cosmos view can be customized in the Storyboard without writing code.
* Includes different star filling modes: full, half-filled and precise.
* Cosmos is accessible and works with voice-over.


<img src='https://raw.githubusercontent.com/marketplacer/Cosmos/master/graphics/Drawings/1280px-Sirius_A_and_B_artwork.jpg'
  alt="Binary star system of Sirius A and Sirius B (artist's impression)" width='450'>

*Picture of binary star system of Sirius A and Sirius B by [NASA](http://www.nasa.gov), [ESA](http://www.esa.int/ESA) and G. Bacon ([STScI](http://www.stsci.edu/portal/)). Source: [spacetelescope.org](http://www.spacetelescope.org/images/heic0516b/).*


## Setup

There are three ways you can add Cosmos to your Xcode project.

**Add source (iOS 7+)**

Simply add [CosmosDistrib.swift](https://github.com/marketplacer/Cosmos/blob/master/Distrib/CosmosDistrib.swift) file into your Xcode project.

**Setup with Carthage (iOS 8+)**

Alternatively, add `github "marketplacer/Cosmos" ~> 1.1` to your Cartfile and run `carthage update`.

**Setup with CocoaPods (iOS 8+)**

If you are using CocoaPods add this text to your Podfile and run `pod install`.

    use_frameworks!
    pod 'Cosmos', '~> 1.1'

**Setup in Xcode 6 / Swift 1.2 project**

Cosmos is written in Swift 2.0 and requires Xcode 7. Use the [previous version of the library](https://github.com/marketplacer/Cosmos/wiki/Swift-1.2-setup) in Xcode 6 projects. Thanks to [nickhart](https://github.com/nickhart) for making the Xcode 6 version.

## Usage


1) Drag `View` object from the *Object Library* into your storyboard.


<img src='https://raw.githubusercontent.com/marketplacer/Cosmos/master/graphics/Screenshots/cosmos_ios_view_control_attributes_inspector.png' width='256' alt='Add view control in attributes inspector'>


2) Set the view's class to `CosmosView` in the *Identity Inspector*. Set its *module* property to `Cosmos` if you used Carthage or CocoaPods setup methods.


<img src='https://raw.githubusercontent.com/marketplacer/Cosmos/master/graphics/Screenshots/cosmos_storyboard_class_3.png' width='259' alt='Add Cosmos rating view to the storyboard'>


3) Customize the Cosmos view appearance in the *Attributes Inspector*. If storyboard does not show the stars click **Refresh All Views** from the **Editor** menu.


<img src='https://raw.githubusercontent.com/marketplacer/Cosmos/master/graphics/Screenshots/cosmos_customize_in_storyboard.png' width='480' alt='Customize cosmos appearance in the attributes inspector in Xcode.'>

*Note*: Carthage setup method does not allow to customize Cosmos view from the storyboard, please do it from code instead.


## Using Cosmos in code

Add `import Cosmos` to your source code if you used Carthage or CocoaPods setup methods.

You can style and control Cosmos view from your code by creating an outlet in your view controller. Alternatively, one can  instantiate `CosmosView` class and add it to the view manually without using Storyboard.


```Swift
// Change the cosmos view rating
cosmosView.rating = 4

// Change the text
cosmosView.text = "(123)"

// Called when user finishes changing the rating by lifting the finger from the view.
// This may be a good place to save the rating in the database or send to the server.
cosmosView.didFinishTouchingCosmos = { rating in }

// A closure that is called when user changes the rating by touching the view.
// This can be used to update UI as the rating is being changed by moving a finger.
cosmosView.didTouchCosmos = { rating in }
```


## Customization

One can customize Cosmos from code by changing its `settings`. See the [Cosmos configuration manual](https://github.com/marketplacer/Cosmos/wiki/Cosmos-configuration) for the complete list of configuration options.

```Swift
// Show only fully filled stars
cosmosView.settings.fillMode = .Full

// Change the size of the stars
cosmosView.settings.starSize = 30

// Set the distance between stars
cosmosView.settings.starMargin = 5

// Set the color of a filled star
cosmosView.settings.colorFilled = UIColor.orangeColor()

// Set the border color of an empty star
cosmosView.settings.borderColorEmpty = UIColor.orangeColor()

// Change the rating when the view is touched
cosmosView.settings.updateOnTouch = true
```

## Demo app

This project includes a demo iOS app.

<img src='https://raw.githubusercontent.com/marketplacer/Cosmos/master/graphics/Screenshots/cosmos_star_rating.gif' alt='five star rating control for iOS written in Swift' width='250'>

## Alternative solutions

Here are some other star rating controls for iOS:

* [danwilliams64/DJWStarRatingView](https://github.com/danwilliams64/DJWStarRatingView)
* [dlinsin/DLStarRating](https://github.com/dlinsin/DLStarRating)
* [dyang/DYRateView](https://github.com/dyang/DYRateView)
* [erndev/EDStarRating](https://github.com/erndev/EDStarRating)
* [hugocampossousa/HCSStarRatingView](https://github.com/hugocampossousa/HCSStarRatingView)
* [strekfus/FloatRatingView](https://github.com/strekfus/FloatRatingView)
* [yanguango/ASStarRatingView](https://github.com/yanguango/ASStarRatingView)


## License

Cosmos is released under the [MIT License](LICENSE).

## 🌌⭐️🌕🚀🌠

> We are a way for the cosmos to know itself.

*Carl Sagan, from 1980 "Cosmos: A Personal Voyage" TV series.*
