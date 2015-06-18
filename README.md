🔨🔨🔨 This is work in progress 🔨🔨🔨

# iOS five-star rating control written in Swift

<img src='https://dl.dropboxusercontent.com/u/11143285/bikeexchange/github_images/start-rating-view-ios-swift.png'
  alt='five star rating control for iOS written in Swift' width='320' >



Binary star system of Sirius A and Sirius B (artist's impression).

Credit: [NASA](http://www.nasa.gov), [ESA](http://www.esa.int/ESA) and G. Bacon ([STScI](http://www.stsci.edu/portal/))

Source: [Hubble Space Telescope](http://www.spacetelescope.org/images/heic0516b/)

## Usage

1. Copy .swift files under `start-rating-view` group into your project.
1. Add `View` control into your storyboard. Set its class to `TegStarRatingView`.
1. Add an outlet for this view in your view controller.
1. Use `show` method to display rating:

```
ratingView.show(rating: 4, text: "(132)")
```

## Customization

Customization can be made by changing `settings` properties. For example:

```
ratingView.settings.starColorFilled = UIColor.blackColor()
ratingView.settings.starFillMode = TegStarFillMode.Precise
```

## Credits
