# XJScanQRCode

[![CI Status](https://img.shields.io/travis/li125434104/XJScanQRCode.svg?style=flat)](https://travis-ci.org/li125434104/XJScanQRCode)
[![Version](https://img.shields.io/cocoapods/v/XJScanQRCode.svg?style=flat)](https://cocoapods.org/pods/XJScanQRCode)
[![License](https://img.shields.io/cocoapods/l/XJScanQRCode.svg?style=flat)](https://cocoapods.org/pods/XJScanQRCode)
[![Platform](https://img.shields.io/cocoapods/p/XJScanQRCode.svg?style=flat)](https://cocoapods.org/pods/XJScanQRCode)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

XJScanQRCode is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XJScanQRCode'
```
## How to user
```
//输出流视图
    UIView *preview  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:preview];
    
    self.scanView = [[XJScanView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.scanView];
    [self.scanView showFlashSwitch:YES];
    
    __weak typeof(self) weakSelf = self;
    
    self.scanTool = [[XJScanTools alloc] initWithPreview:preview andScanFrame:self.scanView.scanSweepAreaRect];
    [self.scanTool sessionStartRunning];
    self.scanTool.scanFinishedBlock = ^(NSString *scanString) {
        NSLog(@"扫描结果：%@",scanString);
        [weakSelf.scanView handlingResultsOfScan];
        [weakSelf.scanTool sessionStopRunning];
        
    };
    self.scanTool.monitorLightBlock = ^(float brightness) {
        NSLog(@"环境光感 ： %f",brightness);
        if (brightness < 0) {
            // 环境太暗，显示闪光灯开关按钮
            [weakSelf.scanView showFlashSwitch:YES];
        }else if(brightness > 0){
            // 环境亮度可以,且闪光灯处于关闭状态时，隐藏闪光灯开关
            if(!weakSelf.scanTool.flashOpen){
                [weakSelf.scanView showFlashSwitch:NO];
            }
        }
    };
```


## Author

li125434104, 125434104@qq.com

## License

XJScanQRCode is available under the MIT license. See the LICENSE file for more info.
