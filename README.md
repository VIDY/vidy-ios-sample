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

(At the moment, not supplying a postID is unsupported)
```swift
VDYEmbedSDK.shared().activate(label: label, viewController: self, displayDelegate: self)
```
#### When supplying a PostID:
(At the moment, this is required) all labels that combine to form the content of the PostID must be included.

```swift
VDYEmbedSDK.shared().activate(labels: [label1, label2, label3], viewController: self, postID: "yourPostID", displayDelegate: self)
```

### 3. BASIC - (If applicable) use delegate callback to update layout

```swift
func vdy_containerTextChanged(_ container: UIView & VDYAttributedTextDisplay) {
    // Update layout as necessary
    view.setNeedsLayout()
}
```

### 3. ADVANCED - (See example) use delegate callback to update layout when appropriate

The required `changeBlock` occurs on the main thread and is processor-intensive, thus it is wise to perform execution at a time when it will impact user interaction minimally, e.g. outside of scroll interactions. You may notify the VDYEmbedSDK that you wish to execute the `changeBlock` on your own, manually, via the following delegate method:
```swift
func vdy_container(_ container: UIView & VDYAttributedTextDisplay, shouldUpdate update: UnsafeMutablePointer<ObjCBool>!, withPendingChange changeBlock: (() -> Void)!) {
    // Notifies VDYEmbedSDK that it should not execute the changeBlock
    update.initialize(to: .init(false))

    // Attempting to execute on our own now, if allowed
    executeChangeBlocksForced(forced: false)
}
```

```swift
func vdy_containerTextChanged(_ container: UIView & VDYAttributedTextDisplay) {
    // Update layout as necessary (if applicable)
    view.setNeedsLayout()
}
```    
```swift
// This method to be called at VDYDisplayDelegate callback and UIScrollViewDelegate callbacks, when it will minimally impact the UI
func executeChangeBlocksForced(forced: Bool) {
  let allowed = forced || (!scrollView.isTracking && !scrollView.isDragging && !scrollView.isDecelerating)

  if (allowed) {
      for label in labels {
          if let changeBlock = label?.vdy_pendingChangeBlock {
              UIView.transition(with: label!, duration: 0.33, options: [.transitionCrossDissolve, .allowUserInteraction], animations: {
                  changeBlock()
              }, completion: nil)
          }
      }
  }
}
```

## Output

| On Press | Transitioning | Complete |
:-------------------------:|:-------------------------:|:-------------------------:
![](https://i.imgur.com/gIIczGm.png)|![](https://i.imgur.com/nmXlVGc.png)|![](https://i.imgur.com/kyEZ7dZ.png)
