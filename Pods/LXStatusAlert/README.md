# LXStatusAlert

![Xcode 9.0+](https://img.shields.io/badge/Xcode-9.0%2B-blue.svg)
![iOS 9.0+](https://img.shields.io/badge/iOS-9.0%2B-blue.svg)
![Swift 4.0+](https://img.shields.io/badge/Swift-4.0%2B-orange.svg)
![CocoaPods Compatible](https://img.shields.io/badge/pod-1.0.0-blue.svg)  
![Platform](https://img.shields.io/badge/platform-ios-lightgray.svg)
[![License][license-image]][license-url]

LXStatusAlert is a simple alert.

![](Screenshots/LXStatusAlert-Preview.gif)


## Requirements

- Swift 4+
- iOS 9.0+
- Xcode 9+

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `LXStatusAlert` by adding it to your `Podfile`:

```ruby
pod 'LXStatusAlert'
```

## Usage

Create a 'LXStatusAlert' instance with custom image, title and duration.


```swift
let statusAlert = LXStatusAlert(image: image, title: "Add to \"Favorites\"", duration: 0.2)

statusAlert.show()
```

## Donation

If you like my open source libraries, you can sponsor it! ☺️

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.me/leonx98)

## Author

Leon Hoppe, leonhoppe98@gmail.com

## License

Distributed under the MIT license. See ``LICENSE`` for more information.


[license-image]: https://img.shields.io/badge/License-MIT-green.svg
[license-url]: LICENSE

