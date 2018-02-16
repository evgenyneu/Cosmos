# Cosmos, a star rating control for iOS and tvOS

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Version](https://img.shields.io/cocoapods/v/Cosmos.svg?style=flat)](http://cocoadocs.org/docsets/Cosmos)
[![License](https://img.shields.io/cocoapods/l/Cosmos.svg?style=flat)](LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/Cosmos.svg?style=flat)](http://cocoadocs.org/docsets/Cosmos)

<img src='https://github.com/evgenyneu/Cosmos/raw/master/graphics/Screenshots/cosmos_star_rating_control_for_ios_swift_space.png' alt='Cosmos, star rating control for iOS / Swift' width='350'>

This is a UI control for iOS and tvOS written in Swift. It shows a star rating and takes rating input from the user. Cosmos is a subclass of a UIView that will allow your users to post those inescapable 1-star reviews!

* Shows star rating with an optional text label.
* Can be used as a rating input control (iOS only).
* Cosmos view can be customized in the Storyboard without writing code.
* Includes different star filling modes: full, half-filled and precise.
* Cosmos is accessible and works with voice-over.
* Supports right-to-left languages.


<img src='https://raw.githubusercontent.com/evgenyneu/Cosmos/master/graphics/Drawings/1280px-Sirius_A_and_B_artwork.jpg'
  alt="Binary star system of Sirius A and Sirius B (artist's impression)" width='450'>

*Picture of binary star system of Sirius A and Sirius B by [NASA](http://www.nasa.gov), [ESA](http://www.esa.int/ESA) and G. Bacon ([STScI](http://www.stsci.edu/portal/)). Source: [spacetelescope.org](http://www.spacetelescope.org/images/heic0516b/).*


## Setup

There are three ways you can add Cosmos to your Xcode project.

#### Add source (iOS 8+)

Simply add [CosmosDistrib.swift](https://github.com/evgenyneu/Cosmos/blob/master/Distrib/CosmosDistrib.swift) file into your Xcode project.

#### Setup with Carthage (iOS 8+)

Alternatively, add `github "evgenyneu/Cosmos" ~> 15.0` to your Cartfile and run `carthage update`.

#### Setup with CocoaPods (iOS 8+)

If you are using CocoaPods add this text to your Podfile and run `pod install`.

    use_frameworks!
    target 'Your target name'
    pod 'Cosmos', '~> 15.0'


#### Legacy Swift versions

Setup a [previous version](https://github.com/evgenyneu/Cosmos/wiki/Legacy-Swift-versions) of the library if you use an older version of Swift.


## Usage


1) Drag `View` object from the *Object Library* into your storyboard.


<img src='https://raw.githubusercontent.com/evgenyneu/Cosmos/master/graphics/Screenshots/cosmos_ios_view_control_attributes_inspector.png' width='256' alt='Add view control in attributes inspector'>


2) Set the view's class to `CosmosView` in the *Identity Inspector*. Set its *module* property to `Cosmos` if you used Carthage or CocoaPods setup methods.


<img src='https://raw.githubusercontent.com/evgenyneu/Cosmos/master/graphics/Screenshots/cosmos_storyboard_class_3.png' width='259' alt='Add Cosmos rating view to the storyboard'>

*tvOS note*: read the collowing [setup instructions for tvOS](https://github.com/evgenyneu/Cosmos/wiki/tvOS-CocoaPods-error) if you see build errors at this stage.


3) Customize the Cosmos view appearance in the *Attributes Inspector*. If storyboard does not show the stars click **Refresh All Views** from the **Editor** menu.


<img src='https://raw.githubusercontent.com/evgenyneu/Cosmos/master/graphics/Screenshots/cosmos_customize_in_storyboard_2.png' width='502' alt='Customize cosmos appearance in the attributes inspector in Xcode.'>

*Note*: Carthage setup method does not allow to customize Cosmos view from the storyboard, please do it from code instead.

## Positioning the Cosmos view

One can position the Cosmos view using Auto Layout constaints. The width and height of the view is determined automatically based on the size of its content - stars and text. Therefore, there is no need to set width/height constaints on the Cosmos view.

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

One can customize Cosmos from code by changing its `settings`. See the [Cosmos configuration manual](https://github.com/evgenyneu/Cosmos/wiki/Cosmos-configuration) for the complete list of configuration options.

```Swift
// Do not change rating when touched
// Use if you need just to show the stars without getting user's input
cosmosView.settings.updateOnTouch = false

// Show only fully filled stars
cosmosView.settings.fillMode = .full
// Other fill modes: .half, .precise

// Change the size of the stars
cosmosView.settings.starSize = 30

// Set the distance between stars
cosmosView.settings.starMargin = 5

// Set the color of a filled star
cosmosView.settings.filledColor = UIColor.orange

// Set the border color of an empty star
cosmosView.settings.emptyBorderColor = UIColor.orange

// Set the border color of a filled star
cosmosView.settings.filledBorderColor = UIColor.orange
```



## Supplying images for the stars

By default, Cosmos draws the stars from an array of points. Alternatively, one can supply custom images for the stars, both in the Storyboard and from code.

#### Using star images from the Storyboard

<img src='https://github.com/evgenyneu/Cosmos/raw/master/graphics/Screenshots/cosmos_ios_supplying_images_storyboard.png' width='514' alt='Supplying an image for a star in Xcode.'>

#### Using star images from code

```Swift
// Set image for the filled star
cosmosView.settings.filledImage = UIImage(named: "GoldStarFilled")

// Set image for the empty star
cosmosView.settings.emptyImage = UIImage(named: "GoldStarEmpty")
```
Note: you need to have the images for the filled and empty star in your project for this code to work.

#### Download star image files

Images for the golden star used in the demo app are available in [here](https://github.com/evgenyneu/Cosmos/tree/master/graphics/Stars/GoldStar). Contributions for other star images are very welcome: add vector images to `/graphics/Stars/` directory and submit a pull request.


## Using Cosmos in a scroll/table view

[Here](https://github.com/evgenyneu/Cosmos/wiki/Using-Cosmos-in-a-scroll-view) is how to use Cosmos in a scroll view or a table view.

## Using Cosmos settings from Objective-C

[This manual](https://github.com/evgenyneu/Cosmos/wiki/Using-Cosmos-settings-in-Objective-C) describes how to set/read Cosmos settings in Objective-C apps.

## Demo app

This project includes a demo iOS app.

<img src='https://raw.githubusercontent.com/evgenyneu/Cosmos/master/graphics/Screenshots/cosmos_star_rating.gif' alt='Five star rating control for iOS written in Swift' width='250'>

#### Using cosmos in a table view

<img src='https://raw.githubusercontent.com/evgenyneu/Cosmos/master/graphics/Screenshots/cosmos_star_rating_swift_performance.gif' alt='Using cosmos in a table view' width='250'>



## Alternative solutions

Here are some other star rating controls for iOS:

* [danwilliams64/DJWStarRatingView](https://github.com/danwilliams64/DJWStarRatingView)
* [dlinsin/DLStarRating](https://github.com/dlinsin/DLStarRating)
* [dyang/DYRateView](https://github.com/dyang/DYRateView)
* [erndev/EDStarRating](https://github.com/erndev/EDStarRating)
* [hugocampossousa/HCSStarRatingView](https://github.com/hugocampossousa/HCSStarRatingView)
* [shuhrat10/STRatingControl](https://github.com/shuhrat10/STRatingControl)
* [strekfus/FloatRatingView](https://github.com/strekfus/FloatRatingView)
* [yanguango/ASStarRatingView](https://github.com/yanguango/ASStarRatingView)

## Thanks 👍

We would like to thank the following people for their valuable contributions.

* [0x7fffffff](https://github.com/0x7fffffff) for changing `public` access-level modifiers to `open`.
* [ali-zahedi](https://github.com/ali-zahedi) for updating to the latest version of Swift 3.0.
* [augmentedworks](https://github.com/augmentedworks) for adding borders to filled stars.
* [craiggrummitt](https://github.com/craiggrummitt) for Xcode 8 beta 4 support.
* [JimiSmith](https://github.com/JimiSmith) for Xcode 8 beta 6 support.
* [nickhart](https://github.com/nickhart) for adding compatibility with Xcode 6.
* [staticdreams](https://github.com/staticdreams) for bringing tvOS support.
* [wagnersouz4](https://github.com/wagnersouz4) for Swift 3.1 update.
* [paoloq](https://github.com/paoloq) for reporting the CosmoView frame size issue when the view is used without Auto Layout.
* [danshevluk](https://github.com/danshevluk) for adding ability to reuse settings in multiple cosmos views.
* [xrayman](https://github.com/xrayman) for reporting a table view reusability bug and improving the table view screen of the demo app.


## License

Cosmos is released under the [MIT License](LICENSE).

## 🌌⭐️🌕🚀🌠

> We are a way for the cosmos to know itself.

*Carl Sagan, from 1980 "Cosmos: A Personal Voyage" TV series.*
