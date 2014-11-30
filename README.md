# iOS five-star raiting control written in Swift

<img src='https://dl.dropboxusercontent.com/u/11143285/bikeexchange/github_images/start-rating-view-ios-swift.png'
  alt='five star rating control for iOS written in Swift' width='320' >

## Usage

1. Copy .swift files under `start-rating-view` group into your project.
1. Add `View` control into your storyboard. Set its class to `TegStarRatingView`.
1. Add an outlet for this view in your view controller.
1. Use `show` method to displau rating:

```
ratingView.show(raiting: value, text: "(132)")
```

## Customization

Customization can be made by changing `settings` properties. For example:

```
ratingView.settings.starColorFilled = UIColor.blackColor()
ratingView.settings.starFillMode = TegStarFillMode.Precise
```