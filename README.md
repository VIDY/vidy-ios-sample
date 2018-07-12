<div align="center">
<img
  src="https://i.imgur.com/PN0fl7t.png"
  title="iOS Sample VIDY SDK"
  width="400px">
</div>


## Summary

The Vidy SDK is an iOS library that injects Social Vidys into an iOS App. It supports both Objective-C and Swift projects.

## Prerequisites
* Xcode 9.3+

## Installation

Cocoapods (recommended)
* ```pod 'ves-sample', :podspec => 'https://raw.githubusercontent.com/VIDY/vidy-ios-sample/master/ves-sample.podspec'```

Manual
1. Download the latest VDYEmbedSDK-sample zip <a href="https://github.com/VIDY/vidy-ios-sample" target="_blank">here</a> and add the framework to your project as an embedded library.
2. Add a Run Script Build Phase with the following command:
```bash "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/VDYEmbedSDK.framework/strip-frameworks.sh"```

## Use

Objective-C
```#import <VDYEmbedSDK/VDYEmbedSDK.h>```

Swift
```import VDYEmbedSDK```

### 1. Initialize SDK

Swift
```swift
VDYEmbedSDK.shared().configure([kVDYEmbedSDKConfigurationAppID : "yourAppID"])
```

### 2. Activate UILabel instances

Swift (at the moment, not supplying a postID is unsupported)
```swift
VDYEmbedSDK.shared().activate(label: label, viewController: self, displayDelegate: self)
```
#### When supplying a PostID (at the moment, this is required):
All labels that combine to form the content of the PostID must be included.

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
