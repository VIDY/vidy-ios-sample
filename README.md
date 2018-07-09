<div align="center">
<img
  src="https://i.imgur.com/QByDWEn.png"
  title="iOS Sample VIDY SDK"
  width="400px">
</div>


## Summary

The Vidy SDK is an iOS library that injects Social Vidys into an iOS App. It is compatible with both Objective-C and Swift projects.

## Prerequisites
* Xcode 9.3+

## Installation

Cocoapods (recommended)
* ```pod 'ves-sample', :podspec => 'https://raw.githubusercontent.com/VIDY/ios-embed-sdk-sample/master/ves-sample.podspec'```

Manual
1. Download the latest VDYEmbedSDK-sample zip <a href="https://github.com/VIDY/ios-embed-sdk-sample" target="_blank">here</a> and add the framework to your project as an embedded library.
2. Add a Run Script Build Phase with the following command:
```bash "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/VDYEmbedSDK.framework/strip-frameworks.sh"```

## Use

Objective-C
```#import <VDYEmbedSDK/VDYEmbedSDK.h>```

Swift
```import VDYEmbedSDK```

### 1. Initialize SDK
Sample-Only: We pass an array of phrases to Vidy-fy, keyed with `kVDYEmbedSDKConfigurationSAMPLEONLYPhrasesArray`. The sample SDK Vidy-fies the first instance of each phrase in each UILabel instance. Final behavior is dictated by Vidy Publisher Dashboard configuration.

Swift
```swift
VDYEmbedSDK.shared().configure([kVDYEmbedSDKConfigurationAppID : "yourAppID", kVDYEmbedSDKConfigurationSAMPLEONLYPhrasesArray : ["phrases that","i want Vidy-fied"]])
```

### 2. Activate UILabel instances

Swift
```swift
VDYEmbedSDK.shared().activate(label: label, viewController: self, displayDelegate: self)
```
#### If supplying a PostID:

Swift
```swift
VDYEmbedSDK.shared().activate(labels: [label1, label2, label3], viewController: self, postID: "yourPostID", displayDelegate: self)
```

### 3. (If applicable) use delegate callback to update layout

Swift
```swift
func vdy_containerTextChanged(_ container: UIView & VDYAttributedTextDisplay) {
    // Update layout as necessary
    view.setNeedsLayout()
}
```
