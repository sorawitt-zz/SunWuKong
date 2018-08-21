# SunWuKong

[![Version](https://img.shields.io/cocoapods/v/SunWuKong.svg?style=flat)](http://cocoapods.org/pods/SunWuKong)
[![License](https://img.shields.io/cocoapods/v/SunWuKong.svg?style=flat)](http://cocoapods.org/pods/SunWuKong)
[![Platform](https://img.shields.io/cocoapods/v/SunWuKong.svg?style=flat)](http://cocoapods.org/pods/SunWuKong)

## Requirements
Swift 4

iOS 9.0+

Xcode 9+

This project assumes that you have already [setup Firebase for iOS](https://firebase.google.com/docs/ios/setup).

## Installation

SunWuKong is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SunWuKong'
```

## Usage

### UIImageView
> With Storage Reference
```swift
let ref: StorageReference = ....
imageView.wk_setImage(with: ref)
```
> with placeholder, progress and completion handler
```swift
func setImageWithStorageReference() {
  let ref: StorageReference =  ....
  imageView.wk_setImage(with: ref, placeholder: UIImage(named: "placeholder"), progress: { received, total in
    // Report progress
  }, completion: { [weak self] image in
    // Do something else with the image
  })

}
```

> With URL
```swift
let url: URL = ....
imageView.wk_setImage(with: url)
```
>with placeholder, progress and completion handler

```swift
func setImageWithURL() {
  let url: URL = ....
  imageView.wk_setImage(with: url, placeholder: UIImage(named: "placeholder"), progress: { received, total in
    // Report progress
  }, completion: { [weak self] image in
    // Do something else with the image
  })

}
```

### Use the default shared cache

```swift
let ref: StorageReference = ...
SunWuKong.shared.image(with: ref) { [weak self] image in
  // do something with your image
}
```

### Create custom storage caches

```swift
let oneDaySeconds: TimeInterval = 60 * 60 * 24
let oneDayCache = DiskCache(name: "customCache", cacheDuration: oneDaySeconds)
let wukongCache = SunWuKong(cache: oneWeekDiskCache)
```

### Cleaning/pruning the cache

In the `didFinishLaunchingWithOptions` of your AppDelegate, you should call the `prune()` 
method of your disk caches to remove any old files:

```swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    SunWuKong.shared.prune()
    return true
}
```

## Author

Sorawit Trutsat, sorawit.tr@gmail.com

## License

SunWuKong is available under the MIT license. See the LICENSE file for more info.
