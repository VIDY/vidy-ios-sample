<img
  src="https://i.imgur.com/Y2GILEy.png"
  title="iOS Sample VIDY SDK"
  width="100%">

# ios-sample-vidy-sdk

## Summary

The Vidy SDK is an iOS library that injects Social Vidys into an iOS App. We designed the SDK to be as minimal as possible. It doesn't require custom views, instead opting to inject Vidys into UILabel instances. Therefore, the SDK handles the brunt of the work and is as minimally-invasive as possible, while passing through the ease of implementation to the user. To embed Vidys is as simple as activate a UILabel for use.

The beauty of the SDK is that it's minimal by design. No custom views required. It works by swizzling UILabel's -drawRect: and modifying it for activated UILabel instances by drawing custom background highlighting. For all intents and purposes, all a developer needs to do is register their App ID, and in an instant your app will be updated with the Vidys you have configured in the Publisher dashboard. With a Vidy SDK-enabled app, users will not notice anything immediately different, but in actuality, they are being presented with Vidy's revolutionary minimalistic approach to advertising. No longer will users be inundated with gaudy advertisements. Now their experience will be seamless, giving power to the user to decide whether or not they want to interact with the advertisements.

## Prerequisites
* Xcode 9.3+

## Installation

Cocoapods (recommended)
* ```pod 'ves-sample', :podspec => 'https://raw.githubusercontent.com/VIDY/ios-sample-vidy-sdk/master/ves-sample.podspec'```

Manual
1. Download the latest VDYEmbedSDK-sample zip <a href="https://github.com/VIDY/ios-sample-vidy-sdk" target="_blank">here</a> and add the framework to your project as an embedded library.
2. Add a Run Script Build Phase with the following command:
```bash "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/VDYEmbedSDK.framework/strip-frameworks.sh"```

## Use

Objective-C
```#import <VDYEmbedSDK/VDYEmbedSDK.h>```

Swift
```import VDYEmbedSDK```

### 1. Initialize SDK
Sample-Only: We pass an array of phrases to Vidy-fy, keyed with `kVDYEmbedSDKConfigurationSAMPLEONLYPhrasesArray`. The sample SDK Vidy-fies the first instance of each phrase in each UILabel instance. Final behavior is dictated by Vidy Publisher Dashboard configuration.

Objective-C
```objc
[[VDYEmbedSDK sharedInstance] setConfiguration:@{ kVDYEmbedSDKConfigurationAppID : @"yourAppID", kVDYEmbedSDKConfigurationSAMPLEONLYPhrasesArray : @[ @"phrases that", @"i want Vidy-fied" ] }];
```
Swift
```swift
VDYEmbedSDK.shared().configure([kVDYEmbedSDKConfigurationAppID : "yourAppID", kVDYEmbedSDKConfigurationSAMPLEONLYPhrasesArray : ["phrases that","i want Vidy-fied"]])
```

### 2. Activate UILabel instances

Objective-C
```objc
[[VDYEmbedSDK sharedInstance] activateLabel:label viewController:self displayDelegate:self];
```
Swift
```swift
VDYEmbedSDK.shared().activate(label: label, viewController: self, displayDelegate: self)
```
#### If supplying a PostID:

Objective-C
```objc
[[VDYEmbedSDK sharedInstance] activateLabels:@[ label1, label2, label3 ] viewController:self postID:@"yourPostID", displayDelegate:self];
```
Swift
```swift
VDYEmbedSDK.shared().activate(labels: [label1, label2, label3], viewController: self, postID: "yourPostID", displayDelegate: self)
```

### 3. (If applicable) use delegate callback to update layout

Objective-C
```objc
- (void)vdy_containerTextChanged:(UIView<VDYAttributedTextDisplay> *)container {
    // Update layout as necessary
    [self.view setNeedsLayout];
}
```
Swift
```swift
func vdy_containerTextChanged(_ container: UIView & VDYAttributedTextDisplay) {
    // Update layout as necessary
    view.setNeedsLayout()
}
```
