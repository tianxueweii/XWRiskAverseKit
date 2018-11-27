# XWRiskAverseKit

[![Version](https://img.shields.io/cocoapods/v/XWRiskAverseKit.svg?style=flat)](http://cocoapods.org/pods/XWRiskAverseKit)
[![License](https://img.shields.io/cocoapods/l/XWRiskAverseKit.svg?style=flat)](http://cocoapods.org/pods/XWRiskAverseKit)
[![Platform](https://img.shields.io/cocoapods/p/XWRiskAverseKit.svg?style=flat)](http://cocoapods.org/pods/XWRiskAverseKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Introduce

The `XWRiskAverseKit` project attempt to no intrusion your code and help you to solve the common crash. You can use `Cocoapods` easy install or clone the repository by yourself. If your project has already import `Bugly`, `XWRiskAverseKit` will help you upload error info to your `Bugly`.

## Understand

Please run `$ git clone https://github.com/tianxueweii/XWRiskAverseKit.git` clone the repository to your local store and open `iOS异常处理与容错机制.key` to learn more.

## Installation

XWRiskAverseKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "XWRiskAverseKit"
```

## Use

```objc
#import "XWRiskAverseKit.h"


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{
    [[RaServiceCenter defaultCenter] open];
    return YES;
}
```

## Author

tianxueweii, 382447269@qq.com

## License

XWRiskAverseKit is available under the MIT license. See the LICENSE file for more info.
